//
//  NoteDataSource.swift
//  SmartDesk
//
//  Created by Md Fahim Faez Abir-00127 on 5/3/24.
//

import Foundation
import SwiftData

//Create Note data source from here
protocol AddNoteDataSource {
    //TODO: This function will recive NoteModel and add to database and return status
    func addNewNote(note: Note)-> Result<Bool, Error>
}

// CreateFetchNoteDataSource
protocol FetchNoteDataSource {
    //TODO: This function will fetch all data from note model and return all the data
    func fetchAllNote()-> Result<[Note], Error>
}
//UpdateNoteData source
protocol UpdateNoteSource {
    //TODO: This function will recive NoteModel and return update status
    func updateNote(note: Note)-> Result<Bool, Error>
}
//Delete Note data source
protocol DeleteNoteDataSource {
    //TODO: This function will recive NoteModel and return deletaion status
    func deleteNote(note: Note)-> Result<Bool, Error>
}
typealias NoteDataSource = AddNoteDataSource & FetchNoteDataSource & UpdateNoteSource & DeleteNoteDataSource

//TODO: Create DataRepository class
struct NoteSwiftDataSource: NoteDataSource {

    //model context
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext //set value to model context
    }
    
    func addNewNote(note: Note)-> Result<Bool, Error> {
        modelContext.insert(note)
        do {
            try modelContext.save()
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
    
    func fetchAllNote()-> Result<[Note], Error> {
        //define short descriptor in decending order based on time
        // it is a replacement of NSPredicate
        let fetchDescriptor = FetchDescriptor<Note> (
            sortBy: [
                SortDescriptor(\Note.creationTime, order: .reverse) //Short note data to reverse order based on creation time
            ])
        do {
            let noteData = try modelContext.fetch(fetchDescriptor)  // fetch data based on the query
            return .success(noteData)
        } catch {
            return .failure(error)
        }
    }
    
    func updateNote(note: Note)-> Result<Bool, Error> {
        let prevNote = modelContext.model(for: note.id) as? Note ?? Note(title: note.title, body: note.body, creationTime: note.creationTime)
        do {
            try modelContext.save()
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
    
    func deleteNote(note: Note)-> Result<Bool, Error> {
        modelContext.delete(note)
        do {
            try modelContext.save()
            return .success(true)
        } catch {
            return .failure(error)
        }
    }

}
