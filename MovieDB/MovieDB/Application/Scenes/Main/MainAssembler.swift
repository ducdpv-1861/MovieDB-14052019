//
//  MainAssembler.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

protocol MainAssembler {
    func resolve() -> MainViewController
}

extension MainAssembler where Self: DefaultAssembler {
    func resolve() -> MainViewController {
        let navigationController = UINavigationController()
        let moviesViewController: MoviesViewController = resolve(navigationController: navigationController)
        moviesViewController.makeTabBarItem(title: "Movies", image: #imageLiteral(resourceName: "icon-movies"), tag: 0)
        
        let categoriesViewController: CategoriesViewController = resolve()
        categoriesViewController.makeTabBarItem(title: "Categories", image: #imageLiteral(resourceName: "icon-categories"), tag: 1)
        
        let favoritesViewController: FavoritesViewController = resolve()
        favoritesViewController.makeTabBarItem(title: "Favorites", image: #imageLiteral(resourceName: "icon-favorite-1"), tag: 2)
        
        let mainViewController = MainViewController().then {
            $0.viewControllers = [moviesViewController, categoriesViewController, favoritesViewController]
            $0.changeSelectedColor(.pastelRed, iconSelectedColor: .pastelRed)
        }
        
        return mainViewController
    }
}
