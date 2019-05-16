//
//  MovieViewModel.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

struct MovieViewModel {
    let movie: Movie
    
    var name: String {
        return movie.title
    }
    
    var url: URL? {
        return URL(string: movie.backdropPath)
    }
}
