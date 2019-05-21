//
//  API+Search.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/17/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import ObjectMapper

extension API {
    func searchMoviesList(_ input: SearchMoviesListInput) -> Observable<SearchMoviesListOutput> {
        return request(input)
    }
}

// MARK: - GetMoviesList
extension API {
    final class SearchMoviesListInput: APIInput {
        init(page: Int, searchText:String) {
            let params: JSONDictionary = [
                "api_key": Keys.key,
                "query": searchText,
                "page": page
            ]
            super.init(urlString: API.Urls.searchMovies,
                       parameters: params,
                       requestType: .get,
                       requireAccessToken: false)
        }
    }
    
    final class SearchMoviesListOutput: APIOutput {
        private(set) var movies: [Movie]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            movies <- map["results"]
        }
    }
}
