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
               .frame(
                    minWidth: 1000,
                    maxWidth: 1200,
                    minHeight: 500,
                    maxHeight: 1200
                 )
        }
        .windowStyle(.plain)
        .windowResizability(.contentSize)
        
        WindowGroup(id: Constants.NOTE_WINDOW_ID) {
          NoteWindowView()
        }
        .windowStyle(.volumetric)
        
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
//Global logger
let logger = Logger()
