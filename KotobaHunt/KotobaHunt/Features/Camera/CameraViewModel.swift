//
//  CameraService.swift
//  KotobaHunt
//
//  Created by Pepe on 18/4/26.
//

import SwiftUI
import AVFoundation
import Combine

final class CameraViewModel: ObservableObject {
    @Published var permissionGranted = false

    let session = AVCaptureSession()
    private let output = AVCapturePhotoOutput()

    func checkPermissions() {
        checkCameraPermissions { granted in
            self.permissionGranted = granted

            if granted {
                self.setupCapture()
                self.startCapture()
            }
        }
    }

    func checkCameraPermissions(completion: @escaping (Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            requestCameraAccess { granted in
                completion(granted)
            }
        case .restricted, .denied:
            completion(false)
        case .authorized:
            completion(true)

        @unknown default:
            completion(false)
        }
    }

    private func requestCameraAccess(completion: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }

    func setupCapture() {
        session.beginConfiguration()

        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device),
              session.canAddInput(input),
              session.canAddOutput(output)
        else {
            return
        }

        session.addInput(input)
        session.addOutput(output)

        session.commitConfiguration()
    }

    func startCapture() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.session.startRunning()
        }
    }

    func stopCapture() {
        session.stopRunning()
    }
}
