//
//  UIView.swift
//  Tawasol ERP
//
//  Created by tawasol alriyadh on 26/12/2023.
//

import UIKit

public extension UIView {
    
    /// SwifterSwift: Border color of view; also inspectable from Storyboard.
    var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            // Fix React-Native conflict issue
            guard String(describing: type(of: color)) != "__NSCFType" else { return }
            layer.borderColor = color.cgColor
        }
    }
    
    /// SwifterSwift: Border width of view; also inspectable from Storyboard.
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// SwifterSwift: Corner radius of view; also inspectable from Storyboard.
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
    /// SwifterSwift: Height of view.
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    /// SwifterSwift: Check if view is in RTL format.
    var isRightToLeft: Bool {
        return effectiveUserInterfaceLayoutDirection == .rightToLeft
    }
    
    /// SwifterSwift: Take screenshot of view (if applicable).
    var screenshot: UIImage? {
        let size = layer.frame.size
        guard size != .zero else { return nil }
        return UIGraphicsImageRenderer(size: layer.frame.size).image { context in
            layer.render(in: context.cgContext)
        }
    }
    
    /// SwifterSwift: Shadow color of view; also inspectable from Storyboard.
    //    @IBInspectable var shadowColor: UIColor? {
    //        get {
    //            guard let color = layer.shadowColor else { return nil }
    //            return UIColor(cgColor: color)
    //        }
    //        set {
    //            layer.shadowColor = newValue?.cgColor
    //        }
    //    }
    //
    //    /// SwifterSwift: Shadow offset of view; also inspectable from Storyboard.
    //    @IBInspectable var shadowOffset: CGSize {
    //        get {
    //            return layer.shadowOffset
    //        }
    //        set {
    //            layer.shadowOffset = newValue
    //        }
    //    }
    //
    //    /// SwifterSwift: Shadow opacity of view; also inspectable from Storyboard.
    //    @IBInspectable var shadowOpacity: Float {
    //        get {
    //            return layer.shadowOpacity
    //        }
    //        set {
    //            layer.shadowOpacity = newValue
    //        }
    //    }
    //
    //    /// SwifterSwift: Shadow radius of view; also inspectable from Storyboard.
    //    @IBInspectable var shadowRadius: CGFloat {
    //        get {
    //            return layer.shadowRadius
    //        }
    //        set {
    //            layer.shadowRadius = newValue
    //        }
    //    }
    
    /// SwifterSwift: Masks to bounds of view; also inspectable from Storyboard.
    var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
    /// SwifterSwift: Size of view.
    var size: CGSize {
        get {
            return frame.size
        }
        set {
            width = newValue.width
            height = newValue.height
        }
    }
    
    /// SwifterSwift: Get view's parent view controller
    var parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    /// SwifterSwift: Width of view.
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    /// SwifterSwift: x origin of view.
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    /// SwifterSwift: y origin of view.
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
}

extension UIView {
    func dropShadow(radius: CGFloat) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = .zero
        layer.shadowRadius = radius
        
        // Calculate shadow path if not set
        if layer.shadowPath == nil {
            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            layer.rasterizationScale = UIScreen.main.scale
        }
    }
}
