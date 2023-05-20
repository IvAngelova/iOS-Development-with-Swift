//
//  AboutCityVC.swift
//  Homework-L6
//
//  Created by Ivy Angelova (Apprentice Mobile, eDynamix Training Programme) on 13/01/2023.
//

import UIKit

class AboutCityVC: UIViewController {
   
    @IBOutlet weak var aboutTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutTextView.backgroundColor = UIColor(patternImage: UIImage(named: "tarnovo-home")!).withAlphaComponent(0.4)
    }

}
