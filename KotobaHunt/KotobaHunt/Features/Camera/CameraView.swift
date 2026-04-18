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
    @StateObject private var viewModel = CameraViewModel()

    var body: some View {
        ZStack {
            if viewModel.permissionGranted {
                CameraPreview(session: viewModel.session)
                    .ignoresSafeArea()
            } else {
                VStack(spacing: 16) {
                    Text("Camera access is required")
                    Button("Open Settings") {
                        openSettings()
                    }
                }
            }

            VStack {
                Spacer()
                ShutterButton {
                    // TODO: Capture image
                }
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            viewModel.checkPermissions()
        }
        .onDisappear {
            viewModel.stopCapture()
        }
    }

    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
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

struct CameraPreview: UIViewRepresentable {
    let session: AVCaptureSession

    func makeUIView(context: Context) -> UIView {
        let view = UIView()

        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = UIScreen.main.bounds

        view.layer.addSublayer(previewLayer)
        view.backgroundColor = .black

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

#Preview {
    CameraView()
}
