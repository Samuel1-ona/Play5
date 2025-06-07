use starknet::{ContractAddress};

#[derive(Copy, Drop, Serde, Debug)]
#[dojo::model]
pub struct UsedSignature {
    #[key]
    pub msg_hash: felt252,
    pub is_used: bool,
}

#[derive(Copy, Drop, Serde, Debug)]
#[dojo::model]
pub struct prover {
    #[key]
    pub system: ContractAddress,
    pub address: ContractAddress,
}
