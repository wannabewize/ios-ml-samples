//
//  ViewController.swift
//  ImageClassificationApp
//
//  Created by Jaehoon Lee on 2022/11/08.
//

import UIKit
import Vision

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = Bundle.main.url(forResource: "image2", withExtension: "png") else {
            fatalError("image url")
        }
        
        let handler = VNImageRequestHandler(url: url, options: [:])
        let request = VNClassifyImageRequest()
        try? handler.perform([request])
        
        if let observations = request.results {
          print("Observation :", observations)
        }
        else {
            fatalError("No results")
        }
        

        
    }


}

