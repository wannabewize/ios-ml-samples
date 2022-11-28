//
//  ViewController.swift
//  WhatNumberApp
//
//  Created by wannabewize on 2022/11/28.
//

import UIKit
import CoreML

class ViewController: UIViewController {
    
    var model: MNISTClassifier!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let config = MLModelConfiguration()
            model = try MNISTClassifier(configuration: config)
            
            // 애셋을 이용한 모델 테스트
//            let image = UIImage(named: "one")!
//            let cgImage = image.cgImage!
//            let input = try MNISTClassifierInput(imageWith: cgImage)
//            let prediction = try model.prediction(input: input)
//
//            let result = prediction.labelProbabilities
//            print("result :", result)
        }
        catch let error {
            print("Error", error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            let image = UIImage(named: "number1")
            let cgImage = image!.cgImage
            let input = try MNISTClassifierInput(imageWith: cgImage!)
            let prediction = try self.model.prediction(input: input)

            let results = prediction.labelProbabilities
//            // 식별 결과 출력하기
//            print("results :", results)
            // 식별값으로 정렬하기
            let sorted = results.sorted { (left, right) in
                return left.value > right.value
            }
            // 가장 높은값 출력
            let (key, value) = sorted[0]
            debugPrint("key : \(key) - predict : \(value)")
            
        } catch {
            debugPrint("Error :", error)
        }
        
        
    }


}

