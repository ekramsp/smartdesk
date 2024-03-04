//
//  ImmersiveView.swift
//  SmartDesk
//
//  Created by Ekramul Hoque on 20/2/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    
    @State private var noteEntity: Entity? = nil
    @State private var showAttachMentClock = false
    @State private var showAttachMentNote = false
    @State private var viewModel = ImersiveViewModel()
    
    @State var attachmentTagNote = [
        AttachmentTag(label: "Notes", windowType: .note, windowID: Constants.NOTE_WINDOW_ID, isSelected: false),
        AttachmentTag(label: "Close", windowType: .close,windowID: Constants.NOTE_WINDOW_ID, isSelected: false),
    ]
    
    @State var attachmentTagClock = [
        AttachmentTag(label: "Alarm", windowType: .clock,windowID: Constants.CLOCK_WINDOW_ID,  isSelected: false),
        AttachmentTag(label: "Poromodoro", windowType: .clock,windowID: Constants.CLOCK_WINDOW_ID,  isSelected: false),
        AttachmentTag(label: "Close", windowType: .close,windowID: Constants.CLOCK_WINDOW_ID,  isSelected: false),
    ]
    
    var body: some View {
        RealityView { contents, attachments in
            //add content
            do {
                //parent entity
                let entity = try await Entity(named: Constants.scene, in: realityKitContentBundle)
                // add parent to content
                viewModel.rootEntity = entity
                // adding anchor to entity
                let anchor = AnchorEntity(world: .zero)
                anchor.anchoring.trackingMode = .continuous
                anchor.addChild(entity)
                contents.add(anchor)
                anchor.position = SIMD3<Float>(0, 0, -2)
            } catch {
                print("Error in RealityView's make: \(error)")
            }
        } update: { contents , attachments in
            guard let attachmentEntityNote = attachments.entity(for: Constants.attachmentNoteId) else {return}
            guard let attachmentEntityClock = attachments.entity(for: Constants.attachmentClockId) else {return}
            guard let note = viewModel.rootEntity?.findEntity(named: Constants.note) else {return}
            guard let clock = viewModel.rootEntity?.findEntity(named: Constants.clock) else {return}
            attachmentEntityNote.setPosition([0, 200 , -100], relativeTo: note)
            attachmentEntityClock.setPosition([0, 300 , 250], relativeTo: clock)
            viewModel.rootEntity?.addChild(attachmentEntityNote)
            viewModel.rootEntity?.addChild(attachmentEntityClock)
        } attachments: {
            /// add attachment here
            ///
            Attachment(id: Constants.attachmentNoteId) {
                AttachmentsView(attachmentsTag: $attachmentTagNote)
                    .isHidden(hide: !showAttachMentNote)
            }
            Attachment(id: Constants.attachmentClockId) {
                AttachmentsView(attachmentsTag: $attachmentTagClock)
                    .isHidden(hide: !showAttachMentClock)
            }
            
        }
        .gesture(SpatialTapGesture().targetedToAnyEntity().onEnded({ value in
            if value.entity.name == Constants.note{
                logger.debug("!101: ImmersiveView() tapped on note")
                showAttachMentNote.toggle()
            }
            if value.entity.name == Constants.clock {
                logger.debug("!102: ImmersiveView() tapped on clock")
                showAttachMentClock.toggle()
            }
        }))
    }
}


#Preview(immersionStyle: .mixed) {
    ImmersiveView()
}

