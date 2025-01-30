//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Testing

@testable import LaunchLab

class CoFounderTests {
    @Test func testSingletonBehavior() {
        let instance1 = CoFounder.shared
        let instance2 = CoFounder.shared
        #expect(instance1 === instance2, "CoFounder shared instance should always return the same object.")
    }

    @Test func testGetHelp() async {
        let cofounder = CoFounder.shared
        let title = "Startup Basics"
        let question = "How to define a target audience?"

        let response = await cofounder.getHelp(title, question: question)

        #expect(response != nil, "Response should not be nil.")
    }

    @Test func testCreateDocument() async {
        let cofounder = CoFounder.shared
        let documentTypes: [CoFounder.DocumentType] = [.elevatorPitch, .pitchDeck, .businessPlan]

        for type in documentTypes {
            let response = await cofounder.createDocument(type)
            #expect(response != nil, "Response for document type \(type) should not be nil.")
        }
    }
}
