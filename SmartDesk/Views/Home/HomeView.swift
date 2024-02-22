//
//  ContentView.swift
//  SmartDesk
//
//  Created by Ekramul Hoque on 20/2/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct HomeView: View {
    
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.openWindow) private var openWindow
    
    var body: some View {
        ZStack(alignment: .center) {
            // add background colour
            LinearGradient(
                colors:[.darkGreen.opacity(1),
                        .black.opacity(0.7)],
                startPoint: .top,
                endPoint: .bottomTrailing)
            
            VStack {
                //App title view
                TitleView(title: "Welcome to Smart Desk")
                
                // adding button
                HStack(spacing: 40) {
                    ForEach(HomeBtnItems.allCases, id: \.self) {item in
                        //call btn function with suitable case
                        btnView(btnItem: item)
                    }
                }
            }
        }
        .overlay (
            RoundedRectangle(cornerRadius: 25) //give a rounded border
                .stroke(.white.opacity(0.7),lineWidth: 4)
        ).mask(RoundedRectangle(cornerRadius: 25))
    
    }
    //Return button view
    func btnView(btnItem: HomeBtnItems)-> some View {
        Button {
            // select the windo
            openSelectedWindow(btnItam: btnItem)
        } label: {
            //Custom btn label view
            HomeBtnLabelView(btnItem: btnItem)
        }.buttonStyle(.plain)
            .hoverEffect(.lift)
        //  .hoverEffectDisabled() // disable defalut hover effect
    }
    
    //open selected window from here
    func openSelectedWindow(btnItam: HomeBtnItems) {
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
    HomeView()
}
