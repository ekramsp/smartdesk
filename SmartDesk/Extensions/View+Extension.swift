//
//  HomeView+Extensions.swift
//  SmartDesk
//
//  Created by Md Fahim Faez Abir-00127 on 22/2/24.
//

import Foundation
import SwiftUI

extension View {
    //Shadow for homebutton
    func homeButtonShadow()-> some View {
        self
            .shadow(color: .black.opacity(0.5),radius: 5, x: 0, y: 5)
            .shadow(color: .black.opacity(1),radius: 20, x: 0, y: 10)
    }
    func roundedBorder()-> some View {
        self
            .overlay (
                RoundedRectangle(cornerRadius: 40) //give a rounded border
                    .stroke(.white.opacity(0.7),lineWidth: 4)
            ).mask(RoundedRectangle(cornerRadius: 40))
    }
    @ViewBuilder
    func isHidden(hide: Bool)-> some View {
        if hide {
            EmptyView()
        } else {
            self
        }
    }
}
