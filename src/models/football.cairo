use starknet::{ContractAddress};

#[derive(Drop, Serde, Debug)]
#[dojo::model]
pub struct Players {
    #[key]
    pub player_id: u32,
    #[key]
    pub player: ContractAddress,
    pub player_skills: Array<SelectedSkill>,
    pub team_id: u32,
    pub tx_hash: felt252,
}


#[derive(Copy, Drop, Serde, Debug)]
#[dojo::model]
pub struct PlayerSkill {
    #[key]
    pub player_id: u32,
    #[key]
    pub skills: CommonSkills,
    pub level: u8, // Optional: 1–100 or 1–10 scale
    pub tx_hash: felt252,
}


#[derive(Drop, Serde, Debug)]
#[dojo::model]
pub struct FoulLog {
    #[key]
    pub foul_id: u32,
    #[key]
    pub player_id: u32,
    pub match_id: u32,
    pub timestamp: u32,
    pub foul_type: CommonFouls,
    pub tx_hash: felt252,
}


#[derive(Copy, Drop, Serde, Debug)]
#[dojo::model]
pub struct Position {
    #[key]
    pub player_id: u32,
    pub x: u32,
    pub y: u32,
    pub tx_hash: felt252,
}

#[derive(Copy, Drop, Serde, Debug)]
#[dojo::model]
pub struct Velocity {
    #[key]
    pub player_id: u32,
    pub x: i32,
    pub y: i32,
    pub tx_hash: felt252,
}

#[derive(Drop, Serde, Debug)]
#[dojo::model]
pub struct Team {
    #[key]
    pub team_id: u32,
    pub player: ContractAddress,
    pub players_id: u32,
    pub match_id: u32,
    pub score: u32,
    pub tx_hash: felt252,
}

#[derive(Drop, Serde, Debug)]
#[dojo::model]
pub struct Goal {
    #[key]
    pub goal_id: u32, // Unique ID for goal
    pub match_id: u32,
    pub team_id: u32, // The team that scored
    pub player_id: u32, // Player who scored
    pub timestamp: u32, // When goal happened in seconds
    pub tx_hash: felt252,
}

#[derive(Drop, Serde, Debug)]
#[dojo::model]
pub struct Match {
    #[key]
    pub match_id: u32,
    pub status: u8, // 0 = Not Started, 1 = In Progress, 2 = Ended
    pub time: u64, // Match time in seconds
    pub score_team1: u32,
    pub score_team2: u32,
    pub team1_id: u32,
    pub team2_id: u32,
    pub tx_hash: felt252,
}


#[derive(Copy, Drop, Serde, PartialEq, Debug)]
#[dojo::model]
pub struct SelectedSkill {
    #[key]
    pub index: u32,
    pub skills: felt252,
}

#[derive(Drop, Copy, Serde, PartialEq, Introspect, Debug)]
pub enum SkilsOrFouls {
    FootballSkills,
    FootballFouls,
}

#[derive(Drop, Copy, Serde, PartialEq, Introspect, Debug)]
pub enum CommonSkills {
    Pass,
    Shoot,
    Dribble,
    Tackle,
    Sprint,
    Intercept,
    Save,
    Cross,
    ThroughBall,
    Throwin,
    Freekicks,
    PenaltyKick,
}

#[derive(Drop, Copy, Serde, PartialEq, Introspect, Debug)]
pub enum CommonFouls {
    Foul_Tackle,
    Tripping,
}

#[derive(Drop, Copy, Serde, PartialEq, Introspect, Debug)]
pub enum FoulsActions{
    Heavy_tackles,
    Sliding_Tackle_From_Behind,
    Obstruction,
    Late_Challenge,
}


impl CommonSkillsImpl of Into<CommonSkills, felt252> {
    fn into(self: CommonSkills) -> felt252 {
        match self {
            CommonSkills::Pass => 'Pass',
            CommonSkills::Shoot => 'Shoot',
            CommonSkills::Dribble => 'Dribble',
            CommonSkills::Tackle => 'Tackle',
            CommonSkills::Sprint => 'Sprint',
            CommonSkills::Intercept => 'Intercept',
            CommonSkills::Save => 'Save',
            CommonSkills::Cross => 'Cross',
            CommonSkills::ThroughBall => 'ThroughBall',
            CommonSkills::Throwin => 'Throwin',
            CommonSkills::Freekicks => 'Freekicks',
            CommonSkills::PenaltyKick => 'PenaltyKick',
        }
    }
}


impl CommonFoulsImpl of Into<CommonFouls, felt252> {
    fn into(self: CommonFouls) -> felt252 {
        match self {
           
            CommonFouls::Foul_Tackle => 'Foul_Tackle',
            CommonFouls::Tripping => 'Tripping',
        }
    }
}


impl FoulsActionsImpl of Into<FoulsActions, felt252> {
    fn into(self: FoulsActions) -> felt252 {
        match self {
            FoulsActions::Heavy_tackles => 'Heavy_tackles',
            FoulsActions::Sliding_Tackle_From_Behind => 'Sliding_Tackle_From_Behind',
            FoulsActions::Obstruction => 'Obstruction',
            FoulsActions::Late_Challenge => 'Late_Challenge',
        }
    }
}

