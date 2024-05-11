//
//  NewsVC.swift
//  Aljarbouh
//
//  Created by Hendawi on 25/02/2024.
//

import UIKit

class NewsVC: UIViewController {
    private let viewModel = NewsViewModel()

//    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
//    var collectionCellID = "NewsCollectionCell"
    var tableCellID = "NewsTableCell"
    var tableMainCellID = "NewsMainTableCell"
    var news = [News]()
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }
    
    private func initViews(){
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        
//        collectionView.register(UINib(nibName: collectionCellID, bundle: nil), forCellWithReuseIdentifier: collectionCellID)
//        collectionView.semanticContentAttribute = .forceRightToLeft
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: tableCellID, bundle: nil), forCellReuseIdentifier: tableCellID)
        tableView.register(UINib(nibName: tableMainCellID, bundle: nil), forCellReuseIdentifier: tableMainCellID)
        
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func loadData() {
        getData()
    }
    
    func getData(){
        displayAnimatedActivityIndicatorView()
        viewModel.list{ [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success:
                self.news = viewModel.news
                self.tableView.reloadData()
                self.hideAnimatedActivityIndicatorView()
                refreshControl.endRefreshing()
            case .failure(let error as NSError):
                self.hideAnimatedActivityIndicatorView()
                self.handleInternetError(error: error)
            }
        }
    }
}

//extension NewsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return news.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! NewsCollectionCell
//        cell.configureCell(news: news[indexPath.row])
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 300, height: 200)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, estimatedSizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 300, height: 200)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 8
//    }
//}

extension NewsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: tableMainCellID, for: indexPath) as! NewsMainTableCell
            cell.configureCell(news: news[indexPath.row])
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: tableCellID, for: indexPath) as! NewsTableCell
            cell.configureCell(news: news[indexPath.row])
            cell.configureShowButton(indexPath: indexPath, target: self, action: #selector(showNewsBtnClicked(_:)))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let dest = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailsVC") as! NewsDetailsVC
            dest.news = news
            dest.newsDetails = news[0]
            dest.modalPresentationStyle = .fullScreen
            present(dest, animated: true)
        }
    }
    
    @objc func showNewsBtnClicked(_ sender: UIButton){
        let dest = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailsVC") as! NewsDetailsVC
        dest.news = news
        dest.newsDetails = news[sender.tag]
        dest.modalPresentationStyle = .fullScreen
        present(dest, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 200
        default:
            return 145
        }
    }
}
