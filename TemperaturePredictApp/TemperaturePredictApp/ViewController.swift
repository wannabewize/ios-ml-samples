//
//  ViewController.swift
//  TemperaturePredictApp
//
//  Created by wannabewize on 2022/11/28.
//

import UIKit
import CoreML

class ViewController: UIViewController {
    
    var model: MLModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let config = MLModelConfiguration()
            
            let model3 = try TemeraturePredict(configuration: config)
            
            let output = try model3.prediction(Year: 2200, Country: "South Korea")
            
            print(output.AverageTemperature)

        } catch {
            debugPrint(error)
        }
    }
}

