//
//  MoviesViewController.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import Foundation

final class MoviesViewController: UIViewController, BindableType {
    deinit {
        logDeinit()
    }
    
    @IBOutlet weak var collectionView: LoadMoreCollectionView!
    
    struct Options {
        var itemSpacing: CGFloat = 8
        var lineSpacing: CGFloat = 8
        var itemsPerRow: Int = 2
        var sectionInsets = UIEdgeInsets(
            top: 10.0,
            left: 10.0,
            bottom: 10.0,
            right: 10.0
        )
    }
    
    private var options = Options()
    private let toSearchTrigger = PublishSubject<Void>()
    var viewModel: MoviesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cofigView()
    }
    
    override func viewWillLayoutSubviews() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func searchButton(_ sender: Any) {
        toSearchTrigger.onNext(())
    }
    
    private func cofigView() {
        collectionView.do {
            $0.register(cellType: MoviesCollectionViewCell.self)
        }
        
        collectionView.rx
            .setDelegate(self)
            .disposed(by: rx.disposeBag)
    }
    
    func bindViewModel() {
        let input = MoviesViewModel.Input(
            loadTrigger: Driver.just(()),
            reloadTrigger: collectionView.refreshTrigger,
            loadMoreTrigger: collectionView.loadMoreTrigger,
            selectRepoTrigger: collectionView.rx.itemSelected.asDriver(),
            toSearchTrigger: toSearchTrigger.asDriverOnErrorJustComplete()
        )
        
        let output = viewModel.transform(input)
        
        output.repoList
            .drive(collectionView.rx.items) { collectionView, index, result in
                return collectionView.dequeueReusableCell(for: IndexPath(row: index, section: 0),
                                                          cellType: MoviesCollectionViewCell.self)
                    .then {
                        $0.bindViewModel(MovieViewModel(movie: result))
                    }
            }
            .disposed(by: rx.disposeBag)
        
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        output.loading
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        output.refreshing
            .drive(collectionView.refreshing)
            .disposed(by: rx.disposeBag)
        output.loadingMore
            .drive(collectionView.loadingMore)
            .disposed(by: rx.disposeBag)
        output.fetchItems
            .drive()
            .disposed(by: rx.disposeBag)
        output.selectedRepo
            .drive()
            .disposed(by: rx.disposeBag)
        output.isEmptyData
            .drive()
            .disposed(by: rx.disposeBag)
        output.toSearch
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - StotyboardSceneBased
extension MoviesViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}

// MARK: - UICollectionViewDelegate
extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 10 , height: view.frame.width / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return options.sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return options.lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return options.itemSpacing
    }
    
}
