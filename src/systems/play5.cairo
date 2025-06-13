use starknet::{ContractAddress};



#[starknet::interface]
pub trait IGamesystem<TState> {
  fn initialize(ref self: TState, prover_address: ContractAddress, vrf_address: ContractAddress);
    fn start_match(ref self: TState, match_id: u32);
   
}


#[starknet::interface]
pub trait IAccountABI<TState> {
    fn is_valid_signature(self: @TState, hash: felt252, signature: Array<felt252>) -> felt252;

    // ISRC6CamelOnly
    fn isValidSignature(self: @TState, hash: felt252, signature: Array<felt252>) -> felt252;
}



#[dojo::contract]
pub mod Gamesystem {
    use starknet::{ContractAddress, get_caller_address, get_contract_address, get_tx_info};
    use core::num::traits::Zero;
    use cartridge_vrf::{Source, IVrfProviderDispatcher, IVrfProviderDispatcherTrait};
    use dojo::model::{ModelStorage, ModelValueStorage};
    use dojo::event::EventStorage;
    use dojo::world::{IWorldDispatcherTrait, IWorldDispatcher};
    use core::hash::{HashStateTrait, HashStateExTrait};
    use core::poseidon::PoseidonTrait;
    use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};

    use play5::models::football::{
        CommonSkills, CommonFouls, Players, PlayerSkill, FoulLog, Position, Velocity, SelectedSkill, Team, Goal, Match
    };
    use play5::utils::footballskills::{
        index_to_football_fouls, index_to_football_skils, index_to_fouls_actions,
        common_skills_to_index, common_fouls_to_index, common_fouls_actions_to_index
    };
    use play5::utils::random::{
        get_random_football_skills_from_selected_skills, get_random_index_football_fouls,
        get_random_index_football_skills, map_random_fouls_from_action, check_skills_is_selected
    };
    use play5::utils::signature::{
        compute_message_hash_for_prover_skills, compute_message_hash_for_prover_fouls
    };
    use play5::constant::{
        PlayerCommonFoulsParam, PlayerCommonSkillsParam, DEFAULT_NS, MAX_INDEX_OF_COMMON_SKILLS, MAX_INDEX_OF_COMMON_FOULS
    };
    use play5::models::signature::{Prover, UsedSignature};

    use super::{IGamesystem, IAccountABI};

    #[storage]
    pub struct Storage {
        vrf_address: ContractAddress,
    }

    #[generate_trait]
    impl InternalImpl of InternalTrait {
        fn world_default(self: @ContractState) -> dojo::world::WorldStorage {
            self.world(@DEFAULT_NS())
        }

    }

    #[derive(Copy, Drop, Serde)]
    #[dojo::event]
    struct MatchStarted {
        #[key]
        team1_id: u32,
        #[key]
        team2_id: u32,
        match_id: u32,
        timestamp: u64
    }

    #[abi(embed_v0)]
    impl GamesystemImpl of IGamesystem<ContractState> {
      // Needs to be worked on 
      fn initialize(
        ref self: ContractState, prover_address: ContractAddress, vrf_address: ContractAddress
    ) {
      let mut world = InternalImpl::world_default(@self);

        self.vrf_address.write(vrf_address);
        let caller = get_caller_address();
        let mut prover: Prover = world.read_model(get_contract_address());
        assert(prover.address.is_zero(), 'prover already initialized');
        prover.address = prover_address;
        world.write_model(@prover);
    }

   

    fn start_match(ref self: ContractState, match_id: u32) {
        let mut world = InternalImpl::world_default(@self);
        let caller = get_caller_address();

        // check if the caller is the players 
        let mut players: Players = (Players { player_id: 1, team_id: 1 , player: caller, player_skills: ArrayTrait::new(), tx_hash: get_tx_info().transaction_hash});
        assert(players.player == caller, 'Caller is not the players');

        // check if the team was created by the caller
        let mut team1_data: Team = (Team { team_id: 1 , player: caller, players_id: 1, match_id: 1, score: 0, tx_hash: get_tx_info().transaction_hash});
        assert(team1_data.player == caller, 'Caller is not the team');


        // Read the match data
        let mut match_data: Match = world.read_model(match_id);

        // Read the team data 

        let mut team1_data: Team = world.read_model(match_data.team1_id);
        let mut team2_data: Team = world.read_model(match_data.team2_id);

       // Todo: check if the team was created by the caller

        // verify the team has enough players
        assert(team1_data.players_id == 5, 'Team 1 needs 5 players');
        assert(team2_data.players_id == 5, 'Team 2 needs 5 players');

        // Verify match exists and is in a valid state to start
        assert(match_data.status == 0, 'Match has Not started');
        
        // Validate match scheduling (check if current time is within allowed window)
        let current_time = starknet::get_block_timestamp();
        assert(current_time >= match_data.time, 'Match cannot start Now');
        assert(
            current_time <= match_data.time + 3600, // 1 hour window
            'Match start time has expired'
        );
        
        // Update match status to In Progress (1)
        match_data.status = 1;
        match_data.time = 0;
        match_data.score_team1 = 0;
        match_data.score_team2 = 0;
        
        
        // Write the updated match data back
        world.write_model(@match_data);

        // Emit match start event
        world.emit_event(@MatchStarted {
            match_id: match_id,
            team1_id: match_data.team1_id,
            team2_id: match_data.team2_id,
            timestamp: starknet::get_block_timestamp()
        });
    }
}
}