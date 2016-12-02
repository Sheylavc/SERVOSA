//
//  KeyboardHelper.swift
//  SERVOSA
//
//  Created by ucweb on 18/07/16.
//  Copyright © 2016 ucweb. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func registerForKeyboardDidShowNotification(scrollView: UIScrollView, usingBlock block: (NSNotification -> Void)? = nil) {
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardDidShowNotification, object: nil, queue: nil, usingBlock: { (notification) -> Void in
            let userInfo = notification.userInfo!
            let keyboardSize = userInfo[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue.size
            let contentInsets = UIEdgeInsetsMake(scrollView.contentInset.top, scrollView.contentInset.left, keyboardSize!.height, scrollView.contentInset.right)
            
            scrollView.scrollEnabled = true
            scrollView.setContentInsetAndScrollIndicatorInsets(contentInsets)
            block?(notification)
        })
    }
    
    func registerForKeyboardWillHideNotification(scrollView: UIScrollView, usingBlock block: (NSNotification -> Void)? = nil) {
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillHideNotification, object: nil, queue: nil, usingBlock: { (notification) -> Void in
            let contentInsets = UIEdgeInsetsMake(scrollView.contentInset.top, scrollView.contentInset.left, 0, scrollView.contentInset.right)
            scrollView.setContentInsetAndScrollIndicatorInsets(contentInsets)
            scrollView.scrollEnabled = false
            block?(notification)
        })
    }
}

extension UIScrollView {
    func setContentInsetAndScrollIndicatorInsets(edgeInsets: UIEdgeInsets) {
        self.contentInset = edgeInsets
        self.scrollIndicatorInsets = edgeInsets
    }
}