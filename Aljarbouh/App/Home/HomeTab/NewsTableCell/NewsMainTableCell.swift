//
//  NewsMainTableCell.swift
//  Aljarbouh
//
//  Created by Hendawi on 03/05/2024.
//

import UIKit
import Kingfisher

class NewsMainTableCell: UITableViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsImage.layer.cornerRadius = 20
//        newsImage.addGradientOverlay()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        newsImage.image = UIImage(named: "image1")
    }
    
    func configureCell(news: News){
        titleLbl.text = news.title
        if let url = URL(string: news.imageURL ?? "") {
            newsImage.kf.setImage(with: url, placeholder: UIImage(named: "image1"), options: [.transition(ImageTransition.fade(0.2))])
        }
    }

    
}
