//
//  NotificationsVC.swift
//  Aljarbouh
//
//  Created by Hendawi on 09/03/2024.
//

import UIKit

class NotificationsVC: UIViewController {
    private let viewModel = NotificationsViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    let tableCell = "NotificationsCell"
    
    private var notifications = [Notification]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        
        getData()
    }
    
    private func initTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: tableCell, bundle: nil), forCellReuseIdentifier: tableCell)
        tableView.semanticContentAttribute = .forceRightToLeft
    }
    
    func getData(){
        displayAnimatedActivityIndicatorView()
        viewModel.list{ [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success:
                self.notifications = viewModel.notifications
                self.tableView.reloadData()
                self.hideAnimatedActivityIndicatorView()
            case .failure(let error as NSError):
                self.hideAnimatedActivityIndicatorView()
                self.handleInternetError(error: error)
            }
        }
    }
}

extension NotificationsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white // Set the background color as desired
        
        let titleLabel = UILabel()
//        titleLabel.text = sections[section]
        titleLabel.textColor = UIColor.primary // Set the text color as desired
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20) // Set the font and size as desired
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.isHidden = true
        
        let button = UIButton(type: .system)
        button.setTitle("مسح الكل", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = section
        
        headerView.addSubview(titleLabel)
        headerView.addSubview(button)
        
        // Add constraints to position the label at the right and the button at the left within the header view
        NSLayoutConstraint.activate([
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            button.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            button.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        // Handle button tap here
        print("Button tapped in section \(sender.tag)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCell, for: indexPath) as! NotificationsCell
        cell.configureCell(notification: notifications[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let cell = tableView.cellForRow(at: indexPath) as? NotificationsCell {
//            cell.countView.isHidden = true
//        }
    }
}
