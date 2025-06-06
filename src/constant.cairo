use starknet::{get_tx_info, ContractAddress}

#[derive(Copy , Drop, Hash)]
pub struct StarknetDomain{
    pub name: felt252,
    pub version: felt252,
    pub chain_id: felt252
}


#[derive(Copy , Drop, Hash)]
pub PlayerCommonSkillsParam {
    pub player: ContractAddress,
    pub salt_nonce: u64,
    pub is_new_match: bool,
    pub is_skills: bool
}


#[derive(Copy , Drop, Hash)]
pub PlayerCommonFoulsParam {
    pub player: ContractAddress,
    pub salt_nouce: u64,
    pub is_new_match: bool,
    pub is_fouls: bool
}

pub const MAX_INDEX_OF_COMMON_SKILLS: u16 = 10;

pub const MAX_INDEX_OF_COMMON_FOULS: u16 = 5;

pub const STARKNET_DOMAIN_TYPE_HASH: felt252 =
    selector!("StarkNetDomain(name:felt,version:felt,chainId:felt)");


pub const PLAYER_COMMON_SKILLS_TYPE_HASH: felt252 = 
     selector!("PlayerCommonSkillsParam(player:felt, salt_nonce:felt, is_new_match:bool, is_skills:bool)");



pub const PLAYER_COMMON_FOULS_TYPE_HASH: felt252 = 
     selector!("PlayerCommonFoulsParam(player:felt, salt_nonce:felt, is_new_match:bool, is_fouls:bool)");   





pub const STARKNET_DOMAIN_VERSION: felt252 = 1;

pub fn DEFAULT_DOMAIN() -> StarknetDomain {
    StarknetDomain {
        name: 'play5',
        version: STARKNET_DOMAIN_VERSION,
        chain_id: get_tx_info().unbox().chain_id
    }
}

pub fn DEFAULT_NS() -> ByteArray {
    "p5"
}       

