//
//  SearchViewModel.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/17/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import Foundation
struct SearchViewModel {
    let navigator: SearchNavigatorType
    let useCase: SearchUseCaseType
}

// MARK: - ViewModelType
extension SearchViewModel: ViewModelType {
    
    struct Input {
        let editTrigger: Driver<String>
        let selectedTrigger: Driver<IndexPath>
        let rejectTrigger: Driver<Void>
        let toSearchResultTrigger: Driver<String>
        let toCancleTrigger: Driver<Void>
    }
    
    struct Output {
        let cells: Driver<[Movie]>
        let reject: Driver<Void>
        let error: Driver<Error>
        let loading: Driver<Bool>
        let toSearchResult: Driver<Void>
        let toCancle: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        
        let reject = input.rejectTrigger
            .do(onNext: { (_) in
               // self.navigator.dismiss()
            }).mapToVoid()
        
        let cells = input.editTrigger
            .distinctUntilChanged()
            .filter { $0 != "" }
            .flatMapLatest { keyword -> Driver<[Movie]> in
                return self.useCase.getSearchList(page: 1, searchText: keyword)
                    .trackError(errorTracker)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
        }
        
        let toSearchResult = input.toSearchResultTrigger
            .do(onNext: { keyword in
                
            })
            .mapToVoid()
        
        let toCancle = input.toCancleTrigger
            .do(onNext: { self.navigator.toCancle()
            })
        
        return Output(cells: cells,
                      reject: reject,
                      error: errorTracker.asDriver(),
                      loading: activityIndicator.asDriver(),
                      toSearchResult: toSearchResult,
                      toCancle: toCancle
        )
    }
}
