//
//  SearchAssembler.swift
//  MovieDB
//
//  Created by Duc Pham on 5/20/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

protocol SearchAssembler {
    func resolve(navigationController: UINavigationController) -> SearchViewController
    func resolve(navigationController: UINavigationController) -> SearchViewModel
    func resolve(navigationController: UINavigationController) -> SearchNavigatorType
    func resolve() -> SearchUseCaseType
}

extension SearchAssembler {
    func resolve(navigationController: UINavigationController) -> SearchViewController {
        let vc = SearchViewController.instantiate()
        let vm: SearchViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> SearchViewModel {
        return SearchViewModel(navigator: resolve(navigationController: navigationController),
                               useCase: resolve())
    }
    
}

extension SearchAssembler where Self: DefaultAssembler {
    func resolve() -> SearchUseCaseType {
        return SearchUseCase(repository: resolve())
    }
    
    func resolve(navigationController: UINavigationController) -> SearchNavigatorType {
        return SearchNavigator(assembler: self, navigationController: navigationController)
    }
}
