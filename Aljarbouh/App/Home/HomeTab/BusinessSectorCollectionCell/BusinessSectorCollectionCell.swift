//
//  BusinessSectorCollectionCell.swift
//  Aljarbouh
//
//  Created by Hendawi on 24/02/2024.
//

import UIKit

class BusinessSectorCollectionCell: UICollectionViewCell {

    @IBOutlet weak var moreBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        moreBtn.layer.cornerRadius = 30
        moreBtn.layer.borderWidth = 2
        moreBtn.layer.borderColor = UIColor.white.cgColor
    }

}
