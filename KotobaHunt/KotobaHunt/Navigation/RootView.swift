//
//  RootView.swift
//  KotobaHunt
//
//  Created by Pepe on 16/4/26.
//

import SwiftUI

struct RootView: View {
    @State private var router = Router()

    var body: some View {
        @Bindable var router = router

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
