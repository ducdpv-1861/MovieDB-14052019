//
//  CategoriesViewModelTests.swift
//  MovieDBTests
//
//  Created by tran.duc.tan on 5/16/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking
@testable import MovieDB

final class CategoriesViewModelTests: XCTestCase {
    private var viewModel: CategoriesViewModel!
    private var navigator: CategoriesNavigatorMock!
    private var useCase: CategoriesUseCaseMock!
    
    private var input: CategoriesViewModel.Input!
    private var output: CategoriesViewModel.Output!
    
    private var disposeBag: DisposeBag!
    
    private let loadTrigger = PublishSubject<Void>()
    private let reloadTrigger = PublishSubject<Void>()
    private let loadMoreTrigger = PublishSubject<Void>()

    override func setUp() {
        super.setUp()
        navigator = CategoriesNavigatorMock()
        useCase = CategoriesUseCaseMock()
        viewModel = CategoriesViewModel(navigator: navigator, useCase: useCase)
        
        disposeBag = DisposeBag()
        
        input = CategoriesViewModel.Input(
            loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
            reloadTrigger: reloadTrigger.asDriverOnErrorJustComplete(),
            loadMoreTrigger: loadMoreTrigger.asDriverOnErrorJustComplete())
        output = viewModel.transform(input)
        
        output.error.drive().disposed(by: disposeBag)
        output.loading.drive().disposed(by: disposeBag)
        output.refreshing.drive().disposed(by: disposeBag)
        output.loadingMore.drive().disposed(by: disposeBag)
        output.fetchItems.drive().disposed(by: disposeBag)
        output.moviesList.drive().disposed(by: disposeBag)
    }
    
    func test_loadTriggerInvoked_getMoviesList() {
        loadTrigger.onNext(())
        let moviesList = try? output.moviesList.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.getMoviesListCalled)
        XCTAssertEqual(moviesList?.count, 1)
    }
    
    func test_loadTriggerInvoked_getMoviesList_failedShowError() {
        let getMoviesListReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.getMoviesListReturnValue = getMoviesListReturnValue
        
        loadTrigger.onNext(())
        getMoviesListReturnValue.onError(TestError())
        let error = try? output.error.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.getMoviesListCalled)
        XCTAssert(error is TestError)
    }
    
    func test_reloadTriggerInvoked_getMoviesList() {
        reloadTrigger.onNext(())
        let moviesList = try? output.moviesList.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.getMoviesListCalled)
        XCTAssertEqual(moviesList?.count, 1)
    }
    
    func test_reloadTriggerInvoked_getMoviesList_failedShowError() {
        let getMoviesListReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.getMoviesListReturnValue = getMoviesListReturnValue
        
        reloadTrigger.onNext(())
        getMoviesListReturnValue.onError(TestError())
        let error = try? output.error.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.getMoviesListCalled)
        XCTAssert(error is TestError)
    }
    
    func test_reloadTriggerInvoked_notGetMoviesListIfStillLoading() {
        let getMoviesListReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.getMoviesListReturnValue = getMoviesListReturnValue
        
        loadTrigger.onNext(())
        useCase.getMoviesListCalled = false
        reloadTrigger.onNext(())
        
        XCTAssertFalse(useCase.getMoviesListCalled)
    }
    
    func test_reloadTriggerInvoked_notGetMoviesListIfStillReloading() {
        let getMoviesListReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.getMoviesListReturnValue = getMoviesListReturnValue
        
        reloadTrigger.onNext(())
        useCase.getMoviesListCalled = false
        reloadTrigger.onNext(())
        
        XCTAssertFalse(useCase.getMoviesListCalled)
    }
    
    func test_loadMoreTriggerInvoked_loadMoreMoviesList() {
        loadTrigger.onNext(())
        loadMoreTrigger.onNext(())
        let moviesList = try? output.moviesList.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.loadMoreMoviesListCalled)
        XCTAssertEqual(moviesList?.count, 2)
    }
    
    func test_loadMoreTriggerInvoked_loadMoreMoviesList_failedShowError() {
        let loadMoreMoviesListReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.loadMoreMoviesListReturnValue = loadMoreMoviesListReturnValue
        
        loadTrigger.onNext(())
        loadMoreTrigger.onNext(())
        loadMoreMoviesListReturnValue.onError(TestError())
        let error = try? output.error.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.loadMoreMoviesListCalled)
        XCTAssert(error is TestError)
    }
    
    func test_loadMoreTriggerInvoked_notLoadMoreMoviesListIfStillLoading() {
        let getMoviesListReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.getMoviesListReturnValue = getMoviesListReturnValue
        
        loadTrigger.onNext(())
        useCase.getMoviesListCalled = false
        loadMoreTrigger.onNext(())
        
        XCTAssertFalse(useCase.loadMoreMoviesListCalled)
    }
    
    func test_loadMoreTriggerInvoked_notLoadMoreMoviesListIfStillReloading() {
        let getMoviesListReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.getMoviesListReturnValue = getMoviesListReturnValue
        
        reloadTrigger.onNext(())
        useCase.getMoviesListCalled = false
        loadMoreTrigger.onNext(())
        
        XCTAssertFalse(useCase.loadMoreMoviesListCalled)
    }
    
    func test_loadMoreTriggerInvoked_notLoadMoreMoviesListIfStillLoadingMore() {
        let getMoviesListReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.getMoviesListReturnValue = getMoviesListReturnValue
        
        loadMoreTrigger.onNext(())
        useCase.getMoviesListCalled = false
        loadMoreTrigger.onNext(())
        
        XCTAssertFalse(useCase.loadMoreMoviesListCalled)
    }
}
