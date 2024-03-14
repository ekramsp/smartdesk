//
//  NoteWindowView.swift
//  SmartDesk
//
//  Created by Md Fahim Faez Abir-00127 on 27/2/24.
//

import SwiftUI
import RealityKit
import RealityKitContent
import SwiftData

struct NoteWindowView: View {
    
    @State var sceneName: String
    @State private var noteViewModel: NoteViewModel
    ///Model contexts observes all the changed to the models like insert update delete fetch
    @Environment(\.modelContext) var modelcontext
    
    init(sceneName: String, modelcontext: ModelContext) {
        self.sceneName = sceneName
        let noteViewModel = NoteViewModel(modelContext: modelcontext)
        _noteViewModel = State(initialValue: noteViewModel)
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(noteViewModel.notes, id: \.id) { note in
                    NavigationLink {
                        NoteCreateView(note: note)
                             //attaching the view model reference to the NoteCreateView environmet
                             //environment will stored the referench
                            .environment(noteViewModel)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .font(.largeTitle)
                            Text(note.creationTime.formatted(Date.FormatStyle().day().month().year()))
                                .font(.title2)
                        }.contextMenu {
                            Button("Delete") {
                                noteViewModel.deleteNote(note: note)
                            }
                        }
                    }
                }
            }.navigationTitle("Notes")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            NoteCreateView()
                                .environment(noteViewModel)
                        }label: {
                            Image(systemName: "square.and.pencil")
                                .font(.title)
                                .bold()
                        }
                    }
                }.onAppear {
                    noteViewModel.getAllNote()
                }.overlay(content: {
                    if noteViewModel.notes.isEmpty {
                        ContentUnavailableView(label: {
                            Label("No notes available", systemImage:  "note.text")
                        }, description: {
                            Text("Start adding notes to see your list")
                        }, actions: {
                            NavigationLink {
                                NoteCreateView()
                                    .environment(noteViewModel)
                            }label: {
                                Image(systemName: "square.and.pencil")
                                    .font(.title)
                                    .bold()
                            }
                        })
                    }
                })
                
        }.navigationTitle("Notes")
            .background(
                SmartDeskBackgroundView()
            ).roundedBorder()
             
               
    }
}

//#Preview {
//    NoteWindowView(sceneName: "notes")
//}

