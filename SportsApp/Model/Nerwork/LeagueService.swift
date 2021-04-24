//
//  LeagueService.swift
//  sportsApp
//
//  Created by Nermeen on 4/23/21.
//  Copyright © 2021 Nermeen. All rights reserved.
//

import Foundation
import Alamofire



class LeagueService{
    
    
    func fetchLeagueData(completion : @escaping (Leagues?, Error?)->()){
        
        print("serice \(URLs.getLeagueListURL)")
        AF.request(URLs.getLeagueListURL)
            .validate()
            .responseDecodable(of: Leagues.self) { (response) in
                switch response.result {
                
                case .success( _):
                    
                    guard let leaguesData = response.value else { return }
                    print("leagues data \(leaguesData)")

                    completion(leaguesData,nil)
                    
                    
                case .failure(let error):
                    
                    completion(nil , error)
                    
                    
                }
            }
    }
    
}

