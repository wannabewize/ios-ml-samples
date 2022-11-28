//
//  ViewController.swift
//  FaceDetectApp
//
//  Created by Jaehoon Lee on 2022/11/28.
//

import UIKit
import Vision

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let url = Bundle.main.url(forResource: "image1", withExtension: "jpg")
        let data = try! Data(contentsOf: url!)
        let image = UIImage(data: data)
        
        // Face Rectangle
        let request = VNDetectFaceRectanglesRequest()
        let landmarkRequest = VNDetectFaceLandmarksRequest()
        
        let handler = VNImageRequestHandler(url: url!)
        try? handler.perform([request, landmarkRequest])
        
        imageView.sizeToFit()
        
        if let observations: [VNFaceObservation] = request.results {
            print("observations:", observations)
            print("image size:", image?.size)
            let filtered = observations
            .filter { observation in
                observation.confidence > 0.5
            }
            .forEach { observation in
                let faceView = UIView()
                
                debugPrint("landmark :", observation.landmarks)
                
                let x = image!.size.width * CGFloat(observation.boundingBox.minX)
                // The system normalizes the coordinates to the dimensions of the processed image, with the origin at the lower-left corner of the image.
                let y = image!.size.height * CGFloat(1 - observation.boundingBox.maxY)
                let width = image!.size.width * CGFloat(observation.boundingBox.maxX - observation.boundingBox.minX)
                let height = image!.size.height * CGFloat(observation.boundingBox.maxY - observation.boundingBox.minY)
                faceView.frame = CGRect(x: x, y: y, width: width, height: height)
                faceView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
                imageView?.addSubview(faceView)
            }
        }
    }


}

