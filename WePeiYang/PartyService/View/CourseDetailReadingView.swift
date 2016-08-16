//
//  CourseDetailReadingView.swift
//  WePeiYang
//
//  Created by Allen X on 8/17/16.
//  Copyright © 2016 Qin Yubo. All rights reserved.
//

import UIKit

class CourseDetailReadingView: UIView, UIWebViewDelegate {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    func dismissAnimated() {
        log.word("haha")/
        UIView.animateWithDuration(0.7, animations: {
            self.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width/4, height: self.frame.height/2)
        }) { (_: Bool) in
                self.removeFromSuperview()
        }

    }

}

extension CourseDetailReadingView {
    convenience init(detail: Courses.Study20.Study20Course.Detail, frame: CGRect) {
        
        let blurEffect = UIBlurEffect(style: .Light)
        let frostView = UIVisualEffectView(effect: blurEffect)
        //self.init(frame: frame)
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        assignGestureRecognizerToView()
        
        frostView.frame = frame
        self.addSubview(frostView)
        
        
        if detail.articleIsHidden == "1" {
            let bannedLabel = UILabel(text: "你暂时没有权限阅读这篇文章", fontSize: 24)
            frostView.addSubview(bannedLabel)
            bannedLabel.snp_makeConstraints {
                make in
                make.centerX.equalTo(frostView)
                make.centerY.equalTo(frostView)
            }
        } else if detail.articleIsDeleted == "1"{
            let deletedLabel = UILabel(text: "这篇文章好像被删除啦！", fontSize: 24)
            frostView.addSubview(deletedLabel)
            deletedLabel.snp_makeConstraints {
                make in
                make.centerX.equalTo(frostView)
                make.centerY.equalTo(frostView)
            }
        } else {
            let nameLabel = UILabel(text: detail.articleName!, fontSize: 30)
            nameLabel.numberOfLines = 0
            
            let contentView = UIWebView(htmlString: detail.articleContent!)
            contentView.delegate = self
            
            let timeLabel = UILabel(text: detail.courseInsertTime!, fontSize:13)
            timeLabel.textColor = .grayColor()
            
            frostView.addSubview(nameLabel)
            nameLabel.snp_makeConstraints {
                make in
                make.left.equalTo(frostView).offset(24)
                make.top.equalTo(frostView).offset(30)
                make.right.equalTo(frostView).offset(-28)
            }
            
            frostView.addSubview(timeLabel)
            timeLabel.snp_makeConstraints {
                make in
                make.left.equalTo(nameLabel)
                make.top.equalTo(nameLabel.snp_bottom).offset(14)
            }
            
            frostView.addSubview(contentView)
            contentView.snp_makeConstraints {
                make in
                make.left.equalTo(frostView).offset(18)
                make.top.equalTo(timeLabel.snp_bottom).offset(8)
                make.right.equalTo(frostView).offset(-20)
                make.bottom.equalTo(frostView)
                
            }
        }
    }
}

//Gesture Recognizer
private extension CourseDetailReadingView {

    func assignGestureRecognizerToView() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissAnimated))
        swipeDown.direction = .Down
        addGestureRecognizer(swipeDown)
    }

}


private extension UIWebView {
    convenience init(htmlString: String) {
        self.init()
        backgroundColor = .clearColor()
        opaque = false
        userInteractionEnabled = true
        scrollView.scrollEnabled = true
        loadHTMLString(htmlString, baseURL: nil)
    }
}