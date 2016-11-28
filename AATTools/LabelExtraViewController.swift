//
//  LabelExtraViewController.swift
//  AATTools
//
//  Created by Albert Arroyo on 18/11/16.
//  Copyright © 2016 AlbertArroyo. All rights reserved.
//

import UIKit

class LabelExtraViewController: UIViewController {

    let label1: UILabel = {
        let l = UILabel()
        l.text = "Testing bold : No te digo trigo por no llamarte Rodrigor me cago en tus muelas sexuarl tiene musho peligro"
        l.font = UIFont.systemFont(ofSize: 12)
        l.numberOfLines = 0
        l.textColor = UIColor.black
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let fontBoldLabel1: UIFont = {
       return UIFont.boldSystemFont(ofSize: 14)
    }()
    
    let label2: UILabel = {
        let l = UILabel()
        l.text = "Testing italic : No te digo trigo por no llamarte Rodrigor me cago en tus muelas sexuarl tiene musho peligro"
        l.font = UIFont.systemFont(ofSize: 12)
        l.numberOfLines = 0
        l.textColor = UIColor.black
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let label3: UILabel = {
        let l = UILabel()
        l.text = "Testing line height: Lorem fistrum laboris consequat tiene musho peligro ut ut. No te digo trigo por no llamarte Rodrigor torpedo reprehenderit nisi ut."
        l.font = UIFont.systemFont(ofSize: 12)
        l.numberOfLines = 0
        l.textColor = UIColor.black
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    let label4: UILabel = {
        let l = UILabel()
        l.text = "Text that will change in 2 seconds...Text that will change in 2 seconds...Text that will change in 2 seconds...Text that will change in 2 seconds...Text that will change in 2 seconds..."
        l.font = UIFont.systemFont(ofSize: 12)
        l.numberOfLines = 0
        l.textColor = UIColor.black
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "lng.views.label.title".localized 
        
        setupView()
        
        applyBoldFor(label1)
        applyItalicFor(label2)
        label3.setLineHeight(16)
        applyChangeText(label: label4, text: "Text changed!", animation: true, duration: 0.7, delay: 2)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = UIColor.white
    }
    
    func setupView() {
        self.view.addSubview(label1)
        self.view.addSubview(label2)
        self.view.addSubview(label3)
        self.view.addSubview(label4)
        
        NSLayoutConstraint.activate(
            [
                label1.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
                label1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                label1.widthAnchor.constraint(equalToConstant: 300)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 30),
                label2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                label2.widthAnchor.constraint(equalToConstant: 300)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                label3.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 30),
                label3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                label3.widthAnchor.constraint(equalToConstant: 300)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                label4.topAnchor.constraint(equalTo: label3.bottomAnchor, constant: 30),
                label4.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                label4.widthAnchor.constraint(equalToConstant: 300)
            ]
        )
    }
    
    // MARK: Utils
    
    func applyBoldFor(_ label: UILabel) {
        label.makeSubstringsBold(text: ["Testing", "bold"], font: fontBoldLabel1)
    }
    
    func applyItalicFor(_ label: UILabel) {
        label.makeSubstringsItalic(text: ["Rodrigor", "tiene musho peligro"], font: nil)
    }
    
    func applyChangeText(label l: UILabel, text t: String, animation anim: Bool, duration dur: Double, delay del: Double) {
        l.setText(t, animated: anim, duration: dur, delay: del)
    }
}

