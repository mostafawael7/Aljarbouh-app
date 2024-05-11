//
//  WelcomeVC.swift
//  Aljarbouh
//
//  Created by Hendawi on 16/02/2024.
//

import UIKit
import Kingfisher

class WelcomeVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var profile: Profile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.cornerRadius = 75
        
        if let media = profile?.media?.first,
           let urlString = media.originalURL,
           let url = URL(string: urlString) {
            profileImage.kf.setImage(with: url, placeholder: UIImage(systemName: "person.crop.circle.fill"), options: [.transition(ImageTransition.fade(0.2))])
        } else {
            profileImage.image = UIImage(systemName: "person.crop.circle.fill")
        }

        
        if let name = profile?.getFullName() {
            nameLabel.text = name
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.navigateToVC(vc: "HomeTabBar", inStoryboard: "Home")
        }
    }
}
