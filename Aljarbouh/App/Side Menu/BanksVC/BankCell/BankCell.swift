//
//  BankCell.swift
//  Aljarbouh
//
//  Created by Hendawi on 08/03/2024.
//

import UIKit
import Kingfisher

class BankCell: UITableViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var bankLogo: UIImageView!
    @IBOutlet weak var accountTypeLbl: UILabel!
    @IBOutlet weak var accNumLbl: UILabel!
    @IBOutlet weak var ibanNumLbl: UILabel!
    @IBOutlet var copyBtns: [UIButton]!

    override func awakeFromNib() {
        super.awakeFromNib()

        parentView.layer.cornerRadius = 10
        parentView.dropShadow(radius: 10)
        
        for btn in copyBtns {
            btn.layer.cornerRadius = 15
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(bank: Bank) {
        if let url = URL(string: bank.image ?? "") {
            bankLogo.kf.setImage(with: url, placeholder: UIImage(systemName: "banknote") ,options: [.transition(ImageTransition.fade(0.2))])
        }
        accountTypeLbl.text = bank.type
        accNumLbl.text = bank.accountNumber
        ibanNumLbl.text = bank.iban
        
    }

    @IBAction func copyClicked(_ sender: UIButton) {
        var textToCopy = ""
        switch sender.tag {
        case 1: 
            textToCopy = accNumLbl.text!
            let toastView = ToastView(message: "تم نسخ رقم الحساب الى الحافظة")
            toastView.show(in: self)
        case 2:
            textToCopy = ibanNumLbl.text!
            let toastView = ToastView(message: "تم نسخ رقم IBAN الى الحافظة")
            toastView.show(in: self)
        default:
            break
        }
        UIPasteboard.general.string = textToCopy
    }

}
