//
//  ErrorWrapper.swift
//  Scrumdinger
//
//  Created by Anish kumar dubey on 01/12/22.
//

import Foundation

struct ErrorWrapper : Identifiable {
    let id: UUID
    let error: Error
    let guidance: String
    
    init(id: UUID = UUID(), error: Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}
