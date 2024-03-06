//
//  NoteModel.swift
//  SmartDesk
//
//  Created by Md Fahim Faez Abir-00127 on 4/3/24.
//

import Foundation
import SwiftData

@Model //This is a new swift macro that helps to define your model`s schema from code
final class Note {
    @Attribute(.unique) var title: String
    var body: String
    var creationTime: Date
    init(title: String, body: String, creationTime: Date) {
        self.title = title
        self.body = body
        self.creationTime = creationTime
    }
}
