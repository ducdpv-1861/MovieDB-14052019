//
//  SearchNavigator.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/17/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol SearchNavigatorType {
    func toSearch()
    func toCancel()
    func toMovieDetail()
}

struct SearchNavigator: SearchNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toSearch() {
        let vc: SearchViewController = assembler.resolve(navigationController: navigationController)
        navigationController.present(vc, animated: true, completion: nil)
    }
    
    func toMovieDetail() {
        let viewController: MovieDetailViewController = assembler.resolve(navigationController: navigationController)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func toCancel(){
        navigationController.dismiss(animated: true, completion: nil)
    }
}
