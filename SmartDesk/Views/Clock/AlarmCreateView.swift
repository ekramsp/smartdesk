//
//  AlarmCreateView.swift
//  SmartDesk
//
//  Created by Md Fahim Faez Abir-00127 on 12/3/24.
//

import Foundation
import SwiftUI
import SwiftData

struct WeekDays: Hashable, Codable {
    var days: String
    var isSelected: Bool
}

struct AlarmCreateView: View {
    
    let buttonAction: ()->Void
    @State var alarm: Alarm?
    @State var modelContext: ModelContext
    @State var date = Date.now
    @State var weekdays: [WeekDays] = [
        WeekDays(days: "S", isSelected: false),
        WeekDays(days: "M", isSelected: false),
        WeekDays(days: "T", isSelected: false),
        WeekDays(days: "W", isSelected: false),
        WeekDays(days: "T", isSelected: false),
        WeekDays(days: "F", isSelected: false),
        WeekDays(days: "S", isSelected: false)
    ]
    
    @State var label: String = ""
    @State var isAlarmActivate: Bool = false
    @Binding var isAlarmUpdated: Bool

    var body: some View {
        ZStack {
            SmartDeskBackgroundView()
            VStack(spacing: 25) {
                HStack {
                    Spacer()
                    Button(action: buttonAction) {
                        Image(systemName: "multiply")
                            .font(.largeTitle)
                    }
                    .padding()
                }
                DatePicker("", selection: $date, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .roundedBorder()
                HStack {
                    ForEach(weekdays.indices, id: \.self) { i in
                        Button(action: {
                            weekdays[i].isSelected.toggle()
                        }, label: {
                            Text(weekdays[i].days)
                        }).frame(width: 20,height: 20)
                            .background(weekdays[i].isSelected ? .yellow : .white)
                            .foregroundStyle(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .buttonStyle(.plain)
                    }
                }
                
                HStack(alignment: .center) {
                    Text("Label: ")
                    TextField("label", text: $label)
                        .overlay(alignment: .bottom) {
                            RoundedRectangle(cornerSize: CGSize(width: 2, height: 2))
                                .stroke()
                                .frame(height: 1)
                        }
                }.padding(.leading, 70)
                    .padding(.trailing, 70)
                //Swap action view
                AlarmSwitchView(isAlarmActive: $isAlarmActivate)
                    .onChange(of: isAlarmActivate) { _, _ in
                        if isAlarmActivate {
                            print("on")
                        } else {
                            print("off")
                        }
                    }
                
                HStack {
                    Button {
                        if let _alarm = alarm {
                            modelContext.delete(_alarm)
                            isAlarmUpdated = true
                            buttonAction()
                        }
                    } label: {
                        Text("Delete")
                    }.frame(alignment: .leading)
                    
                    Button {
                       
                        if alarm == nil {
                            isAlarmUpdated = true
                            modelContext.insert(Alarm(time: date > Date.now ? date : date.addingTimeInterval(24*60*60), reapet: weekdays, alarmLabel: label, isAlarmActive: isAlarmActivate, alarmSound: ""))
                        } else {
                            if let _alarm = alarm {
                                _alarm.time = date > Date.now ? date : date.addingTimeInterval(24*60*60)
                                _alarm.alarmLabel = label
                                _alarm.reapet = weekdays
                                _alarm.isAlarmActive = isAlarmActivate
                            }
                            isAlarmUpdated = true
                        }
                        buttonAction()
                    } label: {
                        Text("Save")
                    }.frame(alignment: .trailing)
                }.padding(.bottom , 20)
            }
        }
        .frame(width: 400, height: 400)
        .roundedBorder()
        .onAppear {
            if let _alarm = alarm {
                date = _alarm.time
                label = _alarm.alarmLabel
                weekdays = _alarm.reapet
                isAlarmActivate = _alarm.isAlarmActive
            }
        }.onDisappear {
            alarm = nil
        }
    }
}
