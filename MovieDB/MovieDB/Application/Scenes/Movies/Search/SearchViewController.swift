//
//  SearchViewController.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/17/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, BindableType, UITextFieldDelegate {
    @IBOutlet weak var searchUITextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rejectButton: UIButton!
    
    let disposeBag = DisposeBag()
    var viewModel: SearchViewModel!
    fileprivate let toSearchResultTrigger = PublishSubject<String>()
    fileprivate let selectedTrigger = PublishSubject<IndexPath>()
    fileprivate let toCancel = PublishSubject<Void>()
    
    var errorBinder: Binder<Error> {
        return Binder(self) { vc, error in
            vc.searchUITextField.resignFirstResponder()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func configView() {
        tableView.do {
            $0.delegate = self
            $0.rowHeight = UITableView.automaticDimension
            $0.register(cellType: SearchTableViewCell.self)
        }
        searchUITextField.do {
            $0.delegate = self
        }
    }
    
    @IBAction func cancleButton(_ sender: Any) {
        toCancel.onNext(())
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let textString = searchUITextField.text, textString.trimmingCharacters(in: .whitespacesAndNewlines).count >= 1 {
            toSearchResultTrigger.onNext(textString)
            textField.resignFirstResponder()
            return true
        }
        return false
    }
    
    func bindViewModel() {
        let rejectTrigger = rejectButton.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .asDriverOnErrorJustComplete()
        let input = SearchViewModel.Input(editTrigger: searchUITextField.rx.text.orEmpty.asDriver(),
                                                    selectedTrigger: selectedTrigger.asDriverOnErrorJustComplete(),
                                                    rejectTrigger: rejectTrigger,
                                                    toSearchResultTrigger: toSearchResultTrigger.asDriverOnErrorJustComplete(),
                                                    toCancleTrigger: toCancel.asDriverOnErrorJustComplete()
        )
        let output = viewModel.transform(input)
        
        output.cells
            .drive(tableView.rx.items) { tableView, index, content in
                let indexPath = IndexPath(row: index, section: 0)
                return tableView.dequeueReusableCell(
                    for: indexPath,
                    cellType: SearchTableViewCell.self)
                    .then {
                        $0.bindViewModel(MovieViewModel(movie: content))
                    }
            }
            .disposed(by: rx.disposeBag)
        
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        
        output.error
            .drive(errorBinder)
            .disposed(by: rx.disposeBag)
        
        output.loading
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        
        output.reject
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.toSearchResult
            .drive()
            .disposed(by: rx.disposeBag)
        output.toCancle
            .drive()
            .disposed(by: rx.disposeBag)
    }

}

// MARK: - StotyboardSceneBased
extension SearchViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.searchMovies
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

