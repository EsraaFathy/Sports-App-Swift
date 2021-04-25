//
//  LastEventService.swift
//  SportsApp
//
//  Created by Esraa on 25/04/2021.
//

import Foundation
import Alamofire

class LastEventService{
    
    func fetchlastEventsData(completion : @escaping (LastAllEvents?, Error?)->()){
        
        AF.request(URLs.upLastEventsURL)
            .validate()
            .responseDecodable(of: LastAllEvents.self) { (response) in
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

