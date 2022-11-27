//
//  MLCore.swift
//  Playground-ML
//
//  Created by wannabewize on 2022/11/12.
//

import Foundation
import Vision

func classfyImage(url: URL) {
    do {
        let data = try Data(contentsOf: url)
        classifyImage(data: data)
    } catch {
        fatalError(error.localizedDescription)
    }
}

func classifyImage(data: Data) -> [VNClassificationObservation]? {
    let handler = VNImageRequestHandler(data: data)
    let request = VNClassifyImageRequest { request, error in
        guard error == nil else {
            fatalError(error!.localizedDescription)
        }
        print("completed :", request.results)
    }
    
    do {
        try handler.perform([request])
        if let observations = request.results {
//            print("observation :", observations)
            let observation: VNClassificationObservation = observations[0]
            let filtered = observations.filter { item in
                item.confidence > 0.1
            }.sorted { left, right in
                left.confidence > right.confidence
            }
            let limit = min(3, filtered.count)
            
            let final = filtered[0..<limit]
            
            final.forEach { item in
                print("\(item.identifier) - \(item.confidence.magnitude)")
            }
            
            return Array(final)
            
        }
        else {
            debugPrint("zero observation")
            return nil
        }
        
    } catch {
        fatalError(error.localizedDescription)
        return nil
    }
}

func detectObject(data: Data, completion: @escaping ( [(Double, CGRect)] ) -> Void) {
    let handler = VNImageRequestHandler(data: data)
    
    let request = VNDetectRectanglesRequest { request, error in
        guard error == nil else {
            print("error :", error)
            return
        }
        print("detect rectangle :", request.results)
        if let observations = request.results as? [VNRectangleObservation] {
//            observations.forEach { observation in
//                print("confidence: \(observation.confidence) x: \(observation.topLeft.x), y: \(observation.topLeft.y), width: \(observation.topRight.x - observation.topLeft.x), height: \(observation.topRight.y - observation.topRight.y) ")
//
//            }
            let results = observations.map { observation in
                return (Double(observation.confidence), CGRect(origin: observation.topLeft, size: CGSize(width: (observation.topRight.x - observation.topLeft.x), height: (observation.topRight.y - observation.topRight.y))) )
            }
            completion(results)
        }
    }
    request.maximumObservations = 8
    request.minimumConfidence = 0.6
    request.minimumAspectRatio = 0.3
    
    DispatchQueue.global().async {
        do {
            try handler.perform([request])
        } catch {
            print("Error :", error)
        }
    }
}

	
