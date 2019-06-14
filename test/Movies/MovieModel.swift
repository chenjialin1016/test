//
//  MovieModel.swift
//  test
//
//  Created by Jialin Chen on 2019/6/13.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

import UIKit

enum Genre : Int {
    case Animation
    case Action
    case None
}

struct Movie{
    var title : String
    var genre : Genre
    
    func genreString()->String{
        switch genre {
        case .Action:
            return "Action"
        case .Animation:
            return "Animation"
        default:
            return "None"
        }
    }
}

class MoviesDataHelper{
    static func getMovies()->[Movie]{
        return [
            Movie(title: "The Emoji Movie", genre: .Animation),
            Movie(title: "Logan", genre: .Action),
            Movie(title: "Wonder Woman", genre: .Action),
            Movie(title: "Zootopia", genre: .Animation),
            Movie(title: "The Baby Boss", genre: .Animation),
            Movie(title: "Despicable Me 3", genre: .Animation),
            Movie(title: "Spiderman: Homecoming", genre: .Action),
            Movie(title: "Dunkirk", genre: .Animation)
                ]
    }
}
