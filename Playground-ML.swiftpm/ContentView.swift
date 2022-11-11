import SwiftUI
import Vision
import PhotosUI

@available(iOS 16.0, *)
struct ContentView: View {
    @State private var imageUrl: URL?
    @State private var pickedImage: PhotosPickerItem?
    @State private var pickedImageData: Data!
    @State var observed: [VNClassificationObservation] = []
    
    var body: some View {
        VStack {
            HStack {
                PhotosPicker("사진을 고르세요.", selection: $pickedImage)
                    .onChange(of: pickedImage) { newValue in
                        print("identifier :", newValue)
                        Task {
                            let data = try? await newValue?.loadTransferable(type: Data.self)
                            pickedImageData = data
                            let ret = classifyImage(data: pickedImageData)
                            self.observed = ret ?? []
                        }
                    }
            }
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
            }

            Spacer()
        }
    }
}
