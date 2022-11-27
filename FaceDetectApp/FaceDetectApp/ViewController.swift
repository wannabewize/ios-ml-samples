//
//  ViewController.swift
//  FaceDetectApp
//
//  Created by Jaehoon Lee on 2022/11/28.
//

import UIKit
import Vision

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = Bundle.main.url(forResource: "image1", withExtension: "jpg")
        let data = try! Data(contentsOf: url!)
        let image = UIImage(data: data)
        
        // Face Rectangle
        let request = VNDetectFaceRectanglesRequest()
        let handler = VNImageRequestHandler(url: url!)
        try? handler.perform([request])
        
        if let observations: [VNFaceObservation] = request.results {
            print("observations:", observations)
            let filtered = observations
            .filter { observation in
                observation.confidence > 0.5
            }
            .forEach { observation in
                let faceView = UIView()
                
                let x = image!.size.width * CGFloat(observation.boundingBox.midX)
                let y = image!.size.width * CGFloat(observation.boundingBox.height)
                let width = image?.size.width * CGFloat(observation.boundingBox - observation.boundingBox.boxbox) observation.
                let height = image?.size.height & CGFloat(observation.boundingBox.minY - observation.boundingBox.miny3)
                let view = faceView.frame = CGRect(x: x, y: y, width: width, height: height)
                
            }
        }
    }


}

