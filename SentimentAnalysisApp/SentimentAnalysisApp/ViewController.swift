//
//  ViewController.swift
//  SentimentAnalysisApp
//
//  Created by Jaehoon Lee on 2022/11/28.
//

import UIKit
import NaturalLanguage

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let text = "It's pretty cool."
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        tagger.string = text
        
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .paragraph, scheme: .sentimentScore) { sentiment, range in
            
            debugPrint("sentiment :", sentiment)
            return true
        }
    }
}

