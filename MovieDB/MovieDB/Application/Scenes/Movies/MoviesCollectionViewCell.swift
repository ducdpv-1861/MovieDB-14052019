//
//  MoviesCollectionViewCell.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import SDWebImage

class MoviesCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var contentViewBig: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.do {_ in
            contentView.layer.shadowColor = UIColor.black.cgColor
            contentView.layer.shadowOffset = CGSize(width: -1.0, height: 1.0)
            contentView.layer.shadowOpacity = 5
            contentView.layer.shadowRadius = 4.0
            contentView.layer.cornerRadius = 4.0
        }
        
        contentViewBig.layer.cornerRadius = 5.0
    }
    
    func bindViewModel(_ viewModel: Movie?) {
        if let viewModel = viewModel {
            textLabel.text = viewModel.title
            posterImageView?.sd_setImage(with: URL(string: API.Urls.mediaBackdropPath + viewModel.backdropPath ), completed: nil)
            backdropImageView?.sd_setImage(with: URL(string: API.Urls.mediaBackdropPath + viewModel.posterPath ), completed: nil)
            
        } else {
            textLabel.text = ""
            posterImageView.image = nil
        }
    }

}
