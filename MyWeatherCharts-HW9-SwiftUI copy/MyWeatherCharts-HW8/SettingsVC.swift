//
//  ViewController.swift
//  MyWeatherCharts-HW8
//
//  Created by Ivy Angelova (Apprentice Mobile, eDynamix Training Programme) on 20/01/2023.
//

import UIKit
import RealmSwift

class SettingsVC: UIViewController {
    
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    
    @IBOutlet weak var selectTempUnitBtn: UIButton!
    @IBOutlet weak var selectTempUnitLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.longitudeTextField.delegate = self
        self.latitudeTextField.delegate = self
    
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func doneBtnTapped(_ sender: UIButton) {
        guard let latitude = self.latitudeTextField.text,
              let longitude = self.longitudeTextField.text,
              let tempUnit = self.selectTempUnitLabel.text else {
            return
        }
        LocalData.latitude = latitude
        LocalData.longitude = longitude
        LocalData.temperatureUnit = tempUnit
        
       
        RequestManager.fetchDataAlamofire()
//        { result in
//            guard let weatherDataAPI = result else {
//                return
//            }
//
//            weatherDataAPI.hourly?.id = ObjectId.generate()
//            weatherDataAPI.id = ObjectId.generate()
//            weatherDataAPI.current_weather?.id = ObjectId.generate()
//            weatherDataAPI.hourly_units?.id = ObjectId.generate()
//
//            DispatchQueue.main.async {
//                try? LocalDataManager.realm.write {
//                    LocalDataManager.realm.delete(LocalDataManager.allWeatherData())
//                }
//            }
//
//            DispatchQueue.main.async {
//                try? LocalDataManager.realm.write {
//                    LocalDataManager.realm.add(weatherDataAPI)
//                }
//            }
//        }
    }
    
    
    @IBAction func selectTempUnitBtnTapped(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let popoverVC = storyBoard.instantiateViewController(withIdentifier: "PopoverTableVC") as? PopoverTableVC else {
            return
        }
        popoverVC.modalPresentationStyle = UIModalPresentationStyle.popover
        // Present popover
        if let popoverPresentationController = popoverVC.popoverPresentationController {
            popoverPresentationController.permittedArrowDirections = .up
            popoverPresentationController.sourceView = sender as UIButton
            popoverPresentationController.sourceRect = sender.bounds
            popoverPresentationController.delegate = self
        }
        popoverVC.preferredContentSize = CGSize.init(width: sender.frame.width, height: 60)
        self.present(popoverVC, animated: true, completion: nil)
        
        popoverVC.items = ["Fahrenheit °F", "Celsius °C"]
        popoverVC.delegate = self
    }

}

extension SettingsVC: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}

extension SettingsVC: PopoverTableViewDelegate {
    func didSelectItem(item: String) {
        self.selectTempUnitLabel.textColor = .systemBlue
        self.selectTempUnitLabel.text = item
    }
}

extension SettingsVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.latitudeTextField:
            self.longitudeTextField.becomeFirstResponder()
        case self.longitudeTextField:
            self.longitudeTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
}

