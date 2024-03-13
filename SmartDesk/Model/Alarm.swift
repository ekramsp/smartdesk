//
//  Alarm.swift
//  SmartDesk
//
//  Created by Md Fahim Faez Abir-00127 on 11/3/24.
//

import Foundation
import SwiftData

@Model
class Alarm {
    @Attribute(.unique) var time: Date
    var reapet: [WeekDays]
    var alarmLabel: String
    var isAlarmActive: Bool
    var alarmSound: String
    init(time: Date, reapet: [WeekDays], alarmLabel: String, isAlarmActive: Bool, alarmSound: String) {
        self.time = time
        self.reapet = reapet
        self.alarmLabel = alarmLabel
        self.isAlarmActive = isAlarmActive
        self.alarmSound = alarmSound
    }
}
