//
//  Hero.swift
//  Heroes3
//
//  Created by Anggi Putra Gomis on 07/03/21.
//

import Foundation

struct Hero: Decodable {
    enum Role: String, Decodable {
//        case All, Carry, Disabler, Durable, Escape, Initiator, Jungler, Nuker, Pusher, Support
        case Carry = "Carry"
        case Disabler = "Disabler"
        case Durable = "Durable"
        case Escape = "Escape"
        case Initiator = "Initiator"
        case Jungler = "Jungler"
        case Nuker = "Nuker"
        case Pusher = "Pusher"
        case Support = "Support"
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "localized_name"
        case img = "img"
        case type = "attack_type"
        case attribute = "primary_attr"
        case health = "base_health"
        case mana = "base_mana"
        case minAttack = "base_attack_min"
        case maxAttack = "base_attack_max"
        case speed = "move_speed"
        case armor = "base_armor"
        case roles
    }
    
    let name: String
    let img: String
    let type: String
    let attribute: String
    let health: Int
    let mana: Int
    let minAttack: Int
    let maxAttack: Int
    let speed: Int
    let armor: Float
    let roles: [Role]
}
