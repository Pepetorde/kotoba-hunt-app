//
//  CameraView.swift
//  KotobaHunt
//
//  Created by Pepe on 16/4/26.
//

import SwiftUI
import AVFoundation
import Combine

struct CameraView: View {
    @StateObject private var cameraService = CameraService()

    var body: some View {
        ZStack {
            CameraPreview(session: cameraService.session)
                .ignoresSafeArea()

            VStack {
                Spacer()
                ShutterButton {
                    // TODO: Capture image
                }
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            cameraService.setup()
            cameraService.start()
        }
        .onDisappear {
            cameraService.stop()
        }
    }
}

struct ShutterButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Circle()
                .fill(Color.white)
                .frame(width: 70, height: 70)
                .overlay(
                    Circle()
                        .stroke(Color.black, lineWidth: 2)
                )
        }
    }
}

// TODO: gestionar permisos

struct CameraPreview: UIViewRepresentable {
    let session: AVCaptureSession

    func makeUIView(context: Context) -> UIView {
        let view = UIView()

        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = UIScreen.main.bounds

        view.layer.addSublayer(previewLayer)

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

#Preview {
    CameraView()
}
