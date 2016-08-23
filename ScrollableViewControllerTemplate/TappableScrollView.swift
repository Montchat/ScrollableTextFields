//
//  TappableScrollView.swift
//  ScrollableViewControllerTemplate
//
//  Created by Joe Edwards on 8/23/16.
//  Copyright © 2016 HanekeDesign. All rights reserved.
//


import UIKit

class TappableScrollView: UIScrollView {
    
    //this allows for actions such as endEditting to occur on some ViewControllers ( ie those with scrollViews, textFields, and tableViews)
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (!dragging){
            nextResponder()?.touchesBegan(touches, withEvent: event)
        }
    }
    
}

class TouchableTableView : UITableView {
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (!dragging){
            nextResponder()?.touchesBegan(touches, withEvent: event)
        }
    }
    
}
