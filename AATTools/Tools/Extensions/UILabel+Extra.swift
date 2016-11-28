//
//  UILabel+Extra.swift
//  AATTools
//
//  Created by Albert Arroyo on 28/11/16.
//  Copyright © 2016 AlbertArroyo. All rights reserved.
//

import UIKit

public extension UILabel {
    
    /// Method to get estimated size
    /// - Parameters:
    ///     - width: CGFloat, by default CGFloat.greatestFiniteMagnitude
    ///     - height: CGFloat, by default CGFloat.greatestFiniteMagnitude
    /// - Returns: CGSize
    public func getEstimatedSize(width w: CGFloat = CGFloat.greatestFiniteMagnitude, height h: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize {
        return sizeThatFits(CGSize(width: w, height: h))
    }
    
    /// Method to set text animated with duration. The animation option is .transitionCrossDissolve
    /// - Parameters:
    ///     - text: String? text
    ///     - animated: Bool to animate
    ///     - duration: TimeInterval (Double) with duration
    public func setText(_ text: String?, animated: Bool, duration: TimeInterval) {
        if animated {
            UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: { () -> Void in
                self.text = text
            }, completion: nil)
        } else {
            self.text = text
        }
    }
    
    /// Method to set text animated with duration and delay. The animation option is .transitionCrossDissolve
    /// - Parameters:
    ///     - text: String? text
    ///     - animated: Bool to animate
    ///     - duration: TimeInterval (Double) with duration
    ///     - delay: TimeInterval (Double) with delay
    public func setText(_ text: String?, animated: Bool, duration: TimeInterval, delay: TimeInterval) {
        
        //FYI: be carefull with the locale when converting double to string
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: Locale.current.identifier)
        
        let strDuration = formatter.string(from: NSNumber(value: duration))
        let strAnimated = animated ? "true" : "false"
        let urserInfo = [text ?? "", strAnimated, strDuration]
        Timer.scheduledTimer(timeInterval: delay, target: self,
                             selector: #selector(callToSetText(_:)), userInfo: urserInfo, repeats: false)
        
    }
    
    /// Method for the selector of setText with delay to call setText after the delay
    @objc private func callToSetText(_ timer: Timer) {
        let userInfo = timer.userInfo as! [String]
        let text = userInfo[0]
        let animated = userInfo[1].toBool()!
        let duration = userInfo[2].toDouble()!
        setText(text, animated: animated, duration: duration)
    }
    
    /// Method to make substrings bold with `t` parameter with a font `f` parameter
    /// - Parameters:
    ///     - text: [String] array of substrings
    ///     - font: UIFont?, if not assigned takes the system font with default pointSize
    func makeSubstringsBold(text t: [String], font f: UIFont?) {
        t.forEach { self.makeSubstringBold(text: $0, font: f ?? UIFont.boldSystemFont(ofSize: self.font.pointSize)) }
    }
    
    /// Method to make substring bold with `text` parameter with a font `f` parameter
    /// - Parameters:
    ///     - text: String of substring
    ///     - font: UIFont?, if not assigned takes the system font with default pointSize
    func makeSubstringBold(text boldText: String, font f: UIFont?) {
        let attributedText = self.attributedText!.mutableCopy() as! NSMutableAttributedString
        
        let range = ((self.text ?? "") as NSString).range(of: boldText)
        if range.location != NSNotFound {
            attributedText.setAttributes([NSFontAttributeName: f ?? UIFont.boldSystemFont(ofSize: self.font.pointSize)], range: range)
        }
        
        self.attributedText = attributedText
    }
    
    /// Method to make substrings italic with `t` parameter with a font `f` parameter
    /// - Parameters:
    ///     - text: [String] array of substrings
    ///     - font: UIFont?, if not assigned takes the system font with default pointSize
    func makeSubstringsItalic(text t: [String], font f: UIFont?) {
        t.forEach { self.makeSubstringItalic(text: $0, font: f ?? UIFont.italicSystemFont(ofSize:  self.font.pointSize)) }
    }
    
    /// Method to make substring italic with `text` parameter with a font `f` parameter
    /// - Parameters:
    ///     - text: String of substring
    ///     - font: UIFont?, if not assigned takes the system font with default pointSize
    func makeSubstringItalic(text italicText: String, font f: UIFont?) {
        let attributedText = self.attributedText!.mutableCopy() as! NSMutableAttributedString
        
        let range = ((self.text ?? "") as NSString).range(of: italicText)
        if range.location != NSNotFound {
            attributedText.setAttributes([NSFontAttributeName: f ?? UIFont.italicSystemFont(ofSize:  self.font.pointSize)], range: range)
        }
        
        self.attributedText = attributedText
    }
    
    /// Method to set the line height with `lineHeight` parameter
    /// - Parameters:
    ///     - lineHeight: Int lineHeight
    func setLineHeight(_ lineHeight: Int) {
        let displayText = text ?? ""
        let attributedString = self.attributedText!.mutableCopy() as! NSMutableAttributedString
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = CGFloat(lineHeight)
        paragraphStyle.alignment = textAlignment
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, displayText.characters.count))
        
        attributedText = attributedString
    }
    
}

