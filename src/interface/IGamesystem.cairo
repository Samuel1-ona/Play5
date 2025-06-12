use starknet::{ContractAddress};

#[starknet::interface]
pub trait IGamesystem<TContractState> {
    fn initializer(ref self: TContractState, Prover_address: ContractAddress, vrf_address: ContractAddress);
}


