//
//  MoviesAssembler.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

protocol MoviesAssembler {
    func resolve(navigationController: UINavigationController) -> MoviesViewController
    func resolve() -> MoviesViewModel
    func resolve(navigationController: UINavigationController) -> MoviesNavigatorType
    func resolve() -> MoviesUseCaseType
}

extension MoviesAssembler {
    func resolve(navigationController: UINavigationController) -> MoviesViewController {
        let vc = MoviesViewController.instantiate()
        vc.navigationController?.setNavigationBarHidden(false, animated: true)
        vc.navigationController?.navigationBar
        let vm: MoviesViewModel = resolve()
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve() -> MoviesViewModel {
        let moviNav = UINavigationController()
        return MoviesViewModel(navigator: resolve(navigationController: moviNav),
                              useCase: resolve())
    }
    
}

extension MoviesAssembler where Self: DefaultAssembler {
    func resolve() -> MoviesUseCaseType {
        return MoviesUseCase(repository: MovieRepository())
    }
    
    func resolve(navigationController: UINavigationController) -> MoviesNavigatorType {
        return MoviesNavigator(assembler: self, navigationController: navigationController)
    }
}
