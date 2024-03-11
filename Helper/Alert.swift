//
//  Alert.swift
//  EuropeanHoliday
//
//  
//

import Foundation
import UIKit
import DeviceKit

class Alert{
    
    public enum AlertAction {
        case primary
        case cancel
        case destructive
    }
    
    static var isShowing : Bool = false
    
    /* Alert with no executable actions */
    class func showAlert(_ viewController : UIViewController, message:String){
        
        guard viewController.viewIfLoaded?.window != nil else { return } // If viewController is not visible, don't show
        
        let alertController = UIAlertController(title: StringFactory.Titles.europeanHoliday, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: StringFactory.Actions.ok, style: .default)
        { (action) in
            //Ignored..just a popup
            self.isShowing = false
        }
        
        alertController.addAction(okAction)
        
        viewController.present(alertController, animated: true)
        self.isShowing = true
    }
    
    /* Alert with cancel action */
    class func showAlert(_ viewController : UIViewController, message:String, defaultButtonTitle: String,
                         cancelable: Bool, cancelButtonTitle: String = StringFactory.Actions.cancel, completionHandler: @escaping (AlertAction) -> () ){
        
        guard viewController.viewIfLoaded?.window != nil else { return } // If viewController is not visible, don't show
        
        let alertController = UIAlertController(title: StringFactory.Titles.europeanHoliday, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: defaultButtonTitle, style: .default)
        { (action) in
            //perform action when user clicks ok
            self.isShowing = false
            completionHandler(.primary)
        }
        alertController.addAction(defaultAction)
        if cancelable {
            let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel)
            { (action) in
                //perform action when user clicks cancel
                self.isShowing = false
                completionHandler(.cancel)
            }
            alertController.addAction(cancelAction)
        }
        viewController.present(alertController, animated: true)
        self.isShowing = true
    }
    
    /* Alert with destructive action */
    class func showAlert(_ viewController : UIViewController, message:String, defaultButtonTitle: String, destructiveButtonTitle: String, completionHandler: @escaping (AlertAction) -> () ){
        
        guard viewController.viewIfLoaded?.window != nil else { return } // If viewController is not visible, don't show
        
        let alertController = UIAlertController(title: StringFactory.Titles.europeanHoliday, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: defaultButtonTitle, style: .default)
        { (action) in
            //perform action when user clicks ok
            self.isShowing = false
            completionHandler(.primary)
        }
        alertController.addAction(defaultAction)
        
        let destructiveAction = UIAlertAction(title: destructiveButtonTitle, style: .destructive)
        { (action) in
            //perform action when user clicks ok
            self.isShowing = false
            completionHandler(.destructive)
        }
        alertController.addAction(destructiveAction)
        
        viewController.present(alertController, animated: true)
        self.isShowing = true
    }
    
}
