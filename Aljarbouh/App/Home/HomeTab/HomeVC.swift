//
//  HomeVC.swift
//  Aljarbouh
//
//  Created by Hendawi on 20/02/2024.
//

import UIKit
import Kingfisher

class HomeVC: UIViewController {
    private let newsViewModel = NewsViewModel()
    private let meetingsViewModel = MeetingsViewModel()
    
    @IBOutlet weak var searchTF: UITextField!
    
    @IBOutlet weak var contributeBtn: UIButton!
    @IBOutlet weak var interestedBtn: UIButton!
    
    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var addressView: UIView!
    
    @IBOutlet weak var businessSectorCollectionView: UICollectionView!
    
    var news = [News]()
    var newsCellID = "NewsCollectionCell"
    var businessCellID = "BusinessSectorCollectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(self)
        
        initViews()
        
        initCollectionViews()
        
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getData()
    }
    
    private func initViews(){
        
        searchTF.addSearchIcon()
        
        contributeBtn.layer.cornerRadius = 10
        
        interestedBtn.layer.borderColor = UIColor.lightGray.cgColor
        interestedBtn.layer.borderWidth = 1
        interestedBtn.layer.cornerRadius = 10
        
        imageView.layer.cornerRadius = 20
        dateView.layer.cornerRadius = 25
        dateView.layer.borderWidth = 1
        dateView.layer.borderColor = UIColor.white.cgColor
        addressView.layer.cornerRadius = 15
        addressView.layer.borderWidth = 1
        addressView.layer.borderColor = UIColor.white.cgColor
        
        imageView.addGradientOverlay()
    }

    func initCollectionViews(){
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        newsCollectionView.register(UINib(nibName: newsCellID, bundle: nil), forCellWithReuseIdentifier: newsCellID)
        newsCollectionView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)

        businessSectorCollectionView.delegate = self
        businessSectorCollectionView.dataSource = self
        businessSectorCollectionView.register(UINib(nibName: businessCellID, bundle: nil), forCellWithReuseIdentifier: businessCellID)
        businessSectorCollectionView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    
    func getData(){
        displayAnimatedActivityIndicatorView()
        newsViewModel.list{ [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success:
                self.news = newsViewModel.news
                self.newsCollectionView.reloadData()
                self.hideAnimatedActivityIndicatorView()
            case .failure(let error as NSError):
                self.hideAnimatedActivityIndicatorView()
                self.handleInternetError(error: error)
            }
        }
    }
    
    @IBAction func sidemenuBtnClicked(_ sender: UIButton) {
        navigateToVC(vc: "SideMenuVC", inStoryboard: "SideMenu")
    }
    
    @IBAction func moreNewsBtnClicked(_ sender: UIButton) {
        let dest = self.storyboard?.instantiateViewController(withIdentifier: "NewsVC") as! NewsVC
        dest.news = news
        dest.modalPresentationStyle = .fullScreen
        self.present(dest, animated: true)
    }
}

extension HomeVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case newsCollectionView:
            return min(news.count, 3)
        case businessSectorCollectionView:
            return 2
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case newsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: newsCellID, for: indexPath) as! NewsCollectionCell
            cell.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            cell.configureCell(news: news[indexPath.item])
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: businessCellID, for: indexPath) as! BusinessSectorCollectionCell
            cell.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case newsCollectionView:
            return CGSize(width: 300, height: 200)
        default:
            return CGSize(width: 270, height: 300)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, estimatedSizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case newsCollectionView:
            return CGSize(width: 300, height: 200)
        default:
            return CGSize(width: 270, height: 300)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
