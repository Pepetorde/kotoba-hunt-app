//
//  Router.swift
//  KotobaHunt
//
//  Created by Pepe on 16/4/26.
//

import SwiftUI
import Observation

@MainActor
@Observable
final class Router {
    var path: [Route] = []

    func push(_ route: Route) {
        path.append(route)
    }

    func pop() {
        _ = path.popLast()
    }

    func popToRoot() {
        path.removeAll()
    }

    func setPath(_ newPath: [Route]) {
        path = newPath
    }
}

enum Route: Hashable {
    case camera
}
