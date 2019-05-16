//
//  API+Movies.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import ObjectMapper

extension API {
    func getMoviesList(_ input: GetMoviesListInput) -> Observable<GetMoviesListOutput> {
        return request(input)
    }
}

// MARK: - GetRepoList
extension API {
    final class GetMoviesListInput: APIInput {
        init(page: Int) {
            let params: JSONDictionary = [
                "api_key": "73541481d7b587cb744820b41d55f8d3",
                "page": page
            ]
            super.init(urlString: API.Urls.getUpcoming,
                       parameters: params,
                       requestType: .get,
                       requireAccessToken: true)
        }
    }
    
    final class GetMoviesListOutput: APIOutput {
        private(set) var repos: [Movie]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            repos <- map["results"]
        }
    }
}
