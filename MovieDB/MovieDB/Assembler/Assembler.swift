//
//  AppAssembler.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol Assembler: class,
    MainAssembler,
    MoviesAssembler,
    CategoriesAssembler,
    SearchAssembler,
    FavoritesAssembler,
    RepositoriesAssembler,
    AppAssembler {
    
}

final class DefaultAssembler: Assembler {
    
}
