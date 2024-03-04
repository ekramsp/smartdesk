//
//  ContentView.swift
//  SmartDesk
//
//  Created by Ekramul Hoque on 20/2/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct HomeWindowView: View {
    
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.openWindow) private var openWindow
    
    var body: some View {
        ZStack(alignment: .center) {
            // add background colour
            SmartDeskBackgroundView()
            VStack {
                //App title view
                HomeWindowTitleView(title: "Welcome to Smart Desk")
            }.padding(20)
        }
        .roundedBorder()
            .onAppear {
                Task {
                  await openImmersiveSpace(id: "ImmersiveSpace")
                }
            }
    }
}

//Preview window
#Preview(windowStyle: .automatic) {
    HomeWindowView()
}
