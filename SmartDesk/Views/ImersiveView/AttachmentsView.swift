//
//  AttachmentsView.swift
//  SmartDesk
//
//  Created by Md Fahim Faez Abir-00127 on 4/3/24.
//

import Foundation
import SwiftUI


enum WindowType  {
    case note
    case clock
    case close
}

struct AttachmentTag: Hashable {
    let label: String
    var windowType: WindowType
    let windowID: String
    var isSelected = false
}

struct AttachmentsView: View {
    
    @Binding var attachmentsTag: [AttachmentTag]
    //This is a property wrapper to read a value which is stored in views environment
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dissmissWindow
    
    var body: some View {
        ZStack(alignment: .bottom) {
            SmartDeskBackgroundView()
            GeometryReader { reader in
                HStack {
                    ForEach(attachmentsTag.indices, id: \.self) { i in
                        Button(action: {
                            self.toggleSelection(index: i)
                            switch attachmentsTag[i].windowType {
                            case .note:
                                openWindow(id: attachmentsTag[i].windowID, value: attachmentsTag[i].label)
                            case .clock:
                                openWindow(id: attachmentsTag[i].windowID, value: attachmentsTag[i].label)
                            case .close:
                                dissmissWindow(id: attachmentsTag[i].windowID)
                                self.toggleSelection(index: i)
                            }
                        }) {
                            Text(attachmentsTag[i].label)
                                .font(.extraLargeTitle)
                                .foregroundColor(.white)
                                .padding(10)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.gray.opacity(0.5))
                                        .opacity(attachmentsTag[i].isSelected ? 1 : 0)
                                )
                        }
                        .frame(width: reader.size.width / CGFloat(attachmentsTag.count), height: 50)
                        .buttonStyle(.plain)
                        .hoverEffectDisabled(true)
                        .padding(.horizontal,5)
                        if i < attachmentsTag.count - 1 {
                            Divider()
                        }
                    }
                }
            }
        }
        .roundedBorder()
        .frame(width: CGFloat(attachmentsTag.count) * 300 ,height: 150)
    }
    
    private func toggleSelection(index: Int) {
        for i in attachmentsTag.indices {
            if i == index {
                attachmentsTag[i].isSelected.toggle()
            } else {
                attachmentsTag[i].isSelected = false
            }
        }
    }
}
