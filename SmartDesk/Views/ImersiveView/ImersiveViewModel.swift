//
//  ImersiveViewModel.swift
//  SmartDesk
//
//  Created by Md Fahim Faez Abir-00127 on 2/3/24.
//

import Foundation
import RealityKit
import RealityKitContent

//protocol AudioPlayBackControllerDelegate: AnyObject {
//    var audioPlayBackController: AudioPlaybackController? { get set }
//}

@Observable
class ImersiveViewModel {
    
    var rootEntity: Entity?
    
    var audioPlayBackController: AudioPlaybackController?
    
    var isAlarmStop: Bool = false
    
    func audioSetUp() {
        Task {
            guard let scene = await rootEntity?.scene else {return}
            guard let resource = try? await AudioFileResource(named: "/Root/Table/promodoro/CarAlarm",
                                                              from: "Scene.usda", in: realityKitContentBundle) else {return}
            audioPlayBackController = await scene.findEntity(named: "promodoro")?.prepareAudio(resource)
        }
    }
}
