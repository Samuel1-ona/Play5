use starknet::{ContractAddress};

#[starknet::interface]
pub trait IPlay5 <TState>{
    fn initializer(ref self: TState, Prover_address: ContractAddress,vrf_address: ContractAddress);
}


