//
//  NewsCollectionCell.swift
//  Aljarbouh
//
//  Created by Hendawi on 24/02/2024.
//

import UIKit
import Kingfisher

class NewsCollectionCell: UICollectionViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.layer.cornerRadius = 20
        imageView.addGradientOverlay()
    }
    
    override func prepareForReuse() {
        imageView.image = UIImage(named: "image1")
    }
    
    func configureCell(news: News){
        titleLbl.text = news.title
        if let url = URL(string: news.imageURL ?? "") {
            imageView.kf.setImage(with: url, placeholder: UIImage(named: "image1"), options: [.transition(ImageTransition.fade(0.2))])
        }
    }

}
