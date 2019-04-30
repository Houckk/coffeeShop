//
//  Food.swift
//  coffeeShop
//
//  Created by Kenyan Houck on 4/29/19.
//  Copyright © 2019 Kenyan Houck. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Food {
    
    struct FoodData {
        var publisher: String
        var f2f_url: String
        var title: String
        var image_url: String
        var social_rank: Float
        var recipe_id: Int
    }
    
    var foodArray: [FoodData] = []
    var apiURL = "https://www.food2fork.com/api/search?key=033c48e50cc9dca022c4b5aa3f83b0dd"
    
    //&q=chicken%20breast&page=2"
    
    
    func getFood(completed: @escaping () -> () ) {
        Alamofire.request(apiURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let numberOfFoods = json["recipies"].count
                self.apiURL = json["next"].stringValue
                for index in 0...numberOfFoods {
                    let publisher = json["recipies"]["publisher"].stringValue
                    let f2f_url = json["recipes"]["f2f_url"].stringValue
                    let title = json["recipies"]["title"].stringValue
                    let image_url = json["recipies"]["image_url"].stringValue
                    let social_rank = json["recipies"]["social_rank"].floatValue
                    let recipe_id = json["recipies"]["recipe_id"].intValue
                    self.foodArray.append(FoodData(publisher: publisher, f2f_url: f2f_url, title: title, image_url: image_url, social_rank: social_rank, recipe_id: recipe_id))
                }
            case .failure(let error):
                print("ERROR: \(error.localizedDescription) failed to get data from url \(self.apiURL)")
            }
            completed()
        }
    }
}


