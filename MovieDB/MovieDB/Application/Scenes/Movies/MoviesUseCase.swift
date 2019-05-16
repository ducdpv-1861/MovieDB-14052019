//
//  MoviesUseCase.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol MoviesUseCaseType {
    func getMoviesList() -> Observable<PagingInfo<Movie>>
    func loadMoreMoviesList(page: Int) -> Observable<PagingInfo<Movie>>
}

struct MoviesUseCase: MoviesUseCaseType {
    let repository: MovieRepositoryType
    
    func getMoviesList() -> Observable<PagingInfo<Movie>> {
        return loadMoreMoviesList(page: 1)
    }
    
    func loadMoreMoviesList(page: Int) -> Observable<PagingInfo<Movie>> {
        return repository.getMovieList(page: page, useCache: page == 1)
    }
}

