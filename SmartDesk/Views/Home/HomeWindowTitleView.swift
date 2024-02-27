//
//  TitleView.swift
//  SmartDesk
//
//  Created by Md Fahim Faez Abir-00127 on 22/2/24.
//

import SwiftUI

struct HomeWindowTitleView: View {
    
    @State var animatedTitle: String = ""
    let title: String
    private let typeSpeed: Double = 0.2
    
    var body: some View {
        Text(animatedTitle)
            .font(.system(size: 50,design: .monospaced))
            .bold()
            .foregroundStyle(.white)
            .animation(.easeOut(duration: typeSpeed))
            .onAppear {
                typeAnimation()
            }.onDisappear {
                animatedTitle = ""
            }
        
    }
    
    func typeAnimation(currentIndex: Int = 0) {
        
        guard currentIndex < title.count else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + typeSpeed) {
                let strIndex = title.index(title.startIndex, offsetBy: currentIndex)
                animatedTitle.append(title[strIndex])
                typeAnimation(currentIndex: currentIndex + 1)
        }
    }
}

#Preview {
    HomeWindowTitleView(title: "Welcome to Smart Desk")
}
