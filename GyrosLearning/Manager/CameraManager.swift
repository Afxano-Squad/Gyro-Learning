//
//  CameraManager.swift
//  GyrosLearning
//
//  Created by Yuriko AIshinselo on 22/10/24.
//

import Foundation
import AVFoundation
import UIKit

class CameraManager: NSObject, ObservableObject {
    private var session: AVCaptureSession?
    private var output: AVCapturePhotoOutput?
    private var previewLayer: AVCaptureVideoPreviewLayer?

    @Published var capturedImage: UIImage?

    // Start camera session and set up the preview layer
    func startSession() -> AVCaptureVideoPreviewLayer? {
        session = AVCaptureSession()
        session?.sessionPreset = .photo
        output = AVCapturePhotoOutput()
        
        guard let session = session, let output = output else { return nil }

        // Set up input
        guard let device = AVCaptureDevice.default(for: .video) else { return nil }
        do {
            let input = try AVCaptureDeviceInput(device: device)
            session.addInput(input)
            session.addOutput(output)

            // Set up preview layer
            previewLayer = AVCaptureVideoPreviewLayer(session: session)
            previewLayer?.videoGravity = .resizeAspectFill

            // Start the session
            session.startRunning()

            return previewLayer
        } catch {
            print("Error setting up camera: \(error)")
            return nil
        }
    }

    func stopSession() {
        session?.stopRunning()
        session = nil
        output = nil
    }

    func takePicture() {
        guard let output = output else { return }
        let settings = AVCapturePhotoSettings()
        output.capturePhoto(with: settings, delegate: self)
    }
}

extension CameraManager: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("Error capturing photo: \(error)")
            return
        }
        guard let data = photo.fileDataRepresentation(),
              let image = UIImage(data: data) else { return }

        DispatchQueue.main.async {
            self.capturedImage = image
        }
    }
}
