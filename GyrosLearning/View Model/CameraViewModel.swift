import SwiftUI
import AVFoundation

class CameraViewModel: ObservableObject {
    @Published var capturedImage: UIImage?
    private var cameraManager: CameraManager
    private(set) var previewLayer: AVCaptureVideoPreviewLayer?

    init(cameraManager: CameraManager) {
        self.cameraManager = cameraManager
        setupBindings()
    }

    func setupBindings() {
        cameraManager.$capturedImage
            .assign(to: &$capturedImage)
    }

    func startCamera() {
        previewLayer = cameraManager.startSession()
    }

    func stopCamera() {
        cameraManager.stopSession()
    }

    func capturePhoto() {
        cameraManager.takePicture()
    }
}
