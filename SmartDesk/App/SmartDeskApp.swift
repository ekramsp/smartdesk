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
           HomeWindowView()
                .frame(maxWidth: 800,maxHeight: 100)
        }
        .windowStyle(.plain)
        
        WindowGroup(id: Constants.NOTE_WINDOW_ID , for: String.self) { $sceneName in
            if let sceneName {
                NoteWindowView(sceneName: sceneName)
            }
        }
        .windowStyle(.plain)
        
        WindowGroup(id: Constants.CLOCK_WINDOW_ID, for: String.self) { $sceneName in
            if let sceneName {
                ClockWindowView(sceneName: sceneName)
            }
        }
        .windowStyle(.plain)
        
        ImmersiveSpace(id: "ImmersiveSpace") {
          ImmersiveView()
        }
    }
}
//Global logger
let logger = Logger()
