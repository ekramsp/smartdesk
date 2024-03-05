//
//  NoteModel.swift
//  SmartDesk
//
//  Created by Md Fahim Faez Abir-00127 on 4/3/24.
//

import Foundation

struct NoteModel: Identifiable {
    var id = UUID().uuidString
    var title: String
    var body: String
    var creationTime: Date
    
}

extension NoteModel {
    static func createDemoNote()-> [NoteModel] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return [
            NoteModel(title: "Meeting Notes", body: "Discuss project deadlines and deliverables", creationTime: dateFormatter.date(from: "2024-03-04 09:00:00")!),
            NoteModel(title: "Grocery List", body: "Milk, eggs, bread, cheese", creationTime: dateFormatter.date(from: "2024-03-03 17:30:00")!),
            NoteModel(title: "To-Do List", body: "Finish coding assignment, call mom, buy birthday gift", creationTime: dateFormatter.date(from: "2024-03-02 10:15:00")!)
        ]
    }
}
