use cartridge_vrf::{IVrfProviderDispatcher, IVrfProviderDispatcherTrait, Source};
use starknet::{ContractAddress, contract_address_const, get_caller_address, get_block_number, };
use core::hash::{HashStateTrait, HashStateExTrait};
use core::pedersen::PedersenTrait;
use play5::models::football::{SelectedSkill, SkilsOrFouls};


fn get_vrf_address() -> ContractAddress {
    contract_address_const::<0x051fea4450da9d6aee758bdeba88b2f665bcbf549d2c61421aa724e9ac0ced8f>()
}

pub fn get_random_hash() -> felt252 {
    let vrf_provider = IVrfProviderDispatcher { contract_address: get_vrf_address() };
    vrf_provider.consume_random(Source::Nonce(get_caller_address()))
}

// This function get the random index of all the  football skills 

 pub fn get_random_index_football_skills(random_index: felt252, seed: u16, max_index: u16) -> u16 {
    let block_number = get_block_number();
    let mut state = PedersenTrait::new(0);
    state = state.update_with(random_index);
    state = state.update_with(seed);
    state = state.update_with(block_number);

    let hash: u256 = state.finalize().into();
    let index = (hash % max_index.into());
    let index_u16: u16 = index.try_into().unwrap();
    if index_u16 < max_index {
        return index_u16;
    } else {
        panic!("Index out of range for football skills");
    }

    index_u16
}

 // This function get the random index of all the  football fouls
pub fn get_random_index_football_fouls(random_index: felt252, seed: u16, max_index: u16) -> u16 {
    let block_number = get_block_number();
    let mut state = PedersenTrait::new(0);
    state = state.update_with(random_index);
    state = state.update_with(seed);
    state = state.update_with(block_number);

    let hash: u256 = state.finalize().into();
    let index = (hash % max_index.into());
    let index_u16: u16 = index.try_into().unwrap();
    if index_u16 < max_index {
        return index_u16;
    } else {
        panic!("Index out of range for football fouls");
    }

    index_u16
}


pub fn get_random_football_skills_from_selected_skills(
    selected_skills: Span<SelectedSkill>,
    random_index: felt252,
) -> SelectedSkill {

    let mut can_recieve_skills = ArrayTrait::new();
    let mut i: u32 = 0;
    while i < selected_skills.len() {
        let skill = *selected_skills.at(i);
        let mut count: u8 = 1;
        let mut j: u32 = 0;
        while j < selected_skills.len() {
            if i != j && skill == *selected_skills.at(j) {
                count += 1;
            }
            j += 1;
        };

        if count <= 8 {
            can_recieve_skills.append(skill);
        }
        i += 1;

    };

    assert!(can_recieve_skills.len() > 0, "No skills available to receive");

    let block_number = get_block_number();
    let mut state = PedersenTrait::new(0);
    state = state.update_with(random_index);
    state = state.update_with(can_recieve_skills.len());
    state = state.update_with(block_number);
    let hash: u256 = state.finalize().into();
    let index = (hash % can_recieve_skills.len().into());
    return *can_recieve_skills.at(index.try_into().unwrap());

}





