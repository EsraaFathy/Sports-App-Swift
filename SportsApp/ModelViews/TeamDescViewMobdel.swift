//
//  TeamDescViewMobdel.swift
//  sportsApp
//
//  Created by Nermeen on 4/27/21.
//  Copyright © 2021 Nermeen. All rights reserved.
//

import Foundation
class TeamDescViewModel: NSObject {
    
    var teamService :TeamService!
    
    var teamData : TeamsEntity! {
        didSet{
            
            self.bindTeamViewModelToView()
        }
        
    }
    
    
    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    
    
    var bindTeamViewModelToView : (()->()) = {}
    var bindViewModelErrorToView : (()->()) = {}
    
    
    override init() {
        
        super .init()
        self.teamService = TeamService()
        self.fetchTeamDataFromAPI()
    }
    
    
    func fetchTeamDataFromAPI (){
        
        teamService.fetchTeamData(completion: { (teamData, error) in
            
            if let error : Error = error{
                
                let message = error.localizedDescription
                self.showError = message
                
            }else{
                
                self.teamData = teamData
                
            }
           
        })
    }

}
