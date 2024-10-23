import SwiftUI

struct CameraView: View {
    @ObservedObject var viewModel: CameraViewModel  // Use ObservedObject when passing from parent

    var body: some View {
        VStack {
            if let previewLayer = viewModel.previewLayer {
                CameraPreview(previewLayer: previewLayer)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black)
            }

            Spacer()

            if let image = viewModel.capturedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                Text("No image captured yet")
                    .font(.headline)
                    .foregroundColor(.white)
            }

            Spacer()

            Button(action: {
                viewModel.capturePhoto()
            }) {
                Text("Take Picture")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .onAppear {
            viewModel.startCamera()
        }
        .onDisappear {
            viewModel.stopCamera()
        }
    }
}

#Preview {
    CameraView(viewModel: CameraViewModel(cameraManager: CameraManager()))  // Pass ViewModel instance correctly
}
