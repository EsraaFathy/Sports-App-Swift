//
//  AllSportsModel.swift
//  SportsApp
//
//  Created by Esraa on 20/04/2021.
//

import Foundation
// MARK: - Welcome
struct Welcome: Decodable {
    let sports: [Sport]
}

// MARK: - Sport
struct Sport: Decodable {
    let idSport, strSport: String
    let strFormat: StrFormat
    let strSportThumb, strSportThumbGreen: String
    let strSportDescription: String
}

enum StrFormat: String, Decodable {
    case eventSport = "EventSport"
    case teamvsTeam = "TeamvsTeam"
}
