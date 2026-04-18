//
//  CameraService.swift
//  KotobaHunt
//
//  Created by Pepe on 18/4/26.
//

import SwiftUI
import AVFoundation
import Combine

final class CameraService: ObservableObject {
    let session = AVCaptureSession()
    private let output = AVCapturePhotoOutput()

    func setup() {
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

    func start() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.session.startRunning()
        }
    }

    func stop() {
        session.stopRunning()
    }
}
