//
//  SportsService.swift
//  SportsApp
//
//  Created by Esraa on 24/04/2021.
//

import Foundation
import Alamofire



class SportsService{
    
    
    func fetchSportsData(completion : @escaping (Welcome?, Error?)->()){
        
        AF.request(URLs.urlSports)
            .validate()
            .responseDecodable(of: Welcome.self) { (response) in
                switch response.result {
                
                case .success( _):
                    
                    guard let sportsData = response.value else { return }

                    completion(sportsData,nil)
                    
                    
                case .failure(let error):
                    
                    completion(nil , error)
                    
                    
                }
            }
    }
    
}

