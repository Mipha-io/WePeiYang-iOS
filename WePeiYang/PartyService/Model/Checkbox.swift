//
//  Checkbox.swift
//  WePeiYang
//
//  Created by Allen X on 8/25/16.
//  Copyright © 2016 Qin Yubo. All rights reserved.
//

import UIKit

class Checkbox: UIButton {
    
    let partyGray = UIColor(colorLiteralRed: 149.0/255.0, green: 149.0/255.0, blue: 149.0/255.0, alpha: 1)
    
    typealias Quiz = Courses.Study20.Quiz
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var nameLabel = UILabel()
    var wasChosen = false
    var belongsToMany = false
    
    override func addTarget(target: AnyObject?, action: Selector, forControlEvents controlEvents: UIControlEvents) {
        super.addTarget(target, action: action, forControlEvents: controlEvents)
        let tapOnLabel = UITapGestureRecognizer(target: target, action: action)
        self.nameLabel.addGestureRecognizer(tapOnLabel)
    }
    
    static func initOnlyChoiceBtns(with quizOptions: [Quiz.Option]) -> [Checkbox] {
            return quizOptions.flatMap({ (option: Quiz.Option) -> Checkbox? in
                return Checkbox(withSingleChoiceBtn: option)
            })
    }
    
    static func initMultiChoicesBtns(with quizOptions: [Quiz.Option]) -> [Checkbox] {
        return quizOptions.flatMap({ (option: Quiz.Option) -> Checkbox? in
            return Checkbox(withMultiChoicesBtn: option)
        })
    }
    
    convenience init(withSingleChoiceBtn quizOptionSingleChoice: Quiz.Option) {
        self.init()
        self.nameLabel = {
            let foo = UILabel(text: quizOptionSingleChoice.name, fontSize: 16)
            foo.userInteractionEnabled = true
            foo.textColor = .blackColor()
            return foo
        }()
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.tag = quizOptionSingleChoice.weight
        self.frame.size = CGSize(width: 20, height: 20)
        self.layer.cornerRadius = self.frame.width/2
        if quizOptionSingleChoice.wasChosen {
            self.backgroundColor = .greenColor()
            self.wasChosen = true
        } else {
            self.backgroundColor = partyGray
        }
        /*
        self.addSubview(self.nameLabel)
        self.nameLabel.snp_makeConstraints {
            make in
            make.centerY.equalTo(self)
            make.left.equalTo(self.snp_right).offset(10)
        }*/
        self.addTarget(self, action: #selector(Checkbox.beTapped), forControlEvents: .TouchUpInside)
    }
    
    convenience init(withMultiChoicesBtn quizOptionMultiChoices: Quiz.Option) {
        self.init()
        self.nameLabel = {
            let foo = UILabel(text: quizOptionMultiChoices.name, fontSize: 16)
            foo.userInteractionEnabled = true
            foo.textColor = .blackColor()
            return foo
        }()
        
        //self.layer.cornerRadius = self.frame.width/2
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.tag = quizOptionMultiChoices.weight
        if quizOptionMultiChoices.wasChosen {
            self.backgroundColor = .greenColor()
            self.wasChosen = true
        } else {
            self.backgroundColor = partyGray
        }
        
        /*
        self.addSubview(self.nameLabel)
        self.nameLabel.snp_makeConstraints {
            make in
            make.centerY.equalTo(self)
            make.left.equalTo(self.snp_right).offset(10)
        }*/
        self.belongsToMany = true
        self.addTarget(self, action: #selector(Checkbox.beTapped), forControlEvents: .TouchUpInside)
    }
    
    func beTapped() {
        
        if self.belongsToMany {
            self.wasChosen = !self.wasChosen
        } else {
            if !self.wasChosen {
                self.wasChosen = !self.wasChosen
            }
        }
        self.refreshStatus()
    }
    
    func refreshStatus() {
        if self.wasChosen {
            self.backgroundColor = .greenColor()
        } else {
            self.backgroundColor = partyGray
        }
    }

}
