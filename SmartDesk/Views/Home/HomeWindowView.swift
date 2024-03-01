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
                
                // adding button
                HStack(spacing: 40) {
                    ForEach(WindowButtonItems.allCases, id: \.self) {item in
                        //call btn function with suitable case
                        createWindowButtons(btnItem: item)
                    }
                }
            }
        }.roundedBorder()
            .onAppear {
                Task {
                  await openImmersiveSpace(id: "ImmersiveSpace")
                }
            }
    }
    //Return button view
    func createWindowButtons(btnItem: WindowButtonItems)-> some View {
        Button {
            // select the windo
            openSelectedWindow(btnItam: btnItem)
        } label: {
            //Custom btn label view
            WindowOpenerButtonView(btnItem: btnItem)
        }.buttonStyle(.plain)
            .hoverEffect()
    }
    
    //open selected window from here
    func openSelectedWindow(btnItam: WindowButtonItems) {
        switch(btnItam) {
        case .note:  //open note window
           openWindow(id: Constants.NOTE_WINDOW_ID)
           
        case .promodoro: //open promodome window
            openWindow(id: Constants.PROMO_DORO_WINDOW_ID)
        case .alarm: //open alarm window
            openWindow(id: Constants.ALARM_WINDOW_ID)
        }
    }
}

//Preview window
#Preview(windowStyle: .automatic) {
    HomeWindowView()
}
