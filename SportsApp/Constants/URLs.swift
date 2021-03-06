//
//  URLs.swift
//  sportsApp
//
//  Created by Nermeen on 4/23/21.
//  Copyright © 2021 Nermeen. All rights reserved.
//

import Foundation

struct URLs {
    
    public static var getLeagueListURL : String = "https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?s="

    public static let urlSports = "https://www.thesportsdb.com/api/v1/json/1/all_sports.php"
    public static var upCommingURL = ""
    public static var upLastEventsURL = ""
    public static var teamsURL = ""
    
    public static let teamURL : String = "https://www.thesportsdb.com/api/v1/json/1/lookupteam.php?id="
    public static var teamId : String = "133604"
    public static var getTeamDescURL : String = teamURL+teamId
}
