//
//  MeetingDetailsVC.swift
//  Aljarbouh
//
//  Created by Hendawi on 06/03/2024.
//

import UIKit

class MeetingDetailsVC: UIViewController {

    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var attendeesView: UIView!
    @IBOutlet weak var interestedBtn: UIButton!
    @IBOutlet weak var membersStackView: UIStackView!
    @IBOutlet weak var member1: UIImageView!
    @IBOutlet weak var member2: UIImageView!
    @IBOutlet weak var member3: UIImageView!
    @IBOutlet weak var member4: UIImageView!
    @IBOutlet weak var member5: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mapView: UIImageView!
    @IBOutlet weak var directionsBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    let collectionCell = "MembersCollectionCell"
    let tableCell = "MeetingsTableCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationView.layer.cornerRadius = 10
        timeView.layer.cornerRadius = 10
        dateView.layer.cornerRadius = 30
        attendeesView.layer.cornerRadius = 20
        interestedBtn.layer.cornerRadius = 20
        
        membersStackView.semanticContentAttribute = .forceRightToLeft
        member1.layer.cornerRadius = 16
        member2.layer.cornerRadius = 16
        member3.layer.cornerRadius = 16
        member4.layer.cornerRadius = 16
        member5.layer.cornerRadius = 16
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: collectionCell, bundle: nil), forCellWithReuseIdentifier: collectionCell)
        collectionView.semanticContentAttribute = .forceRightToLeft
        
        mapView.layer.cornerRadius = 20
        directionsBtn.layer.cornerRadius = 10
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: tableCell, bundle: nil), forCellReuseIdentifier: tableCell)
    }
}

extension MeetingDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCell, for: indexPath) as! MembersCollectionCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, estimatedSizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension MeetingDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCell, for: indexPath) as! MeetingsTableCell
        return cell
    }
}
