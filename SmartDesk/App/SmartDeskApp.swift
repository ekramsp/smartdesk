//
//  SmartDeskApp.swift
//  SmartDesk
//
//  Created by Ekramul Hoque on 20/2/24.
//

import SwiftUI
import os
import SwiftData

@main
struct SmartDeskApp: App {
    //Provides the persistant backend for model types From this IIFE(IMideately invoked function expression)
    //set the model container for managing schema and necessary configuration
    let container: ModelContainer = {
        let schema = Schema([Note.self, Alarm.self]) //Initialize schema with model
        do {
            //Here configuration can be added to help swift data to decide
            //where the database is stored it can be cloud kit or others
            //Like enable autosave or disable auto save
            let container = try ModelContainer(for: schema, configurations: []) // initialize container
            return container
        } catch {
            fatalError("!100 Datasource: Failed to initialize ModelContainer: \(error)")
        }
    }()
    
    @State private var imersiveViewModel = ImersiveViewModel()
    
    var body: some Scene {
        WindowGroup() {
           HomeWindowView()
                .frame(maxWidth: 800,maxHeight: 100)
        }
        .windowStyle(.plain)
        
        WindowGroup(id: Constants.NOTE_WINDOW_ID , for: String.self) { $sceneName in
            if let sceneName {
                NoteWindowView(sceneName: sceneName, modelcontext: container.mainContext)
            }
        }
        .windowStyle(.plain)
        .modelContainer(container)  // this will add the container to views environment
        
        WindowGroup(id: Constants.CLOCK_WINDOW_ID, for: String.self) { $sceneName in
            if let sceneName {
                ClockWindowView(sceneName: sceneName)
            }
        }
        .windowStyle(.plain)
        .environment(imersiveViewModel)
        .modelContainer(container)
        
        ImmersiveSpace(id: "ImmersiveSpace") {
          ImmersiveView()
        }.environment(imersiveViewModel)
    }
}
//Global logger
let logger = Logger()
