//
//  SearchTableViewCell.swift
//  MovieDB
//
//  Created by Duc Pham on 5/20/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    func bindViewModel(_ viewModel: MovieViewModel?) {
        if let viewModel = viewModel {
            titleLable.text = viewModel.title
            posterImageView?.sd_setImage(with: URL(string: API.Urls.mediaBackdropPath + viewModel.backdropPath), completed: nil)
            
        } else {
            titleLable.text = ""
            posterImageView.image = nil
        }
    }
    
}
