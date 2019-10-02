//
//  TaskDetailViewController.swift
//  Tasks
//
//  Created by Casualty on 10/1/19.
//  Copyright © 2019 Thomas Dye. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveBarButtonItem: UIBarButtonItem!
    
    var task: Task? {
        didSet {
            updateViews()
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
        }
    
    @IBAction func save(_ sender: Any) {
        

        
        // Stretch goal of disabling the save button
        guard let name = nameTextField.text, !name.isEmpty else {
            return
        }
        

        let notes = notesTextView.text
        
        if let task = task {
            // editing/updating an existing task
            task.name = name
            task.notes = notes
        } else {
            let _ = Task(name: name, notes: notes)
        }
        
        do {
            let moc = CoreDataStack.shared.mainContext
            try moc.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func updateViews() {
        
        guard isViewLoaded else { return }
        
        title = task?.name ?? "Create Task"
        nameTextField.text = task?.name
        notesTextView.text = task?.notes
        
    }

    @IBAction func textFieldEditingChanged(_ sender: Any) {
        
        if let name = nameTextField.text, !name.isEmpty {
            saveBarButtonItem.isEnabled = true
        } else {
            saveBarButtonItem.isEnabled = false
        }
    }
}

