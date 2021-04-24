//
//  LeaguesViewModel.swift
//  sportsApp
//
//  Created by Nermeen on 4/23/21.
//  Copyright © 2021 Nermeen. All rights reserved.
//

import Foundation
class LeagueViewModel: NSObject {
    
    var leagueService :LeagueService!
    
    var leagueData : Leagues! {
        didSet{
            
            self.bindLeagueViewModelToView()
        }
        
    }
    
    
    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    
    
    var bindLeagueViewModelToView : (()->()) = {}
    var bindViewModelErrorToView : (()->()) = {}
    
    
    override init() {
        
        super .init()
        self.leagueService = LeagueService()
        self.fetchLeagueDataFromAPI()
    }
    
    
    func fetchLeagueDataFromAPI (){
        
        leagueService.fetchLeagueData(completion: { (leagueData, error) in
            
            if let error : Error = error{
                
                let message = error.localizedDescription
                self.showError = message
                
            }else{
                
                self.leagueData = leagueData
                
            }
           
        })
    }

}
