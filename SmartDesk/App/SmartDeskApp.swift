//
//  SmartDeskApp.swift
//  SmartDesk
//
//  Created by Ekramul Hoque on 20/2/24.
//

import SwiftUI
import os

@main
struct SmartDeskApp: App {

    var body: some Scene {
        WindowGroup() {
           HomeView()
        }
        .windowResizability(.contentSize) // set the size of a window based on content size
        
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
//Global logger
let logger = Logger()
