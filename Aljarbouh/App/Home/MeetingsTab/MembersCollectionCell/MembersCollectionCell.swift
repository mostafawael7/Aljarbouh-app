//
//  MembersCollectionCell.swift
//  Aljarbouh
//
//  Created by Hendawi on 06/03/2024.
//

import UIKit

class MembersCollectionCell: UICollectionViewCell {

    @IBOutlet weak var memberImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        memberImage.layer.cornerRadius = 20
    }

}
