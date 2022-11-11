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
        print("completion handler?")
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

	
