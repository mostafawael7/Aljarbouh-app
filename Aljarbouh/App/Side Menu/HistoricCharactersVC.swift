//
//  HistoricCharactersVC.swift
//  Aljarbouh
//
//  Created by Hendawi on 09/03/2024.
//

import UIKit

class HistoricCharactersVC: UIViewController {

    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var cellID = "FamilyTreeTableCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
    }
    
}

extension HistoricCharactersVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! FamilyTreeTableCell
        if indexPath.row % 2 == 0 {
            cell.isStar()
        }else{
            cell.isDead()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToVC(vc: "FamilyMemberDetailsVC", inStoryboard: "Home")
    }
}
