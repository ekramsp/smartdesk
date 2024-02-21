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
enum ButtonItems: String, CaseIterable {
    case note = "Note"
    case promodome = "Promo Dome"
    case alarm = "Alarm"
    
    //choose system Image from here
    //add new image here
    var systemImage: String {
        switch self {
        case .note:
            return "note.text"
        case .promodome:
            return "clock"
        case .alarm:
            return "alarm"
        }
    }
}

struct BtnLabelView: View {
    
    var btnItem: ButtonItems //recive the btnItem
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: btnItem.systemImage)  //Btn image
                .font(.system(size: 35,design: .serif)) //define the font
                .bold() //make the btn bold
                .foregroundStyle(.black) // btn foreground set to black
                .symbolEffect(.pulse) // effect of the image
            Text(btnItem.rawValue) // title of the btn
                .font(.system(size: 35,design: .serif)) // font of the btn
                .foregroundStyle(.black) // 
                .bold()
        }.padding(20)
            .background(
                RoundedRectangle(cornerRadius: 25) // create the rounded rectangle
                    .stroke(lineWidth: 1.0) // stroke the rectangle with width
                    .foregroundStyle(Color.white.opacity(0.8)) // define border color
                    .background(  // set btn backgrounf
                        Color.gray.opacity(0.3)  //set background color
                            .clipShape(RoundedRectangle(cornerRadius: 25)) // cliped using the parent rectangle radius
                    ).shadow(color: .white.opacity(0.2),radius: 5, x: 0, y: 5) // give shadow
                     .shadow(color: .black.opacity(1),radius: 20, x: 0, y: 10)
            )
        
    }
}

#Preview {
    BtnLabelView(btnItem: .promodome)
}

/*
 Model3D(named: btnName) { model in
         model
             .resizable()
             .frame(width: 50,height: 50)
 } placeholder: {}
 */
