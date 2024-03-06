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
    //
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
                let anchor = AnchorEntity(world: .zero) // this set model y axis to zero
                anchor.anchoring.trackingMode = .once // this will computed only once
                anchor.addChild(entity)  // add the entity to anchor entity as a child entity
                contents.add(anchor) // adding anchor to the content
                anchor.position = SIMD3<Float>(0, 0, -2) // set the scaller value of the model
            } catch {
                print("Error in RealityView's make: \(error)")
            }
            
        } update: { contents , attachments in  // this will change the view state
            
            // set the attachMentEntity for note
            guard let attachmentEntityNote = attachments.entity(for: Constants.attachmentNoteId) else {return}
            // set the attachMentEntity for clock
            guard let attachmentEntityClock = attachments.entity(for: Constants.attachmentClockId) else {return}
            //Findout the note entity from rootEntity
            guard let note = viewModel.rootEntity?.findEntity(named: Constants.note) else {return}
            //Findout the clock entity from rootEntity
            guard let clock = viewModel.rootEntity?.findEntity(named: Constants.clock) else {return}
            //Setting the position of note attachment relative to note
            attachmentEntityNote.setPosition([0, 200 , -100], relativeTo: note)
            //Setting the position of note attachment relative to clock
            attachmentEntityClock.setPosition([0, 300 , 250], relativeTo: clock)
            // Setting the attachments to the rootEntity
            viewModel.rootEntity?.addChild(attachmentEntityNote)
            viewModel.rootEntity?.addChild(attachmentEntityClock)
            
        } attachments: {
            /// add attachment here
            // Adding attachment for note
            Attachment(id: Constants.attachmentNoteId) {
                withAnimation(.easeOut(duration: 0.5)) {
                    AttachmentsView(attachmentsTag: $attachmentTagNote)
                        .isHidden(hide: !showAttachMentNote)
                }
            }
            // Adding attachment for clock
            Attachment(id: Constants.attachmentClockId) {
                withAnimation(.easeOut(duration: 0.3)) {
                    AttachmentsView(attachmentsTag: $attachmentTagClock)
                        .isHidden(hide: !showAttachMentClock)
                }
            }
        }
        .gesture(SpatialTapGesture().targetedToAnyEntity().onEnded({ value in  //this will trigger action to any entity after the gesture end
            // check the note name and toogle the attachment state
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

