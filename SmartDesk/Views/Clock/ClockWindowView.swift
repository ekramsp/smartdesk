//
//  ClockWindowView.swift
//  SmartDesk
//
//  Created by Md Fahim Faez Abir-00127 on 4/3/24.
//

import SwiftUI
import SwiftData

struct ClockWindowView: View {
    
    @State var sceneName: String
    @State var isAlarmCreateViewOpen = true
    @State var clockViewModel = ClockViewModel()
    @Environment(ImersiveViewModel.self) private var viewModel
    @Environment(\.modelContext) var modelcontext
    @Environment(\.scenePhase) var scenePhase
    @Query(sort: \Alarm.time) var alarms: [Alarm]
    @State var alarm: Alarm?
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var isAlarmUpdated: Bool = false
    @State var alarmingIndex: Int = -1
    @State var isAlarmPlaying: Bool = false
    let columns = [
        GridItem(.adaptive(minimum: 200)),
    ]
    var easeInOutAnimation: Animation{
        .easeInOut(duration: 1)
        .speed(2)
        .repeatForever()
    }
    var body: some View {
        
        ZStack {
            SmartDeskBackgroundView()
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10, content: {
                    ForEach(alarms.indices, id: \.self) { i in
                        VStack {
                            VStack(alignment: .leading) {
                                Text("\(alarms[i].time.formatted(Date.FormatStyle().hour().minute()))")
                                    .font(.largeTitle)
                                    .bold()
                                Text("Label: \(alarms[i].alarmLabel)")
                                    .font(.title)
                                
                                HStack {
                                    Text("Repeat: ")
                                        .font(.title)
                                    ForEach(alarms[i].reapet.indices , id: \.self) { j in
                                        if alarms[i].reapet[j].isSelected {
                                            Text(alarms[i].reapet[j].days)
                                                .font(.title)
                                        }
                                    }
                                }
                                
                                Text("Sound: Default")
                                    .font(.title)
                            }.padding()
                            Button {
                                if isAlarmPlaying && i == alarms.count - 1  {
                                    isAlarmPlaying = false
                                    viewModel.audioPlayBackController?.stop()
                                }
                            } label: {
                                Text("Stop")
                                    .font(.title3)
                            }
                        }
                        .padding()
                        .overlay (
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(isAlarmPlaying && i == alarms.count - 1 ? .red : .white,lineWidth: 4)
                                .animation(isAlarmPlaying && i == alarms.count - 1 ? easeInOutAnimation : .default, value: isAlarmPlaying && i == alarms.count - 1)
                        ).mask(RoundedRectangle(cornerRadius: 20))
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .onTapGesture {
                            alarm = alarms[i]
                            isAlarmCreateViewOpen = false
                        }
                    }
                }).scrollClipDisabled()
            }.padding().frame(maxWidth: .infinity,maxHeight: .infinity)
                .overlay(alignment: .center) {
                    AlarmCreateView(buttonAction: {
                        alarm = nil
                        isAlarmCreateViewOpen.toggle()
                    },
                    alarm: alarm, modelContext: modelcontext, isAlarmUpdated: $isAlarmUpdated
                    ).isHidden(hide: isAlarmCreateViewOpen)
                        .onChange(of: isAlarmUpdated) { oldValue, newValue in
                            if isAlarmUpdated {
                                isAlarmUpdated = false
                                updateAlarmData()
                            }
                        }
                    
                    if alarms.isEmpty {
                        ContentUnavailableView(label: {
                            Label("No Alarm is set", systemImage:  "note.text")
                        }, description: {
                            Text("Start setting alarm to see your list")
                        }, actions: {
                            Button {
                                isAlarmCreateViewOpen.toggle()
                            }label: {
                                Image(systemName: "square.and.pencil")
                                    .font(.title)
                                    .bold()
                            }
                        }).isHidden(hide: !isAlarmCreateViewOpen)
                    }
                }.onReceive(time, perform: { _ in
                   checkForAlarm()
                })
        }.roundedBorder()
            .padding(30)
            .ornament(attachmentAnchor: .scene(.bottom)) {
                HStack {
                    Button(action: {
                        isAlarmCreateViewOpen = false
                    }, label: {
                        Image(systemName: "plus")
                            .font(.extraLargeTitle)
                            .padding()
                    })
                }
                .background(
                    SmartDeskBackgroundView()
                ).roundedBorder()
                    .minimumScaleFactor(0.5)
            }
    }
    
    private func checkForAlarm() {
        let currentTime = Date()
        if let firstAlarm = clockViewModel.alarm.first, firstAlarm.time <= currentTime {
            if viewModel.audioPlayBackController?.isPlaying ?? false {
                viewModel.audioPlayBackController?.stop()
            }
            viewModel.audioPlayBackController?.play()
            if let index = alarms.firstIndex(of: firstAlarm) {
                alarms[index].isAlarmActive = false
                alarms[index].time = alarms[index].time.addingTimeInterval(24 * 60 * 60)
                isAlarmPlaying = true
                clockViewModel.alarm.removeFirst()
            }
        }
    }
    
    private func updateAlarmData() {
        clockViewModel.alarm = alarms.filter({ alarm in
            alarm.isAlarmActive == true
        })
    }
}

//#Preview {
//  //  ExtractedView()
//}



