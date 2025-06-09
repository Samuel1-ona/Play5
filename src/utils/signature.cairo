use core::hash::{HashStateTrait, HashStateExTrait};
use core::pedersen::PedersenTrait;
use starknet::{ContractAddress};
use play5::constant::{StarknetDomain, STARKNET_DOMAIN_TYPE_HASH, PLAYER_COMMON_SKILLS_TYPE_HASH, PLAYER_COMMON_FOULS_TYPE_HASH,DEFAULT_DOMAIN,
PlayerCommonSkillsParam,PlayerCommonFoulsParam};


pub fn hash_domain(domain: @StarknetDomain) -> felt252 {
    let mut state = PedersenTrait::new(0);
    state = state.update_with(STARKNET_DOMAIN_TYPE_HASH);
    state = state.update_with(*domain);
    state = state.update_with(4);
    state.finalize()
}


pub fn hash_player_common_skills_param(player_common_skills: @PlayerCommonSkillsParam) -> felt252 {
    let mut state = PedersenTrait::new(0);
    state = state.update_with(PLAYER_COMMON_SKILLS_TYPE_HASH);
    state = state.update_with(*player_common_skills);
    state = state.update_with(5);
    state.finalize()
}

pub fn hash_player_common_fouls_param(player_common_fouls: @PlayerCommonFoulsParam) -> felt252 {
    let mut state = PedersenTrait::new(0);
    state = state.update_with(PLAYER_COMMON_FOULS_TYPE_HASH);
    state = state.update_with(*player_common_fouls);
    state = state.update_with(4);
    state.finalize()
}


pub fn compute_message_hash_for_prover_skills(skills_data: @PlayerCommonSkillsParam, prover: ContractAddress) -> felt252 {
    let domain = DEFAULT_DOMAIN();
    let domain_hash = hash_domain(@domain);
    
    let skills_hash = hash_player_common_skills_param(skills_data);

    let mut state = PedersenTrait::new(0);
    state = state.update_with('Starjnet message');
    state = state.update_with(domain_hash);
    state = state.update_with(skills_hash);
    state = state.update_with(prover);
    state = state.update_with(5);
    
    state.finalize()
}
pub fn compute_message_hash_for_prover_fouls(fouls_data: @PlayerCommonFoulsParam, prover: ContractAddress) -> felt252 {
    let domain = DEFAULT_DOMAIN();
    let domain_hash = hash_domain(@domain);
    
    let fouls_hash = hash_player_common_fouls_param(fouls_data);

    let mut state = PedersenTrait::new(0);
    state = state.update_with('Starjnet message');
    state = state.update_with(domain_hash);
    state = state.update_with(fouls_hash);
    state = state.update_with(prover);
    state = state.update_with(5);
    
    state.finalize()
}