//
//  EntryController.swift
//  CloudKitJournal
//
//  Created by Owen Barrott on 10/5/20.
//  Copyright © 2020 Zebadiah Watson. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    //Shared instance of EntryController
    static let shared = EntryController()
    
    //Source of Truth
    var entries: [Entry] = []
    
    //PrivateDB of the default container.
    let privateDB = CKContainer.default().privateCloudDatabase
    
    // MARK: - CRUD Functions
    
    //Create
    func createEntryWith(title: String, text: String, completion: @escaping (Result<Entry?, EntryError>) -> Void) {
        
        let newEntry = Entry(title: title, text: text)
        //save Entry
        saveEntry(entry: newEntry, completion: completion)
        }
    
    //Save
    func saveEntry(entry: Entry, completion: @escaping (Result<Entry?, EntryError>) -> Void) {
        let entryRecord = CKRecord(entry: entry)
        
        CKContainer.default().privateCloudDatabase.save(entryRecord) { (record, error) in
            if let error = error {
                return completion(.failure(.ckError(error)))
            }
            
            guard let record = record, let savedEntry = Entry(ckRecord: record) else { return completion(.failure(.couldNotUnwrap)) }
            
            print("Saved Entry successfully.")
            EntryController.shared.entries.append(savedEntry)
            completion(.success(savedEntry))
        }
    }
    
    //Read (Fetch)
    func fetchEntriesWith(completion: @escaping(Result<[Entry]?, EntryError>) -> Void) {
        let fetchAllPredicate = NSPredicate(value: true)
        let query = CKQuery(recordType: EntryConstants.recordTypeKey , predicate: fetchAllPredicate)
        
        CKContainer.default().privateCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                completion(.failure(.ckError(error)))
            }
            
            guard let records = records else { return completion(.failure(.couldNotUnwrap))}
            
            print("Fetched Entries successfully.")
            
            let fetchedEntries = records.compactMap({Entry(ckRecord: $0)})
            EntryController.shared.entries = fetchedEntries
            completion(.success(fetchedEntries))
        }
    }
}


