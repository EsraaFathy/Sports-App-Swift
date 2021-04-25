//
//  TeamsService.swift
//  SportsApp
//
//  Created by Esraa on 25/04/2021.
//TeamsClassModel

import Foundation
import Alamofire
class TeamsService{
    
    func fetchTeamsData(completion : @escaping (TeamsClassModel?, Error?)->()){
    
    AF.request(URLs.teamsURL)
        .validate()
        .responseDecodable(of: TeamsClassModel.self) { (response) in
            switch response.result {
            
            case .success( _):
                
                guard let data = response.value else { return }
                completion(data,nil)
                
            case .failure(let error):
                
                completion(nil , error)
                
                
            }
        }
}

}
