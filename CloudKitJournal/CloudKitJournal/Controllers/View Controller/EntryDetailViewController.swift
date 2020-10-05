//
//  EntryDetailViewController.swift
//  CloudKitJournal
//
//  Created by Owen Barrott on 10/5/20.
//  Copyright © 2020 Zebadiah Watson. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {

    
    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textTextView: UITextView!
    
     
     
    // MARK: - Properties
    var entry: Entry? {
        didSet {
            self.loadViewIfNeeded()
            self.updateViews()
        }
    }
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self

    }
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty,
            let text = textTextView.text, !text.isEmpty else { return }
        
        EntryController.shared.createEntryWith(title: title, text: text) { (result) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func clearTextButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        textTextView.text = ""
    }
    
    // MARK: - Helper Functions
    
    func updateViews() {
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        textTextView.text = entry.text
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
}
