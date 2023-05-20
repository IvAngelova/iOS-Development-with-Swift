//
//  Extensions.swift
//  MyWeatherCharts-HW8
//
//  Created by Ivy Angelova (Apprentice Mobile, eDynamix Training Programme) on 26/01/2023.
//

import Foundation
import UIKit


fileprivate var activityView: UIView?

extension UIViewController{
    func showSpinner() {
        activityView = UIView(frame: self.view.bounds)
        activityView?.backgroundColor = .lightGray
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = activityView!.center
        activityIndicator.startAnimating()
        activityView?.addSubview(activityIndicator)
        self.view.addSubview(activityView!)
        
        Timer.scheduledTimer(withTimeInterval: 20.0, repeats: false) { (t) in
            self.removeSpinner()
        }
    }
    
    func removeSpinner(){
        activityView?.removeFromSuperview()
        activityView = nil
    }
}
