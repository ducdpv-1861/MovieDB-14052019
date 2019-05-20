//
//  SearchUseCase.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/17/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol SearchUseCaseType {
    func getSearchList(page: Int, searchText: String) ->  Observable<[Movie]>
}

struct SearchUseCase: SearchUseCaseType {
    let repository: SearchRepositoryType
    
    func getSearchList(page: Int, searchText: String) -> Observable<[Movie]> {
        return repository.getSearchList(page: page, searchText: searchText)
    }
}

