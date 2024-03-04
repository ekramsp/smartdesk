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
    @State var sceneName: String
    
    var body: some View {
        Text("Note")
            .font(.largeTitle)
    }
}

#Preview {
    NoteWindowView(sceneName: "notes")
}

