//
//  NoteRepository.swift
//  SmartDesk
//
//  Created by Md Fahim Faez Abir-00127 on 5/3/24.
//

import Foundation
import SwiftData

// Repository to add new note to data base
protocol AddNewNoteRepository {
    //TODO: This function will recive NoteModel and add to database and return status
    func addNewNote(note: Note)-> Result<Bool, Error>
}
// Repository to add fetch note from data base
protocol FetchNoteRepository {
    //TODO: This function will fetch all data from note model and return all the data
    func fetchAllNote()-> Result<[Note], Error>
}
//Repository for updating existing note
protocol UpdateNoteRepository {
    //TODO: This function will recive NoteModel and return update status
    func updateNote(note: Note)-> Result<Bool, Error>
}
//Repository for Delete a note
protocol DeleteNoteRepository {
    //TODO: This function will recive NoteModel and return deletaion status
    func deleteNote(note: Note) -> Result<Bool, Error>
}

typealias NoteRepository = AddNewNoteRepository & FetchNoteRepository & UpdateNoteRepository & DeleteNoteRepository

//TODO: Create DataRepository class

struct NoteDataRepository: NoteRepository {
    var noteDataSource: NoteDataSource
    
    init(modelContext: ModelContext) {
        noteDataSource = NoteSwiftDataSource(modelContext: modelContext)
    }
    
    
    func addNewNote(note: Note)-> Result<Bool, Error>{
        noteDataSource.addNewNote(note: note)
    }
    
    func fetchAllNote()-> Result<[Note], Error> {
        noteDataSource.fetchAllNote()
    }
    
    func updateNote(note: Note)-> Result<Bool, Error> {
        noteDataSource.updateNote(note: note)
    }
    
    func deleteNote(note: Note) -> Result<Bool, Error> {
        noteDataSource.deleteNote(note: note)
    }
}
