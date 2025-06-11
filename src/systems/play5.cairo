
#[dojo::contract]
pub mod play5 {
  use starknet::{ContractAddress, get_caller_address, get_contract_address};
  use core::num::traits::Zero;
  use cartridge_vrf::{Source, IVrfProviderDispatcher, IVrfProviderDispatcherTrait};
  use dojo::model::{ModelStorage, ModelValueStorage};
  use dojo::event::{Event, EventStorage};
  use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
  use core::hash::{HashStateTrait,HashStateExTrait};
  use core::poseidon::PoseidonTrait;
  use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};


  // Game imports
  use play5::interface::{IAccountABI, IPlay5};
  use play5::models::football::{CommonSkills, CommonFouls, Players, PlayerSkill, FoulLog, Position, Velocity, SelectedSkill,Team, Goal
  , Match};
  use play5::utils::footballskills::{index_to_football_fouls,index_to_football_skils,index_to_fouls_actions, common_skills_to_index, common_fouls_to_index, common_fouls_actions_to_index};
  use play5::utils::random::{get_random_football_skills_from_selected_skills,get_random_index_football_fouls,get_random_index_football_skills,map_random_fouls_from_action,check_skills_is_selected};
  use play5::utils::signature::{compute_message_hash_for_prover_skills,compute_message_hash_for_prover_fouls};
  use play5::constant::{PlayerCommonFoulsParam,PlayerCommonSkillsParam,DEFAULT_NS,MAX_INDEX_OF_COMMON_SKILLS,MAX_INDEX_OF_COMMON_FOULS};
  use play5::models::signature::{prover,UsedSignature};























    #[storage]
    pub struct Storage {
        vrf_address: ContractAddress,
    } 
}





