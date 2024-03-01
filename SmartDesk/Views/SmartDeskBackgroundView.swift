//
//  SmartDeskBackGroundView.swift
//  SmartDesk
//
//  Created by Md Fahim Faez Abir-00127 on 27/2/24.
//

import SwiftUI

struct SmartDeskBackgroundView: View {
    var body: some View {
        LinearGradient(
            colors:[.darkGreen.opacity(1),
                    .black.opacity(0.7)],
            startPoint: .top,
            endPoint: .bottomTrailing)
    }
}

#Preview {
    SmartDeskBackgroundView()
}
