//
//  RootView.swift
//  KotobaHunt
//
//  Created by Pepe on 16/4/26.
//

import SwiftUI

struct RootView: View {
    @StateObject var router = Router()

    var body: some View {
        NavigationStack(path: $router.path) {
            MainView(router: router)
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .camera:
                        CameraView()
                    }
                }
        }
    }
}

#Preview {
    RootView()
}
