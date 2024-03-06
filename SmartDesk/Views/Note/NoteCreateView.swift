//
//  NoteCreateView.swift
//  SmartDesk
//
//  Created by Md Fahim Faez Abir-00127 on 4/3/24.
//

import SwiftUI

struct NoteCreateView: View {
    
    @State var note: Note?
    @State var noteBody = ""
    @State var noteTitle = ""
    //This will find the noteViewModel that is previously attached with this view
    @Environment(NoteViewModel.self) private var noteViewModel: NoteViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            TextField("New Node", text: $noteBody, axis: .vertical)
                .font(.system(size: 40))
                .multilineTextAlignment(.leading)
                .onAppear {
                    if let _note = note {
                        noteBody = _note.body
                        noteTitle = _note.title
                    }
                }.onDisappear {
                    if let _note = note {
                        if _note.body != noteBody || _note.title != noteTitle {
                            if !noteBody.isEmpty {
                                _note.title = noteTitle.isEmpty ? String(noteBody.prefix(10)) : noteTitle
                                _note.body = noteBody
                                _note.creationTime = .now
                                noteViewModel.updateNote(note: _note)
                            }
                        }
                    } else {
                        if !noteBody.isEmpty {
                            noteViewModel.addToNote(
                                note: Note(
                                    title: noteTitle.isEmpty ? String(noteBody.prefix(10)) : noteTitle,
                                    body: noteBody,
                                    creationTime: .now)
                            )
                        }
                       
                    }
                }.frame(maxWidth: .infinity , maxHeight: .infinity)
        }
        .padding(.leading, 40)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                    TextField("Tittle", text: $noteTitle)
                        .font(.largeTitle)
                        .padding(.leading, 15)
            }
        }
    }
}

#Preview {
    NoteCreateView(note: Note(title: "", body: "", creationTime: .now))
}
