//
//  TeamService.swift
//  sportsApp
//
//  Created by Nermeen on 4/27/21.
//  Copyright © 2021 Nermeen. All rights reserved.
//

import Foundation
import Alamofire

class TeamService{
    
    
    func fetchTeamData(completion : @escaping (TeamsEntity?, Error?)->()){
        
        
        AF.request(URLs.getTeamDescURL)
            .validate()
            .responseDecodable(of: TeamsEntity.self) { (response) in
                switch response.result {
                
                case .success( _):
                    
                    guard let teamData = response.value else { return }
                    
                    completion(teamData,nil)
                    
                    
                case .failure(let error):
                    
                    completion(nil , error)
                    
                    
                }
            }
    }
    
}

