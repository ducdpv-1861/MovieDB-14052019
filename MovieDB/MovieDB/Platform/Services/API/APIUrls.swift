//
//  APIUrls.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

extension API {
    enum Urls {
        private static let baseURL = "https://api.themoviedb.org/3"
        static let posterUrl = "http://image.tmdb.org/t/p/w185/"
        static let moviesListURL = baseURL + "/movie/popular"
        static let getUpcoming = baseURL + "/movie/upcoming"
        static let mediaBackdropPath = "https://image.tmdb.org/t/p/w500"
        static let searchMovies = baseURL + "/search/movie"
    }
}
