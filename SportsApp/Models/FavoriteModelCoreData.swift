//
//  FavoriteModelCoreData.swift
//  SportsApp
//
//  Created by Esraa on 23/04/2021.
//

import Foundation
class FavoriteModelCoreData{
    var title : String?
    var image : Data?
    var youtube : String?
    var id : Int32?
    init(Title title : String,Image image:Data, Youtube youtube:String, ID id: Int32) {
        self.title=title
        self.image=image
        self.youtube=youtube
        self.id=id
    }
}
