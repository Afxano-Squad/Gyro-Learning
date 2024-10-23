//
//  CameraPreview.swift
//  GyrosLearning
//
//  Created by Yuriko AIshinselo on 22/10/24.
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    var previewLayer: AVCaptureVideoPreviewLayer?

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)

        if let previewLayer = previewLayer {
            previewLayer.frame = view.bounds
            view.layer.addSublayer(previewLayer)
        }

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if let previewLayer = previewLayer {
            previewLayer.frame = uiView.bounds
        }
    }
}
