//
//  BanksVC.swift
//  Aljarbouh
//
//  Created by Hendawi on 08/03/2024.
//

import UIKit

class BanksVC: UIViewController {
    private let viewModel = BanksViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    let tableCell = "BankCell"
    
    private var banks = [Bank]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        
        getData()
    }
    
    private func initTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: tableCell, bundle: nil), forCellReuseIdentifier: tableCell)
    }
    
    func getData(){
        displayAnimatedActivityIndicatorView()
        viewModel.list{ [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success:
                self.banks = viewModel.banks
                self.tableView.reloadData()
                self.hideAnimatedActivityIndicatorView()
            case .failure(let error as NSError):
                self.hideAnimatedActivityIndicatorView()
                self.handleInternetError(error: error)
            }
        }
    }
}

extension BanksVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return banks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCell, for: indexPath) as! BankCell
        cell.configureCell(bank: banks[indexPath.row])
        return cell
    }
}
