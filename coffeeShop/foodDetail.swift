//
//  foodDetail.swift
//  coffeeShop
//
//  Created by Kenyan Houck on 4/29/19.
//  Copyright © 2019 Kenyan Houck. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class foodDetail {
    var rID = Food()
    var ingredients: Array<Any> = []
    var f2f_url = ""
    var image_url = ""
    var social_rank : Float = 0.0
    var apiURL = "https://www.food2fork.com/api/get?key=033c48e50cc9dca022c4b5aa3f83b0dd"
    
    
    func getChampionDetail(completed: @escaping () -> () ) {
        Alamofire.request(apiURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.ingredients = json["recipe"]["ingredients"].arrayValue
                self.f2f_url = json["recipe"]["f2f_url"].stringValue
                self.image_url = json["recipe"]["image_url"].stringValue
                self.social_rank = json["recipe"]["social_rank"].floatValue
            case .failure(let error):
                print("ERROR: \(error.localizedDescription) failed to get data from url \(self.apiURL)")
            }
            completed()
        }
    }
    
    
}
