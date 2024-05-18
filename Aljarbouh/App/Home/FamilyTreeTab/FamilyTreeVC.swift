//
//  FamilyTreeVC.swift
//  Aljarbouh
//
//  Created by Hendawi on 20/02/2024.
//

import UIKit

class FamilyTreeVC: UIViewController {
    private let viewModel = FamilyTreeViewModel()

    @IBOutlet weak var filterBtn: FilterButton!
    @IBOutlet weak var filtersStack: UIStackView!
    
    @IBOutlet weak var searchBtn: UIButton!
    
    @IBOutlet weak var allFilterBtn: FilterButton!
    @IBOutlet weak var aliveFilterBtn: FilterButton!
    @IBOutlet weak var deadFilterBtn: FilterButton!
    @IBOutlet weak var menFilterBtn: FilterButton!
    @IBOutlet weak var womenFilterBtn: FilterButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var cellID = "FamilyTreeTableCell"
    
    var profiles = [Profile]()
    
    private var deadOrAlivefilter = false
    private var maleOrFemalefilter = false
    var filter = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getData()
        
    }
    
    private func initViews(){
        filterBtn.layer.cornerRadius = 24
        filtersStack.isHidden = true
        
        searchBtn.layer.cornerRadius = 10
        searchBtn.layer.borderWidth = 0.5
        searchBtn.layer.borderColor = UIColor.lightGray.cgColor
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
    }
    
    private func getData(){
        displayAnimatedActivityIndicatorView()
        viewModel.list(filter: filter){ [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success:
                self.profiles = viewModel.profiles
                self.tableView.reloadData()
                self.hideAnimatedActivityIndicatorView()
            case .failure(let error as NSError):
                self.hideAnimatedActivityIndicatorView()
                self.handleInternetError(error: error)
            }
        }
    }
    
    @IBAction func filterBtnClicked(_ sender: FilterButton) {
        filtersStack.isHidden.toggle()
        filterBtn.isSelected.toggle()
    }
    
    @IBAction func searchBtnClicked(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let dest = storyboard.instantiateViewController(withIdentifier: "FamilyTreeFilterVC") as! FamilyTreeFilterVC
        dest.completion = { [weak self] data in
            guard let self = self else{ return }
            self.filter = data
        }
        dest.modalPresentationStyle = .fullScreen
        self.present(dest, animated: true)
    }
    
    @IBAction func applyFilterBtnClicked(_ sender: FilterButton) {
        if sender == allFilterBtn && !allFilterBtn.isSelected {
            allFilterBtn.isSelected = true
            aliveFilterBtn.isSelected = false
            deadFilterBtn.isSelected = false
            if menFilterBtn.isSelected{
                filter = "?gender=1"
            }else if womenFilterBtn.isSelected {
                filter = "?gender=0"
            }else{
                filter = ""
            }
            getData()
        } else if sender == aliveFilterBtn && !aliveFilterBtn.isSelected {
            allFilterBtn.isSelected = false
            aliveFilterBtn.isSelected = true
            deadFilterBtn.isSelected = false
            if menFilterBtn.isSelected{
                filter = "?life=1&gender=1"
            }else if womenFilterBtn.isSelected {
                filter = "?life=1&gender=0"
            }else{
                filter = "?life=1"
            }
            getData()
        } else if sender == deadFilterBtn && !deadFilterBtn.isSelected{
            allFilterBtn.isSelected = false
            aliveFilterBtn.isSelected = false
            deadFilterBtn.isSelected = true
            if menFilterBtn.isSelected{
                filter = "?life=0&gender=1"
            }else if womenFilterBtn.isSelected {
                filter = "?life=0&gender=0"
            }else{
                filter = "?life=0"
            }
            getData()
        }
    }
    
    @IBAction func genderFilterBtnClicked(_ sender: FilterButton) {
        if sender == menFilterBtn && !menFilterBtn.isSelected{
            menFilterBtn.isSelected = true
            womenFilterBtn.isSelected = false
            if allFilterBtn.isSelected {
                filter = "?gender=1"
            }else if aliveFilterBtn.isSelected {
                filter = "?life=1&gender=1"
            }else if deadFilterBtn.isSelected {
                filter = "?life=0&gender=1"
            }
            getData()
        } else if sender == womenFilterBtn && !womenFilterBtn.isSelected {
            menFilterBtn.isSelected = false
            womenFilterBtn.isSelected = true
            if allFilterBtn.isSelected {
                filter = "?gender=0"
            }else if aliveFilterBtn.isSelected {
                filter = "?life=1&gender=0"
            }else if deadFilterBtn.isSelected {
                filter = "?life=0&gender=0"
            }
            getData()
        } else {
            sender.isSelected.toggle()
            if aliveFilterBtn.isSelected {
                filter = "?life=1"
            }else if deadFilterBtn.isSelected {
                filter = "?life=0"
            }else{
                filter = ""
            }
            getData()
        }
    }
    
    @IBAction func sidemenuBtnClicked(_ sender: UIButton) {
        navigateToVC(vc: "SideMenuVC", inStoryboard: "SideMenu")
    }
}

extension FamilyTreeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! FamilyTreeTableCell
        cell.configureCell(profile: profiles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dest = self.storyboard?.instantiateViewController(withIdentifier: "FamilyMemberDetailsVC") as! FamilyMemberDetailsVC
        dest.modalPresentationStyle = .fullScreen
        dest.profile = profiles[indexPath.row]
        present(dest, animated: true)
    }
}
