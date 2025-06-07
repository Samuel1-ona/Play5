use play5::models::football::{CommonSkills, CommonFouls, FoulsActions};
use core::panic_with_felt252;

pub fn common_skills_to_index(football: felt252) -> u16 {
    if football == CommonSkills::Pass.into() {
        return 0;
    } else if football == CommonSkills::Shoot.into() {
        return 1;
    } else if football == CommonSkills::Dribble.into() {
        return 2;
    } else if football == CommonSkills::Tackle.into() {
        return 3;
    } else if football == CommonSkills::Sprint.into() {
        return 4;
    } else if football == CommonSkills::Intercept.into() {
        return 5;
    } else if football == CommonSkills::Save.into() {
        return 6;
    } else if football == CommonSkills::Cross.into() {
        return 7;
    } else if football == CommonSkills::ThroughBall.into() {
        return 8;
    } else if football == CommonSkills::Throwin.into() {
        return 9;
    } else if football == CommonSkills::Freekicks.into() {
        return 10;
    } else if football == CommonSkills::PenaltyKick.into() {
        return 11;
    }
    panic_with_felt252('football skills not found')
}

pub fn common_fouls_to_index(football: felt252) -> u16 {
    if football == CommonFouls::Foul_Tackle.into() {
        return 0;
    } else if football == CommonFouls::Tripping.into() {
        return 1;
    }
    panic_with_felt252('football fouls not found')
}

pub fn  common_fouls_actions_to_index(football:felt252) -> u16 {
    if football == FoulsActions::Heavy_tackles.into() {
        return 0;
    } else if football == FoulsActions::Sliding_Tackle_From_Behind.into() {
        return 1;
    } else if football == FoulsActions::Obstruction.into() {
        return 2;
    } else if football == FoulsActions::Late_Challenge.into() {
        return 3;
    }
    panic_with_felt252('fouls actions not found')
}


pub fn index_to_football_skils(index: u16) -> felt252 {
    match index {
        0 => CommonSkills::Pass.into(),
        1 => CommonSkills::Shoot.into(),
        2 => CommonSkills::Dribble.into(),
        3 => CommonSkills::Tackle.into(),
        4 => CommonSkills::Sprint.into(),
        5 => CommonSkills::Intercept.into(),
        6 => CommonSkills::Save.into(),
        7 => CommonSkills::Cross.into(),
        8 => CommonSkills::ThroughBall.into(),
        9 => CommonSkills::Throwin.into(),
        10 => CommonSkills::Freekicks.into(),
        11 => CommonSkills::PenaltyKick.into(),
        _ => panic_with_felt252('index out of range'),
    }
}

pub fn index_to_football_fouls(index: u16) -> felt252 {
    match index {
        0 => CommonFouls::Foul_Tackle.into(),
        1 => CommonFouls::Tripping.into(),
        _ => panic_with_felt252('index out of range'),
    }
}


pub fn index_to_fouls_actions(index: u16) -> felt252 {
    match index {
        0 => FoulsActions::Heavy_tackles.into(),
        1 => FoulsActions::Sliding_Tackle_From_Behind.into(),
        2 => FoulsActions::Obstruction.into(),
        3 => FoulsActions::Late_Challenge.into(),
        _ => panic_with_felt252('index out of range'),
    }
}



