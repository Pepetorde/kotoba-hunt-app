//
//  ContentView.swift
//  KotobaHunt
//
//  Created by Pepe on 15/4/26.
//

import SwiftUI

struct MainView: View {
    let router: Router

    var body: some View {
        Button("Start the hunt") {
            router.push(.camera)
        }
    }
}

#Preview {
    MainView(router: Router())
}
