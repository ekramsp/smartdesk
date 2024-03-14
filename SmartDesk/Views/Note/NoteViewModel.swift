//
//  NoteViewModel.swift
//  SmartDesk
//
//  Created by Md Fahim Faez Abir-00127 on 4/3/24.
//

import Foundation
import SwiftData

@Observable
class NoteViewModel {
    var notes: [Note] = []
    var noteRepository: NoteRepository?
    
    init(modelContext: ModelContext) {
        noteRepository = NoteDataRepository(modelContext: modelContext)
    }
        
    func addToNote(note: Note) {
        let result = noteRepository?.addNewNote(note: note)
        guard let result = result else {return}
        switch (result) {
        case .success(let succes):
           getAllNote()
           print(succes)
        case .failure(let error):
            print("!400: addToNote() Note not added. Error: " + error.localizedDescription)
        }
    }
    
    func getAllNote() {
        let result = noteRepository?.fetchAllNote()
        guard let result = result else {return}
        switch (result) {
        case .success(let note):
            self.notes = note
        case .failure(let error):
            print("!400: addToNote() Note not added. Error: " + error.localizedDescription)
        }
    }
    
    func deleteNote(note: Note) {
        let result = noteRepository?.deleteNote(note: note)
        guard let result = result else {return}
        switch (result) {
        case .success(let flag):
           print(flag)
           getAllNote()
        case .failure(let error):
            print("!401: deleteNote(): Failed to delete note. Error: " + error.localizedDescription)
        }
    }
    
    func updateNote(note: Note) {
        let result = noteRepository?.updateNote(note: note)
        guard let result = result else {return}
        switch (result) {
        case .success(let flag):
           print(flag)
            getAllNote()
        case .failure(let error):
            print("!401: deleteNote(): Failed to delete note. Error: " + error.localizedDescription)
        }
    }
    
    
}
