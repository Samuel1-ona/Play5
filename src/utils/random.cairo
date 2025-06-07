use cartridge_vrf::{IVrfProviderDispatcher, IVrfProviderDispatcherTrait, Source};
use starknet::{ContractAddress, contract_address_const, get_caller_address, get_block_number};
use core::hash::{HashStateTrait, HashStateExTrait};
use core::pedersen::PedersenTrait;


fn get_vrf_address() -> ContractAddress {
    contract_address_const::<0x051fea4450da9d6aee758bdeba88b2f665bcbf549d2c61421aa724e9ac0ced8f>()
}

pub fn get_random_hash() -> felt252 {
    let vrf_provider = IVrfProviderDispatcher { contract_address: get_vrf_address() };
    vrf_provider.consume_random(Source::Nonce(get_caller_address()))
}