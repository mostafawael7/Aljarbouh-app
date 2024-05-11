//
//  SideMenuVC.swift
//  Aljarbouh
//
//  Created by Hendawi on 07/03/2024.
//

import UIKit

class SideMenuVC: UIViewController {
    private let notificationsViewModel = NotificationsViewModel()
    
    @IBOutlet var parentViews: [UIView]!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var notificationCount: UILabel!
    @IBOutlet var stackViews: [UIStackView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        
        getNotificationsCount()
    }
    
    private func initViews(){
        for view in parentViews {
            view.layer.cornerRadius = 15
            view.layer.borderWidth = 0.5
            view.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        notificationView.layer.cornerRadius = 12
        notificationView.isHidden = true
        
        for view in stackViews {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            view.addGestureRecognizer(tapGesture)
        }
    }
    
    func getNotificationsCount(){
        displayAnimatedActivityIndicatorView()
        notificationsViewModel.list{ [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success:
                self.notificationCount.text = String(notificationsViewModel.notifications.count)
                self.notificationView.isHidden = false
                self.hideAnimatedActivityIndicatorView()
            case .failure(let error as NSError):
                self.hideAnimatedActivityIndicatorView()
                self.handleInternetError(error: error)
            }
        }
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        if let tappedView = gesture.view {
//            print(tappedView.tag)
            let storyBoard = UIStoryboard(name: "Home", bundle: nil)
            let dest = storyBoard.instantiateViewController(identifier: "HomeTabBar") as? HomeTabBar
            dest?.modalPresentationStyle = .fullScreen
            switch tappedView.tag{
            case 1: navigateToVC(vc: "ProfileVC", inStoryboard: "SideMenu")
            case 2: navigateToVC(vc: "FamilyHistoryVC", inStoryboard: "SideMenu")
            case 3: // شجرة العائلة
                dest?.selectedIndex = 0
                self.present(dest!, animated: true)
            case 4: navigateToVC(vc: "HistoricCharactersVC", inStoryboard: "SideMenu")
            case 5: // أخبار العائلة
                dest?.selectedIndex = 3
                self.present(dest!, animated: true)
            case 6: // الإجتماعات
                dest?.selectedIndex = 1
                self.present(dest!, animated: true)
            case 7: navigateToVC(vc: "NotificationsVC", inStoryboard: "SideMenu")
            case 8: navigateToVC(vc: "FamilyBoxVC", inStoryboard: "SideMenu")
//            case 9: // الإعدادات
            case 10:
                //logout
                UserDefaultsManager.shared.remove(forKey: UserDefaultKeys.AuthToken)
                UserDefaultsManager.shared.remove(forKey: UserDefaultKeys.LoggedIn)
                navigateToVC(vc: "LoginVC", inStoryboard: "Main")
            default:
                break
            }
        }
    }
}
