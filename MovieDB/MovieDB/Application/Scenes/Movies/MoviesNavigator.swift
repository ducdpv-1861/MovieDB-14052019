//
//  MoviesNavigator.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol MoviesNavigatorType {
    func toMovies()
    func toMoviesDetail(movie: Movie)
}

struct MoviesNavigator: MoviesNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toMovies() {
        let vc: MoviesViewController = assembler.resolve(navigationController: navigationController)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toMoviesDetail(movie: Movie) {
        
    }
}
