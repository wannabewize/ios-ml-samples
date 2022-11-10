import SwiftUI
import Vision
import PhotosUI

@available(iOS 16.0, *)
struct ContentView: View {
    @State private var imageUrl: URL?
    @State private var pickedImage: PhotosPickerItem?
    @State private var pickedImageData: Data!
    
    var body: some View {
        VStack {
            PhotosPicker("사진을 고르세요.", selection: $pickedImage)
                .onChange(of: pickedImage) { newValue in
                    print("identifier :", newValue)
                    Task {
                        let data = try? await newValue?.loadTransferable(type: Data.self)
                        pickedImageData = data
                    }
                }
            if pickedImageData != nil,
                let image = UIImage(data: pickedImageData) {
                Image(uiImage: image)
            }
            else {
                Image("image1")
            }
        }
        .toolbar {
            
        }
    }
}
