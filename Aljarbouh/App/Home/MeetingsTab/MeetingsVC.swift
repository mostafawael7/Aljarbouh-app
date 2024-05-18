//
//  MeetingsVC.swift
//  Aljarbouh
//
//  Created by Hendawi on 20/02/2024.
//

import UIKit
import HorizontalCalendar

class MeetingsVC: UIViewController {
    private let viewModel = MeetingsViewModel()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var calendarViewLbl: UILabel!
    @IBOutlet weak var calendarBtn: UIButton!
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    @IBOutlet weak var navBarHeight: NSLayoutConstraint!
    
    @IBOutlet weak var noEventsLbl: UILabel!
    @IBOutlet weak var dayNumLbl: UILabel!
    @IBOutlet weak var dayNameLbl: UILabel!
    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var eventTitleLbl: UILabel!
    @IBOutlet weak var eventAddressLbl: UILabel!
    @IBOutlet weak var eventView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    let collectionCellID = "CalendarCollectionCell"
    let tableCellID = "MeetingsTableCell"
    let tableMainCellID = "MainMeetingsTableCell"
    var daysOfWeek = [
        "الجمعة",
        "السبت",
        "الأحد",
        "الاثنين",
        "الثلاثاء",
        "الأربعاء",
        "الخميس"
    ]
    
    var indexPath = IndexPath()
    
    let dateFormatter = DateFormatter()
    let currentDate = Date()
    var todaysDay = 0
    var todaysMonth = ""
    var todaysYear = 0
    
    var meetings = [Meeting]()
    var meeting: Meeting?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(self)
        
        initViews()
        
        todaysDay = getTodaysDay()
        todaysMonth = getCurrentMonth()
        todaysYear = getCurrentYear()
        
        let day = getFirstDayOfMonthName()
        daysOfWeek = sortDaysStartingFrom(day: day!)
        
        indexPath = IndexPath(item: todaysDay - 1, section: 0)
        calendarCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        calendarViewLbl.text = "\(todaysDay) \(todaysMonth)، \(todaysYear)"
        
        dateLbl.text = "\(todaysDay) \(todaysMonth)"
        dayNumLbl.text = String(todaysDay)
        
        if indexPath.item % 2 == 0 { // has event
            noEventsLbl.isHidden = false
            eventView.isHidden = true
        }else{ // no event
            noEventsLbl.isHidden = true
            eventView.isHidden = false
        }
        dayNameLbl.text = todaysMonth
        
        getData()
    }
    
    private func initViews(){
        calendarView.layer.cornerRadius = 22.5
        
        calendarBtn.layer.cornerRadius = 17.5
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal // Set the scroll direction to horizontal
        
        // Assign the flow layout to the collection view
        calendarCollectionView.collectionViewLayout = flowLayout
        
        // Set semanticContentAttribute to force right-to-left layout
        calendarCollectionView.semanticContentAttribute = .forceRightToLeft
        
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
        calendarCollectionView.register(UINib(nibName: collectionCellID, bundle: nil), forCellWithReuseIdentifier: collectionCellID)
        calendarCollectionView.allowsMultipleSelection = false
        calendarCollectionView.layer.cornerRadius = 15
        
        calendarCollectionView.isHidden = true
        navBarHeight.constant = 150
        
        coverImage.layer.cornerRadius = 10
        dayView.layer.cornerRadius = 10
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: tableCellID, bundle: nil), forCellReuseIdentifier: tableCellID)
        tableView.register(UINib(nibName: tableMainCellID, bundle: nil), forCellReuseIdentifier: tableMainCellID)
        
    }
    
    func getTodaysDay() -> Int {
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "d" // Use 'd' to get only the day component
        let formattedDayString = dateFormatter.string(from: currentDate)

        // Convert the formatted day string to an integer
        if let formattedDayInt = Int(formattedDayString) {
            return formattedDayInt
        } else {
            // Handle the case where conversion to Int fails
            return 0
        }
    }
    
    func getCurrentMonth() -> String {
        dateFormatter.locale = Locale(identifier: "ar") // Set the locale to Arabic
        
        // Set the date format to get the month name
        dateFormatter.dateFormat = "LLLL"
        
        // Get the month name in Arabic
        let arabicMonth = dateFormatter.string(from: currentDate)
        
        return arabicMonth
    }
    
    func getCurrentYear() -> Int {
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "yyyy" // Use 'yyyy' to get the full year component

        let formattedYearString = dateFormatter.string(from: currentDate)

        print(formattedYearString)
        // Convert the formatted year string to an integer
        if let formattedYearInt = Int(formattedYearString) {
            return formattedYearInt
        } else {
            // Handle the case where conversion to Int fails
            return 0
        }
    }

    func getFirstDayOfMonthName() -> String? {
        let currentDate = Date()
        let calendar = Calendar.current
        
        // Get the components of the current date
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        
        // Create a new date representing the first day of the month
        guard let firstDayOfMonth = calendar.date(from: components) else {
            return nil
        }
        
        // Get the weekday name of the first day of the month
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ar") // Set the locale to Arabic
        dateFormatter.dateFormat = "EEEE" // Use 'EEEE' to get the full weekday name
        
        return dateFormatter.string(from: firstDayOfMonth)
    }
    
    func sortDaysStartingFrom(day: String) -> [String] {
        
        guard let startIndex = daysOfWeek.firstIndex(of: day) else {
            return daysOfWeek // Return the original array if the specified day is not found
        }
        
        let sortedDays = Array(daysOfWeek[startIndex...] + daysOfWeek[..<startIndex])
        return sortedDays
    }

    func getData(){
        displayAnimatedActivityIndicatorView()
        viewModel.list(){ [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success:
                self.meetings = viewModel.meetings
                self.adjustLayout(count: self.meetings.count)
                self.tableView.reloadData()
                self.hideAnimatedActivityIndicatorView()
            case .failure(let error as NSError):
                self.hideAnimatedActivityIndicatorView()
                self.handleInternetError(error: error)
            }
        }
    }
    
    func getDataInDate(date: String){
        displayAnimatedActivityIndicatorView()
        viewModel.retrieve(date: date){ [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success:
                self.meeting = viewModel.meeting
                self.adjustLayout(count: self.meetings.count)
                self.tableView.reloadData()
                self.hideAnimatedActivityIndicatorView()
            case .failure(let error as NSError):
                self.hideAnimatedActivityIndicatorView()
                self.handleInternetError(error: error)
            }
        }
    }
    
    private func adjustLayout(count: Int){
//        if count == 0 {
//            print("0")
//            scrollView.isScrollEnabled = false
//            tableView.isHidden = true
//            mainViewHeight.constant += 1000
//        }else if count == 1 {
//            print("1")
//            scrollView.isScrollEnabled = true
//            tableView.isHidden = false
//            tableViewHeight.constant = 250
//            mainViewHeight.constant = 500 + 250
//        }else if count > 1 {
//            print(">1")
//            scrollView.isScrollEnabled = true
//            tableView.isHidden = false
//            tableViewHeight.constant = CGFloat(250 + (meetings.count - 1) * 150)
//            mainViewHeight.constant = CGFloat(400 + 250 + (meetings.count - 1) * 150)
//        }
        tableViewHeight.constant = CGFloat(250 * count)
        mainViewHeight.constant = CGFloat(250 * count)
//        printHeights()
    }
    
    @IBAction func sidemenuBtnClicked(_ sender: UIButton) {
        navigateToVC(vc: "SideMenuVC", inStoryboard: "SideMenu")
    }
    
    @IBAction func calendarBtnClicked(_ sender: UIButton) {
        if calendarCollectionView.isHidden {
            calendarCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            calendarCollectionView.isHidden = false
            navBarHeight.constant = 270
            tableViewHeight.constant += 120
            mainViewHeight.constant += 120
        }else{
            calendarCollectionView.isHidden = true
            navBarHeight.constant = 150
//            tableViewHeight.constant -= 120
//            mainViewHeight.constant -= 120
        }
    }
    
    func printHeights(){
        print("tableViewHeight: \(tableViewHeight.constant)")
        print("mainViewHeight: \(mainViewHeight.constant)")
    }
    
}

extension MeetingsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Get the current calendar and today's date
        let calendar = Calendar.current
        
        // Get the range of days in the current month
        let range = calendar.range(of: .day, in: .month, for: currentDate)!
        
        // Return the number of days in the current month
        return range.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = calendarCollectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! CalendarCollectionCell
        let day = indexPath.item + 1
        
        // Configure the cell with the day number
        cell.configureCell(name: daysOfWeek[indexPath.item % daysOfWeek.count], num: String(day), hasEvent: day == getTodaysDay())
            
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let date = "\(todaysYear)-\(Calendar.current.component(.month, from: currentDate))-\(indexPath.item + 1)"
        getDataInDate(date: date)
        
        calendarViewLbl.text = "\(indexPath.item + 1) \(todaysMonth)، \(todaysYear)"
        dateLbl.text = "\(indexPath.item + 1) \(todaysMonth)"
        dayNumLbl.text = String(indexPath.item + 1)
        eventTitleLbl.text = meeting?.title
        
        if meeting == nil { // no event
            noEventsLbl.isHidden = false
            eventView.isHidden = true
        }else{ // has event
            noEventsLbl.isHidden = true
            eventView.isHidden = false
        }
        calendarBtnClicked(self.calendarBtn)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, estimatedSizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
}

extension MeetingsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meetings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: tableMainCellID, for: indexPath) as! MainMeetingsTableCell
            cell.configureCell(object: meetings[indexPath.row])
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: tableCellID, for: indexPath) as! MeetingsTableCell
            cell.configureCell(object: meetings[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dest = self.storyboard?.instantiateViewController(withIdentifier: "MeetingDetailsVC") as! MeetingDetailsVC
        dest.meeting = meetings[indexPath.row]
        dest.modalPresentationStyle = .fullScreen
        present(dest, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 250
        default:
            return 150
        }
    }
}
