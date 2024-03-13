//
//  AlarmSwitchView.swift
//  SmartDesk
//
//  Created by Md Fahim Faez Abir-00127 on 12/3/24.
//

import Foundation
import SwiftUI

struct AlarmSwitchView: View {
    
    @State private var offset: CGSize = CGSize(width: 10, height: 0)
    @Binding var isAlarmActive: Bool
    
    var body: some View {
        ZStack(alignment: .center) {
            GeometryReader { reader in
                SmartDeskBackgroundView()
                ZStack {
                    Color.white
                    Image(systemName: isAlarmActive ? "arrow.left" : "arrow.right")
                        .foregroundStyle(.black)
                }
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .padding(.top, 5)
                .gesture(
                    DragGesture(minimumDistance: 5, coordinateSpace: .local)
                        .onChanged({ value in
                            withAnimation(.spring(duration: 0.2)) {
                                let tempOffset = CGSize(width: offset.width + value.translation.width, height: 0)
                                let max = reader.size.width - 45
                                let min: CGFloat = 5
                                if tempOffset.width >= min && tempOffset.width <= max {
                                    offset = tempOffset
                                    if offset.width > max - 15 {
                                        offset = CGSize(width: max, height: 0)
                                        isAlarmActive = true
                                    } else if offset.width < min + 15 {
                                        offset = CGSize(width: min, height: 0)
                                        isAlarmActive = false
                                    }
                                }
                            }
                        })
                )
                .onAppear {
                    offset = isAlarmActive ? CGSize(width: reader.size.width - 45, height: 0) : CGSize(width: 5, height: 0)
                }
                .offset(x: offset.width, y: offset.height)
            }
            Text(isAlarmActive ? "Turn on" : "Turn off")
        }
        .frame(width: 200, height: 50)
        .roundedBorder()
    }
}
