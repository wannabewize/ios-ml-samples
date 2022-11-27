//
//  ViewController.swift
//  ImageClassificationApp
//
//  Created by Jaehoon Lee on 2022/11/08.
//

import UIKit
import Vision

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var resultView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = Bundle.main.url(forResource: "image1", withExtension: "jpeg") else {
            fatalError("image url")
        }
        
        let request = VNClassifyImageRequest()
        print("Count :", (try! request.supportedIdentifiers().count))
        let handler = VNImageRequestHandler(url: url)
        try? handler.perform([request])
        
        if let observations : [VNClassificationObservation] = request.results {
            
            let filtered = observations
            .filter { observation in
                observation.confidence > 0.5
            }
            .sorted { lhs, rhs in
                lhs.confidence > rhs.confidence
            }
            .map { observation in
                "\(observation.identifier) - \(observation.confidence)"
            }
            resultView.text = filtered.description
            print("Observation :", filtered)
            
        }
        else {
            print("no result :", request.results)
        }
    }
}

