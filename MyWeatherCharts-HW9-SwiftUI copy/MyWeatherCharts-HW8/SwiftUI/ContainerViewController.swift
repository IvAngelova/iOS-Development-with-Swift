//
//  ContainerViewController.swift
//  MyWeatherCharts-HW8
//
//  Created by Ivy Angelova (Apprentice Mobile, eDynamix Training Programme) on 30/01/2023.
//

import UIKit
import SwiftUI


class ContainerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let weatherDataView = WeatherDataUIView()
        let hostingController = UIHostingController(rootView: weatherDataView)
        addChild(hostingController)
        hostingController.view.frame = view.frame
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
}
