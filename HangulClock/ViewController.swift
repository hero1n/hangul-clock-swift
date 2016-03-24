//
//  ViewController.swift
//  HangulClock
//
//  Created by 노재원 on 2016. 1. 4..
//  Copyright © 2016년 heroin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let array = ["오", "전", "후", "열", "한", "두", "세", "일", "곱", "다", "여", "섯", "네", "여", "덟", "아", "홉", "시", "자", "이", "삼", "사", "오", "십", "정", "오", "일", "이", "삼", "사", "육", "칠", "팔", "구", "분", "초"]
    
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UIApplication.sharedApplication().idleTimerDisabled = true
        
        
        self.initLabel()
    }
    
    func initLabel() {
        var tagIndex: Int
        var label: UILabel = UILabel()
        
        for (var i = 0; i < 36; i++) {
            let ten = i/6*10
            let one = i%6+1
            tagIndex = ten+one
            
            label = self.view.viewWithTag(tagIndex) as! UILabel
            label.text = self.array[i]
            label.alpha = 0.5
        }
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "show", userInfo: nil, repeats: true)
    }
    
    func show() {
        let date = NSDate()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "H"
        var hour = Int(dateFormatter.stringFromDate(date))!
        dateFormatter.dateFormat = "mm"
        var min = Int(dateFormatter.stringFromDate(date))!
        let ten = min / 10
        dateFormatter.dateFormat = "s"
        let sec = Int(dateFormatter.stringFromDate(date))!
        
        var isMidNoon: Bool = false
        
        self.clear()
        
        // 오후
        if (hour >= 12 && !(hour == 12 && min == 0)) {
            self.showLetter(1)
            self.showLetter(3)
        }
            // 오전
        else if (hour < 12 && !((hour == 0 || hour == 24) && min == 0)) {
            self.showLetter(1)
            self.showLetter(2)
        }
        // 정오
        if (hour == 12 && min == 0) {
            self.showLetter(41)
            self.showLetter(42)
            hour = -1;
            isMidNoon = true;
        }
            // 자정
        else if ((hour == 0 || hour == 24) && min == 0) {
            self.showLetter(31)
            self.showLetter(41)
            hour = -1;
            isMidNoon = true;
        }
        
        if (hour >= 13){
            hour = hour - 12;
        }
        
        switch (hour) {
        case 1:
            self.showLetter(5)
        case 2:
            self.showLetter(6)
        case 3:
            self.showLetter(11)
        case 4:
            self.showLetter(21)
        case 5:
            self.showLetter(14)
            self.showLetter(16)
        case 6:
            self.showLetter(15)
            self.showLetter(16)
        case 7:
            self.showLetter(12)
            self.showLetter(13)
        case 8:
            self.showLetter(22)
            self.showLetter(23)
        case 9:
            self.showLetter(24)
            self.showLetter(25)
        case 10:
            self.showLetter(4)
        case 11:
            self.showLetter(4)
            self.showLetter(5)
        case 12:
            self.showLetter(4)
            self.showLetter(6)
        case 0:
            self.showLetter(4)
            self.showLetter(6)
        default:
            break;
        }
        
        // '시'
        if isMidNoon == false {
            self.showLetter(26)
        }
        
        switch (ten) {
        case 1:
            self.showLetter(36)
        case 2:
            self.showLetter(32)
            self.showLetter(36)
        case 3:
            self.showLetter(33)
            self.showLetter(36)
        case 4:
            self.showLetter(34)
            self.showLetter(36)
        case 5:
            self.showLetter(35)
            self.showLetter(36)
        default:
            break;
        }
        
        // '분'
        if (!isMidNoon && min != 0){
            self.showLetter(55)
        }
        
        min = min % 10;
        switch (min) {
        case 1:
            self.showLetter(43)
        case 2:
            self.showLetter(44)
        case 3:
            self.showLetter(45)
        case 4:
            self.showLetter(46)
        case 5:
            self.showLetter(42)
        case 6:
            self.showLetter(51)
        case 7:
            self.showLetter(52)
        case 8:
            self.showLetter(53)
        case 9:
            self.showLetter(54)
        default:
            break;
        }
        
        self.secondChange(sec)
    }
    
    func showLetter(tag: Int) {
        var label: UILabel = UILabel()
        label = self.view.viewWithTag(tag) as! UILabel
        
        UIView.animateWithDuration(0.3,
            delay: 0.3,
            options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                label.transform = CGAffineTransformMakeScale(1.1, 1.1)
            }, completion: nil)
        
        label.textColor = UIColor.whiteColor()
        label.alpha = 1.0
    }
    
    func hideLetter(tag: Int) {
        var label: UILabel = UILabel()
        label = self.view.viewWithTag(tag) as! UILabel
        
        label.textColor = UIColor.lightGrayColor()
        label.alpha = 0.5
    }
    
    func secondChange(second: Int) {
        var label: UILabel = UILabel()
        label = self.view.viewWithTag(56) as! UILabel
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.systemFontOfSize(20)
        label.alpha = 1.0
        label.numberOfLines = 0
        
//        let animaton = CATransition()
//        animaton.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
//        animaton.type = kCATransitionFade
//        animaton.duration = 0.3
//        label.layer.addAnimation(animaton, forKey: "kCATransitionFade")
        
        var secondString: String = ""
        
        let ten = second / 10
        let one = second % 10
        
        switch (ten) {
        case 1: secondString += "십"
        case 2: secondString += "이십"
        case 3: secondString += "삼십"
        case 4: secondString += "사십"
        case 5: secondString += "오십"
        default: break
        }
        
        switch (one) {
        case 1: secondString += "일"
        case 2: secondString += "이"
        case 3: secondString += "삼"
        case 4: secondString += "사"
        case 5: secondString += "오"
        case 6: secondString += "육"
        case 7: secondString += "칠"
        case 8: secondString += "팔"
        case 9: secondString += "구"
        default: break
        }
        
        UIView.transitionWithView(label,
            duration: 0.2,
            options: UIViewAnimationOptions.TransitionCrossDissolve,
            animations: {
                if (secondString == "") {
                    label.text = "초"
                    label.font = UIFont.systemFontOfSize(30)
                    label.textColor = UIColor.lightGrayColor()
                    label.alpha = 0.5
                } else {
                    label.text = secondString + "초"
                }
            },
            completion: nil)
        
    }
    
    func clear() {
        var tagIndex: Int = 0
        
        for (var i = 0; i < 6; i++) {
            for (var j = 0; j < 6; j++) {
                tagIndex = i*10+(j+1)
                if (tagIndex != 56) {
                    var label: UILabel = UILabel()
                    label = self.view.viewWithTag(tagIndex) as! UILabel
                    
                    UIView.animateWithDuration(0.3,
                        delay: 0.3,
                        options: UIViewAnimationOptions.CurveEaseInOut,
                        animations: {
                            label.transform = CGAffineTransformMakeScale(10/11, 10/11)
                        },
                        completion: nil)
                    
                    label.textColor = UIColor.lightGrayColor()
                    label.alpha = 0.5
                }
            }
        }
    }
}

