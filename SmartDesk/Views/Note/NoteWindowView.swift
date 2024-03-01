//
//  NoteWindowView.swift
//  SmartDesk
//
//  Created by Md Fahim Faez Abir-00127 on 27/2/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct NoteWindowView: View {
  //  let component = MyComponent()
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) {
                content.add(scene)
            }
        }
    }
}

#Preview {
    NoteWindowView()
}

