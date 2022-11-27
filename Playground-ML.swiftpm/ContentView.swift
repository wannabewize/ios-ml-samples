import SwiftUI


struct ContentView: View {
    
    var body: some View {
        VStack {
            List {
                if #available(iOS 16.0, *) {
                    NavigationLink("Image Classification") {
                        ImageClassificationView()
                    }
                    NavigationLink("Object Detection") {
                        ObjectDetectionView()
                    }
                }
            }
        }
    }
}
