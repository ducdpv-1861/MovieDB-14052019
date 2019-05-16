//
//  RepositoriesAssembler.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

protocol RepositoriesAssembler {
    func resolve() -> MovieRepositoryType

}

extension RepositoriesAssembler where Self: DefaultAssembler {
    func resolve() -> MovieRepositoryType {
        return MovieRepository()
    }
    
}
