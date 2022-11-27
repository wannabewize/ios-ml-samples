//
//  ObjectDetectionView.swift
//  Playground-ML
//
//  Created by Jaehoon Lee on 2022/11/13.
//

import SwiftUI
import PhotosUI
import Vision

@available(iOS 16.0, *)
struct ObjectDetectionView: View {
    @State private var imageUrl: URL?
    @State private var pickedImage: PhotosPickerItem?
    @State private var pickedImageData: Data!
    @State var observed: [VNClassificationObservation] = []
    @State var overlayRects: [CGRect] = []
    
    var body: some View {
        VStack {
            HStack {
                PhotosPicker("사진을 고르세요.", selection: $pickedImage)
                    .onChange(of: pickedImage) { newValue in
                        print("identifier :", newValue)
                        
                        Task {
                            if let data = try? await newValue?.loadTransferable(type: Data.self), let image = UIImage(data: data) {
                                pickedImageData = data
                                let imageSize = image.size
                                detectObject(data: data) { results in
                                    
                                    let rects = results.map { item in
                                        let rect = item.1
                                        
                                        let origin = CGPoint(x: rect.origin.x * imageSize.width, y: rect.origin.y * imageSize.height)
                                        let size = CGSize(width: rect.size.width * imageSize.width, height: rect.size.height * imageSize.height)
                                        return CGRect(origin: origin, size: size)
                                    }
                                    print("found :", results.count, "rects:", rects)
                                    overlayRects = rects
                                }
                                
                            }
                        }
                    }
            }
            .padding(20)
            .frame(height: 44)
            
            Spacer()
            ZStack {
                Group {
                    if pickedImageData != nil,
                        let image = UIImage(data: pickedImageData) {
                        Image(uiImage: image)
                            .resizable()
                    }
                    else {
                        Image("image1")
                    }
                }
                Group {
                    VStack {
                        ForEach(observed, id: \.self ) { item in
                            Text("\(item.identifier) - \(item.confidence)")
                        }
                        
                    }
                    .background(.white)
                    .foregroundColor(.black)
                    Spacer()
                }
                Group {
                    ForEach(0..<overlayRects.count) { index in
                        let rect = overlayRects[index]
                        Rectangle()
                            .position(x: rect.origin.x, y: rect.origin.y)
                            .frame(width: rect.width, height: rect.height)
                            .background(.blue)
                    }
                }
            }

            Spacer()
        }
    }
}

struct ObjectDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 16.0, *) {
            ObjectDetectionView()
        } else {
            // Fallback on earlier versions
            Text("Not available")
        }
    }
}
