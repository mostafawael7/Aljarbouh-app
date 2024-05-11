//
//  CalendarCollectionCell.swift
//  Aljarbouh
//
//  Created by Hendawi on 06/03/2024.
//

import UIKit

class CalendarCollectionCell: UICollectionViewCell {

    @IBOutlet weak var dayNameLbl: UILabel!
    @IBOutlet weak var dayNumLbl: UILabel!
    @IBOutlet weak var dayParentView: UIView!
    @IBOutlet weak var isEventExistsView: UIView!
    
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        isEventExistsView.isHidden = true
        isEventExistsView.layer.cornerRadius = 3
        
        dayParentView.layer.cornerRadius = 20
        
    }

    override func prepareForReuse() {
        dayNameLbl.text = ""
        dayNumLbl.text = ""
        isEventExistsView.isHidden = true
    }
    
    public func configureCell(name: String, num: String, hasEvent: Bool){
        dayNameLbl.text = name
        dayNumLbl.text = num
        isEventExistsView.isHidden = !hasEvent
    }
    
    private func updateAppearance(){
        if isSelected{
            dayParentView.backgroundColor = .primary
            isEventExistsView.backgroundColor = .white
            dayNumLbl.textColor = .white
        }else {
            dayParentView.backgroundColor = .placeholder
            isEventExistsView.backgroundColor = .primary
            dayNumLbl.textColor = .black
        }
    }
}
