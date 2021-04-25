//
//  TeamsViewModel.swift
//  SportsApp
//
//  Created by Esraa on 25/04/2021.
//

import Foundation
class TeamsViewModel: NSObject {
    
    var teamsService : TeamsService!
    
    var teamsData : TeamsClassModel! {
        didSet{
            
            self.bindTeamsDataViewModelToView()
        }
        
    }
    
    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    
    
    var bindTeamsDataViewModelToView : (()->()) = {}
    var bindViewModelErrorToView : (()->()) = {}
    
    
    override init() {
        
        super .init()
        self.teamsService = TeamsService()
        self.fetchTeamsDataFromAPI()
    }
    
    
    func fetchTeamsDataFromAPI (){
        
        teamsService.fetchTeamsData(completion: { (teamsData, error) in
            
            if let error : Error = error{
                
                let message = error.localizedDescription
                self.showError = message
                
            }else{
                
                self.teamsData = teamsData
                
            }
           
        })
    }

}
