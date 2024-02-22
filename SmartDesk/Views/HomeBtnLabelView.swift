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
}

struct HomeBtnLabelView: View {
    
    var btnItem: HomeBtnItems //recive the btnItem
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: btnItem.systemImage)  //Btn image
                .font(.system(size: 30,design: .serif)) //define the font
                .bold() //make the btn bold
                .foregroundStyle(.white) // btn foreground set to black
                .symbolEffect(.pulse) // effect of the image
            Text(btnItem.rawValue) // title of the btn
                .font(.system(size: 25,design: .serif)) // font of the btn
                .foregroundStyle(.white) //
                .bold()
        }.padding(20)
            .frame(width: 250, height: 160)
            .background (
                RoundedRectangle(cornerRadius: 25) // create the rounded rectangle
                    .stroke(lineWidth: 2.0) // stroke the rectangle with width
                    .foregroundStyle(Color.white) // define border color
                    .background(  // set btn background
                        LinearGradient(
                            colors: [.darkGreen.opacity(0.5),
                                     .black.opacity(0.5)],
                            startPoint: .topTrailing,
                            endPoint: .bottomLeading))
                    .shadow(color: .black.opacity(0.5),radius: 5, x: 0, y: 5) // give shadow
                    .shadow(color: .gray.opacity(1),radius: 20, x: 0, y: 10)
            ).mask(RoundedRectangle(cornerRadius: 25))
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
