//
//  MeetingDetailsVC.swift
//  Aljarbouh
//
//  Created by Hendawi on 06/03/2024.
//

import UIKit
import Kingfisher

class MeetingDetailsVC: UIViewController {

    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var monthLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var remainingTimeLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
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
    
    let collectionCell = "MembersCollectionCell"
    
    var meeting = Meeting()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        initCollectionView()
        setData()
    }
    
    private func initViews(){
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
        
        mapView.layer.cornerRadius = 20
        directionsBtn.layer.cornerRadius = 10
    }
    
    private func initCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: collectionCell, bundle: nil), forCellWithReuseIdentifier: collectionCell)
        collectionView.semanticContentAttribute = .forceRightToLeft
    }
    
    private func setData(){
        if let media = meeting.media?.first,
           let urlString = media.url,
           let url = URL(string: urlString) {
            backgroundImg.kf.setImage(with: url, placeholder: UIImage(named: "image1"), options: [.transition(ImageTransition.fade(0.2))])
        } else {
            backgroundImg.image = UIImage(named: "image1")
        }
        
        addressLbl.text = meeting.address ?? "-"
        timeLbl.text = "الساعة \(meeting.hours ?? "-")"
        dayLbl.text = String(meeting.date?.extractDay() ?? 0)
        monthLbl.text = meeting.date?.extractMonth() ?? "-"
        titleLbl.text = meeting.title ?? "-"
        descriptionLbl.text = meeting.description ?? "-"
    }
}

extension MeetingDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      if let attendees = meeting.attendees {
        return attendees.count
      } else {
        // Handle the case where attendees is nil
        return 0 // Or some other default value
      }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let attendees = meeting.attendees else {
        // Handle the case where attendees is nil
        return UICollectionViewCell() // Or some placeholder cell
      }

      guard attendees.indices.contains(indexPath.item) else {
        // Handle the case where indexPath is out of bounds
        return UICollectionViewCell() // Or some placeholder cell
      }

      let attendee = attendees[indexPath.item]
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCell, for: indexPath) as! MembersCollectionCell
      cell.configureCell(object: attendee)
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
