//
//  ScrollableViewController.swift
//  ScrollableViewControllerTemplate
//
//  Created by Joe Edwards on 8/23/16.
//  Copyright © 2016 HanekeDesign. All rights reserved.
//

import UIKit

class ScrollableViewController: UIViewController {
    
    var scrollView:TappableScrollView?
    var activeTextField:UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyBoardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(true)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:UIKeyboardWillHideNotification, object: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let activeTextField = activeTextField else { return }
        
        if activeTextField.isFirstResponder() {
            view.endEditing(true)
            
        }
        
    }
    
}


extension ScrollableViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        activeTextField = textField
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        activeTextField = nil
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
        
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        guard let scrollView = scrollView else { print("user forgot to set the scrollview") ; return }

        
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        let contentInsets = UIEdgeInsetsMake(0, 0, keyboardFrame.height, 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        var rect = view.frame
        rect.size.height -= keyboardFrame.height
        guard let activeTextField = activeTextField else { return }
        if CGRectContainsPoint(rect, activeTextField.frame.origin) {
            scrollView.scrollRectToVisible(activeTextField.frame, animated: true)
        }
        
    }
    
    func keyBoardWillHide(notification: NSNotification) {
        
        guard let scrollView = scrollView else { print("user forgot to set scrollView") ; return }
        
        scrollView.contentInset = UIEdgeInsetsZero
        scrollView.scrollIndicatorInsets = UIEdgeInsetsZero
    }
    
}