//
//  MovieRepositories.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

protocol MovieRepositoryType {
    func getMovieList(page: Int, useCache: Bool) -> Observable<PagingInfo<Movie>>
}

final class MovieRepository: MovieRepositoryType {
    func getMovieList(page: Int, useCache: Bool) -> Observable<PagingInfo<Movie>> {
        let input = API.GetMoviesListInput(page: page)
        input.useCache = useCache
        return API.shared.getMoviesList(input)
            .map { output in
                guard let repos = output.repos else {
                    throw APIInvalidResponseError()
                }
                return PagingInfo<Movie>(page: page, items: repos)
        }
    }
}
