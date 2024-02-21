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
            HStack(spacing: 40) {
                ForEach(ButtonItems.allCases, id: \.self) {item in
                    //call btn function with suitable case
                    btnView(btnItem: item)
                }
            }
            
        }.padding(20)
    }
    //Return button view
    func btnView(btnItem: ButtonItems)-> some View {
        Button {
            // select the windo
            openSelectedWindow(btnItam: btnItem)
        } label: {
            //Custom btn label view
            BtnLabelView(btnItem: btnItem)
        }.buttonStyle(.plain)
            .hoverEffect(.lift)
        //  .hoverEffectDisabled() // disable defalut hover effect
    }
    
    //open selected window from here
    func openSelectedWindow(btnItam: ButtonItems) {
        switch(btnItam) {
        case .note:  //open note window
            openWindow(id: Constants.NOTE_WINDOW_ID)
        case .promodome: //open promodome window
            openWindow(id: Constants.PROMO_DOME_WINDOW_ID)
        case .alarm: //open alarm window
            openWindow(id: Constants.ALARM_WINDOW_ID)
        }
    }
}

//Preview window
#Preview(windowStyle: .automatic) {
    HomeView()
}
