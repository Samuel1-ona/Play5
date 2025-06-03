use starknet::{ContractAddress};

#[derive(Copy, Drop, Serde, Introspect, Debug)]
struct Players {
    pub player_id: u32,
    pub players: ContractAddress,
    pub position: Position,
}

#[derive(Copy, Drop, Serde, Introspect, Debug)]
struct Position {
    pub x: u32,
    pub y: u32,
}

#[derive(Copy, Drop, Serde, Introspect, Debug)]
struct Velocity {
    pub x: i32,
    pub y: i32,
}

#[derive(Drop, Serde, Debug)]
#[dojo::model]
struct Team {
    #[key]
    pub team_id: u32,
    pub score: u32,
    pub players: Array<Players>,
}

#[derive(Copy, Drop, Serde, Debug)]
#[dojo::model]
struct Match {
    #[key]
    pub status: u8,
    pub time: u8,
    pub score_team1: u32,
    pub score_team2: u32,
}


#[derive(Copy, Drop, Serde, Introspect, Debug)]
struct SelectSkills {
    pub skills: felt252,
    pub index: u32,
}

