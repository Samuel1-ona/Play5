use play5::models::football::{CommonSkills, CommonFouls};
use core::panic_with_felt252;

pub fn common_skills_to_index(football: felt252) -> u16 {
    if football == CommonSkills::Pass.into(){
        return 0;
    } else if football == CommonSkills::Shoot.into(){
        return 1;
    } else if football == CommonSkills::Dribble.into() {
        return 2;
    } else if football == CommonSkills::Tackle.into() {
        return 3;
    } else if football == CommonSkills::Sprint.into(){
        return 4;
    } else if football == CommonSkills::Intercept.into(){
        return 5;
    } else if football == CommonSkills::Save.into(){
        return 6;
    } else if football == CommonSkills::Cross.into(){
        return 7;
    } else if football == CommonSkills::ThroughBall.into(){
        return 8;
    } else if football == CommonSkills::Throwin.into(){
        return 9;
    } else if football == CommonSkills::Freekicks.into(){
        return 10;
    }
    panic_with_felt252('football skills not found')
}

pub fn common_fouls_to_index(football: felt252) -> u16 {
    if football == CommonFouls::Handball.into(){
        return 0;
    } else if football == CommonFouls::Foul_Tackle.into(){
        return 1;
    } else if football == CommonFouls::Holding.into(){
        return 2;
    } else if football == CommonFouls::Pushing.into(){
        return 3;
    } else if football == CommonFouls::Tripping.into(){
        return 4;
    }
    panic_with_felt252('football fouls not found')
}

pub fn index_to_football_skils(index: u16) -> felt252 {
    match index{
        0 => CommonSkills::Pass.into(),
        1 => CommonSkills::Shoot.into(),
        2 => CommonSkills::Dribble.into(),
        3 => CommonSkills::Tackle.into() ,
        4 => CommonSkills::Sprint.into(),
        5 => CommonSkills::Intercept.into(),
        6 => CommonSkills::Save.into(),
        7 => CommonSkills::Cross.into(),
        8 => CommonSkills::ThroughBall.into(),
        9 => CommonSkills::Throwin.into(),
        10 => CommonSkills::Freekicks.into(),
        _ => panic_with_felt252('index out of range')
    }
}

pub fn index_to_football_fouls(index: u16) -> felt252 {
    match index{
        0 => CommonFouls::Handball.into(),
        1 => CommonFouls::Foul_Tackle.into(),
        2 => CommonFouls::Holding.into(),
        3 => CommonFouls::Pushing.into(),
        4 => CommonFouls::Tripping.into(),
        _ => panic_with_felt252('index out of range')
    }
}