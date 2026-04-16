//
//  ContentView.swift
//  KotobaHunt
//
//  Created by Pepe on 15/4/26.
//

import Combine
import SwiftUI

struct MainView: View {
    @ObservedObject var router: Router

    var body: some View {
        Button("Start the hunt") {
            router.push(.camera)
        }
    }
}

#Preview {
    MainView(router: Router())
}
