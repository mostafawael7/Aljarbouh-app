//
//  NewsTableCell.swift
//  Aljarbouh
//
//  Created by Hendawi on 25/02/2024.
//

import UIKit
import Kingfisher

class NewsTableCell: UITableViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        newsImage.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        newsImage.image = UIImage(named: "image1")
    }
    
    func configureCell(news: News){
        if let url = URL(string: news.imageURL ?? "") {
            newsImage.kf.setImage(with: url, placeholder: UIImage(named: "image1"), options: [.transition(ImageTransition.fade(0.2))])
        }
        titleLbl.text = news.title
        descriptionLbl.text = news.description
    }
    
    func configureShowButton(indexPath: IndexPath, target: Any, action: Selector) {
        moreBtn.addTarget(target, action: action, for: .touchUpInside)
        moreBtn.tag = indexPath.row
    }
    
    @IBAction func moreBtnClicked(_ sender: UIButton) {
        print("clicked")
    }
    
}
