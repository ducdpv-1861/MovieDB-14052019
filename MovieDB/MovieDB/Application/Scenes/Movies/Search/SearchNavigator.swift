//
//  SearchNavigator.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/17/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import Foundation

protocol SearchNavigatorType {
    func toSearch()
    func toSearchDetail(movie: Movie)
    func toCancle()
}

struct SearchNavigator: SearchNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toSearch() {
        let vc: SearchViewController = assembler.resolve(navigationController: navigationController)
        navigationController.present(vc, animated: true, completion: nil)
    }
    
    func toCancle(){
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    func toSearchDetail(movie: Movie) {
        
    }
}
