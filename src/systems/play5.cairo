use starknet::{ContractAddress};



#[starknet::interface]
pub trait IGamesystem<TState> {
  fn initialize(ref self: TState, prover_address: ContractAddress, vrf_address: ContractAddress);
    fn start_match(ref self: TState, match_id: felt252);
}


#[starknet::interface]
pub trait IAccountABI<TState> {
    fn is_valid_signature(self: @TState, hash: felt252, signature: Array<felt252>) -> felt252;

    // ISRC6CamelOnly
    fn isValidSignature(self: @TState, hash: felt252, signature: Array<felt252>) -> felt252;
}



#[dojo::contract]
pub mod Gamesystem {
    use starknet::{ContractAddress, get_caller_address, get_contract_address};
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
            self.world(@"play5s")
        }

    }

    #[abi(embed_v0)]
    impl GamesystemImpl of IGamesystem<ContractState> {
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


      
        fn start_match(ref self: ContractState, match_id: felt252) {
            let mut world = InternalImpl::world_default(@self);
            let caller = get_caller_address();
        }
    }
}