//
//  Entry.swift
//  CloudKitJournal
//
//  Created by Owen Barrott on 10/5/20.
//  Copyright © 2020 Zebadiah Watson. All rights reserved.
//

import Foundation
import CloudKit

struct EntryConstants {
    static let recordTypeKey = "Entry"
    static let titleKey = "title"
    static let textKey = "text"
    static let timestampKey = "timestamp"
}

class Entry {
    let title: String
    let text: String
    let timestamp: Date
    let ckRecordID: CKRecord.ID
    
    init(title: String, text: String, timestamp: Date = Date(), ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.title = title
        self.text = text
        self.timestamp = timestamp
        self.ckRecordID = ckRecordID
    }
}

extension Entry {
    convenience init?(ckRecord:CKRecord) {
        guard let title = ckRecord[EntryConstants.titleKey] as? String, let text = ckRecord[EntryConstants.textKey] as? String, let timestamp = ckRecord[EntryConstants.timestampKey] as? Date else { return nil }
        self.init(title: title, text: text, timestamp: timestamp)
    }
}

extension CKRecord {
    convenience init(entry: Entry) {
        self.init(recordType: EntryConstants.recordTypeKey, recordID: entry.ckRecordID)
        
        self.setValuesForKeys([
            EntryConstants.titleKey: entry.title,
            EntryConstants.textKey: entry.text,
            EntryConstants.timestampKey: entry.timestamp
        ])
    }
}

