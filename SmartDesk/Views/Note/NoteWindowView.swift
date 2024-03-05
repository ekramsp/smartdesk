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
    @Environment(NoteViewModel.self) private var noteViewModel: NoteViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(noteViewModel.noteModel, id: \.id) { note in
                    NavigationLink {
                        NoteCreateView(noteModel: note)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .font(.largeTitle)
                            Text(note.creationTime.ISO8601Format())
                                .font(.title2)
                        }.contextMenu {
                            Button("Delete") {
                                if let index = noteViewModel.noteModel.firstIndex(where: { $0.id == note.id }) {
                                    noteViewModel.noteModel.remove(at: index)
                                }
                            }
                        }
                    }
                }
            }.navigationTitle("Notes")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink(destination: NoteCreateView(noteModel: NoteModel(title: "", body: "", creationTime: .now))) {
                            Image(systemName: "square.and.pencil")
                                .font(.title)
                                .bold()
                        }
                    }
                }
        }.navigationTitle("Notes")
            .background(
                SmartDeskBackgroundView()
            ).roundedBorder()
    }
}

#Preview {
    NoteWindowView(sceneName: "notes")
}

