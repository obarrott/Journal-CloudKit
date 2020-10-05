//
//  EntryError.swift
//  CloudKitJournal
//
//  Created by Owen Barrott on 10/5/20.
//  Copyright © 2020 Zebadiah Watson. All rights reserved.
//

import Foundation

enum EntryError: LocalizedError {
    case ckError(Error)
    case couldNotUnwrap
    
    var errorDescription: String {
        switch self {
        case .ckError(let error):
            return "There was an error saving or retrieving data from the CKContainer. Error: \(error)."
        case .couldNotUnwrap:
            return "Unable to unwrap the CKRecord."
        }
    }
}
