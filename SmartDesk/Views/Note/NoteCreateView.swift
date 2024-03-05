//
//  NoteCreateView.swift
//  SmartDesk
//
//  Created by Md Fahim Faez Abir-00127 on 4/3/24.
//

import SwiftUI

struct NoteCreateView: View {
    var noteModel: NoteModel
    @State var noteBody = ""
    @State var noteTitle = ""
    @Environment(NoteViewModel.self) private var noteViewModel: NoteViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ScrollView {
            TextField("New Node", text: $noteBody, axis: .vertical)
                .font(.system(size: 40))
                .multilineTextAlignment(.leading)
                .onAppear {
                    noteBody = noteModel.body
                    noteTitle = noteModel.title
                }.onDisappear {
                    if noteModel.body != noteBody || noteModel.title != noteTitle {
                        if let index = noteViewModel.noteModel.firstIndex(where: { $0.id == noteModel.id }) {
                            noteViewModel.noteModel[index] = NoteModel(title: noteTitle, body: noteBody, creationTime: .now)
                        } else {
                            if noteTitle.isEmpty {
                                noteTitle = String(noteBody.prefix(10))
                                print(noteTitle)
                                noteViewModel.noteModel.insert(NoteModel(title: noteTitle, body: noteBody, creationTime: .now), at: 0)
                            } else {
                                noteViewModel.noteModel.insert(NoteModel(title: noteTitle, body: noteBody, creationTime: .now), at: 0)
                            }
                           
                        }
                    }
                }.frame(maxWidth: .infinity , maxHeight: .infinity)
        }
        .padding(.leading, 30)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack(spacing: 10) {
                    TextField("Tittle", text: $noteTitle)
                        .font(.largeTitle)
                }
                
            }
        }
    }
}

#Preview {
    NoteCreateView(noteModel: NoteModel(title: "", body: "", creationTime: .now))
}
