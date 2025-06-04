use starknet::{ContractAddress};

#[derive(Copy, Drop, Serde, Debug)]
#[dojo::model]
struct Players {
    #[key]
    pub player_id: u32,
      #[key]
    pub player: ContractAddress,
    pub team_id: u32,
  
}


#[derive(Copy, Drop, Serde, Debug)]
#[dojo::model]
struct PlayerSkill {
    #[key]
    pub player_id: u32,
    #[key]
    pub skill: CommonSkills,
    pub level: u8,  // Optional: 1–100 or 1–10 scale
}


#[derive(Drop, Serde, Debug)]
#[dojo::model]
struct FoulLog {
    #[key]
    pub foul_id: u32,
    #[key]
    pub player_id: u32,
    pub match_id: u32,
    pub timestamp: u32,
    pub foul_type: CommonFouls,
}


#[derive(Copy, Drop, Serde, Debug)]
#[dojo::model]
struct Position {
    #[key]
    pub player_id: u32,
    pub x: u32,
    pub y: u32,
}

#[derive(Copy, Drop, Serde, Debug)]
#[dojo::model]
struct Velocity {
    #[key]
    pub player_id: u32,
    pub x: i32,
    pub y: i32,
}

#[derive(Drop, Serde, Debug)]
#[dojo::model]
struct Team {
     #[key]
    pub team_id: u32,
    pub match_id: u32,
    pub score: u32,
}

#[derive(Drop, Serde, Debug)]
#[dojo::model]
struct Match {
    #[key]
    pub match_id: u32,
    pub status: u8,         // 0 = Not Started, 1 = In Progress, 2 = Ended
    pub time: u32,          // Match time in seconds
    pub score_team1: u32,
    pub score_team2: u32,
    pub team1_id: u32,
    pub team2_id: u32,
}


#[derive(Copy, Drop, Serde, Debug)]
#[dojo::model]
struct SelectedSkill {
    #[key]
    pub player_id: u32,
    pub skills: felt252,
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
}

#[derive(Drop, Copy, Serde, PartialEq, Introspect, Debug)]
pub enum CommonFouls {
    Handball,
    Foul_Tackle,
    Holding,
    Pushing,
    Tripping,
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
        }


    }
}


impl CommonFoulsImpl of Into<CommonFouls, felt252> {
    fn into(self: CommonFouls) -> felt252 {
        match self {
            CommonFouls::Handball => 'Handball',
            CommonFouls::Foul_Tackle => 'Foul_Tackle',
            CommonFouls::Holding => 'Holding',
            CommonFouls::Pushing => 'Pushing',
            CommonFouls::Tripping => 'Tripping',
        }
    }
}


