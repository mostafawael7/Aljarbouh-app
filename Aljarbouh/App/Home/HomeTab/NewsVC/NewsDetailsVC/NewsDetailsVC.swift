//
//  NewsDetailsVC.swift
//  Aljarbouh
//
//  Created by Hendawi on 01/03/2024.
//

import UIKit
import Kingfisher

class NewsDetailsVC: UIViewController {

    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
//    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    var news = [News]()
    var newsDetails: News?
    var tableCellID = "NewsTableCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        
        setData()
        
        adjustLayout()
    }
    
    private func initViews(){
        shareBtn.layer.cornerRadius = 20
        
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UINib(nibName: tableCellID, bundle: nil), forCellReuseIdentifier: tableCellID)
    }
    
    private func setData(){
        if let url = URL(string: newsDetails?.imageURL ?? "") {
            newsImage.kf.setImage(with: url, placeholder: UIImage(named: "image1"), options: [.transition(ImageTransition.fade(0.2))])
        }
        dateLbl.text = newsDetails?.createdAt?.extractDateInArabic()
        titleLbl.text = newsDetails?.title ?? "-"
        descriptionLbl.text = newsDetails?.description ?? "-"
    }
    
    func adjustLayout() {
        // Calculate the required height for the label
        let labelSize = descriptionLbl.sizeThatFits(CGSize(width: descriptionLbl.frame.width, height: CGFloat.greatestFiniteMagnitude))
        
        // Update the label height constraint (assuming you are using Auto Layout)
        descriptionLbl.heightAnchor.constraint(equalToConstant: labelSize.height).isActive = true
        
        print(labelSize)
        
        // Update the content size of the scroll view
        //            scrollView.contentSize = CGSize(width: scrollView.frame.width, height: labelSize.height + /* add height for image view, table view, and spacing */)
        viewHeight.constant += labelSize.height
    }
}

//extension NewsDetailsVC: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellID, for: indexPath) as! NewsTableCell
//        cell.configureCell(news: news[indexPath.row])
//        return cell
//    }
//}
