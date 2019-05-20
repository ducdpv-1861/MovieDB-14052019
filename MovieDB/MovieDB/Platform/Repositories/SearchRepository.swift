//
//  SearchRepository.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/17/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

protocol SearchRepositoryType {
    func getSearchList(page: Int, searchText:String) -> Observable<[Movie]>
}

final class SearchRepository: SearchRepositoryType {
    func getSearchList(page: Int, searchText:String) -> Observable<[Movie]> {
        let input = API.SearchMoviesListInput(page: page, searchText: searchText)
        return API.shared.searchMoviesList(input)
            .map { output in
                guard let repos = output.movies else {
                    throw APIInvalidResponseError()
                }
                return repos
        }
    }
}
