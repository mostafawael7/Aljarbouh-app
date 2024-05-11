//
//  UIViewController+Extension.swift
//  Aljarbouh
//
//  Created by Hendawi on 17/02/2024.
//

import UIKit

extension UIViewController {
    func navigateToVC(vc: String, inStoryboard storybardName: String? = nil, presentationStyle style: UIModalPresentationStyle = .fullScreen){
        let storyboard = UIStoryboard(name: storybardName ?? "Main", bundle: nil)
        let destination = storyboard.instantiateViewController(withIdentifier: vc)
        destination.modalPresentationStyle = style
        self.present(destination, animated: true, completion: nil)
    }
    
    private func navigateToVC<T: UIViewController>(_ viewControllerType: T.Type, nibName: String, from viewController: UIViewController) {
        let destinationViewController = viewControllerType.init(nibName: nibName, bundle: nil)
        destinationViewController.modalPresentationStyle = .fullScreen
        self.present(destinationViewController, animated: true)
    }
    
    private func navigateToVCWithNavController(vc: UIViewController, presentationStyle style: UIModalPresentationStyle = .fullScreen){
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = style
        present(navController, animated: true, completion: nil)
    }
}

//MARK: - Alerts
extension UIViewController {
    func displayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "متابعة", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func displayDeleteUserAlert(title: String, message: String, action: UIAlertAction){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "الغاء", style: .default, handler: nil))
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func displayAlertAndDismissSelf(title: String?, message: String?, popToVC: UIViewController? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "الاستمرار؟", style: .destructive, handler: { action in
            if let popToVC = popToVC {
                // In view controller D
                if let navigationController = self.navigationController {
                    // Get the array of view controllers on the navigation stack
                    let viewControllers = navigationController.viewControllers

                    print(viewControllers)

                    // Find the instance of the specified view controller in the array
                    if let viewControllerToPopTo = viewControllers.first(where: { $0.isKind(of: type(of: popToVC)) }) {
                        // Pop to the specified view controller
                        navigationController.popToViewController(viewControllerToPopTo, animated: true)
                    }
                }
            }  else {
                self.dismiss(animated: true)
            }
        }))
        alert.addAction(UIAlertAction(title: "الغاء", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func displayDisappearingAlert(message: String){
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.view.layer.borderWidth = 3
        alert.view.layer.borderColor = UIColor.primary.cgColor
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: {Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                self.dismiss(animated: true, completion: nil)
            }})
        }
    }
    
    func displayDisappearingAlertAndDismissSelf(message: String, popToVC: UIViewController? = nil) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: {
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                    self.dismiss(animated: true) {
                        if let popToVC = popToVC {
                            // In view controller D
                            if let navigationController = self.navigationController {
                                // Get the array of view controllers on the navigation stack
                                let viewControllers = navigationController.viewControllers

                                print(viewControllers)

                                // Find the instance of the specified view controller in the array
                                if let viewControllerToPopTo = viewControllers.first(where: { $0.isKind(of: type(of: popToVC)) }) {
                                    // Pop to the specified view controller
                                    navigationController.popToViewController(viewControllerToPopTo, animated: true)
                                }
                            }
                        } else {
                            self.dismiss(animated: true)
                        }
                    }
                }
            })
        }
    }

    func displayAlertWithNavigation<T: UIViewController>(title: String?, msg: String?, _ viewControllerType: T.Type, nibName: String, from viewController: UIViewController){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: {Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                self.dismiss(animated: true, completion: nil)
                self.navigateToVC(viewControllerType.self, nibName: nibName, from: self)
            }})
        }
    }
}

extension UITableViewCell {
    func showToast(message: String) {
        let toastView = ToastView(message: message)
        // Customize the appearance and layout of the toast view
        
        // Add the toast view to the view hierarchy
        contentView.addSubview(toastView)
        
        // Optionally animate the appearance and disappearance of the toast view
        UIView.animate(withDuration: 0.3, animations: {
            toastView.alpha = 1.0
        }) { (_) in
            UIView.animate(withDuration: 0.3, delay: 2.0, options: .curveEaseOut, animations: {
                toastView.alpha = 0.0
            }, completion: { (_) in
                toastView.removeFromSuperview()
            })
        }
    }
}

extension UIViewController{
    func handleInternetError(error: NSError){
        //Request time out -> Error code 13
        if error.domain == "internet"{
            let dest = HSNetworkAlertVC()
            self.navigateToVCWithNavController(vc: dest)
        }
    }
    
    var className: String {
        NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
}
