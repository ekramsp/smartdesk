//
//  NoteBtnView.swift
//  SmartDesk
//
//  Created by Md Fahim Faez Abir-00127 on 21/2/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

/// Enumuration:
enum HomeBtnItems: String, CaseIterable {
    case note = "Note"
    case promodoro = "Promodoro"
    case alarm = "Alarm"
    
    //choose system Image from here
    //add new image here
    var systemImage: String {
        switch self {
        case .note:
            return "note.text"
        case .promodoro:
            return "clock"
        case .alarm:
            return "alarm"
        }
    }
    var buttonColor: Color {
        switch self {
        case .note:
            return Color.blue
        case .promodoro:
            return Color.red
        case .alarm:
            return Color.green
        }
    }
    var fontColor: Color {
        switch self {
        case .note:
            return Color.black
        case .promodoro:
            return Color.black
        case .alarm:
            return Color.black
        }
    }
    
}

struct HomeBtnLabelView: View {
    
    var btnItem: HomeBtnItems //recive the btnItem
    
    var body: some View {
        
        VStack(spacing: 5) {
            Image(systemName: btnItem.systemImage)  //Btn image
                .font(.system(size: 35,design: .serif)) //define the font
                .bold() //make the btn bold
                .foregroundStyle(btnItem.fontColor) // btn foreground set to black
                .symbolEffect(.pulse) // effect of the image
            Text(btnItem.rawValue) // title of the btn
                .font(.system(size: 30,design: .serif)) // font of the btn
                .foregroundStyle(btnItem.fontColor) //
                .bold()
        }.padding(20)
            .frame(width: 250, height: 160)
            .background(  // set btn background
                btnItem.buttonColor.opacity(0.8)
            )
            .mask(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
    }
}

#Preview {
    HomeBtnLabelView(btnItem: .promodoro)
}

/*
 Model3D(named: btnName) { model in
 model
 .resizable()
 .frame(width: 50,height: 50)
 } placeholder: {}
 */
