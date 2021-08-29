//
//  ViewController.swift
//  Task
//
//  Created by Ben Erekson on 7/21/21.
//

import UIKit

class DetailsViewController: UIViewController {

    var task: Task?
    
    //MARK: - IBOutlets
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextField!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: - Actions

    @IBAction func saveButtonTapped(_ sender: Any) {
        if let task = task {
            guard let newName = taskNameTextField.text,
                  let newNote = taskNotesTextView.text else {return}
                  let newDate = taskDueDatePicker.date 
                  
            TaskController.sharedInstance.update(task: task, name: newName, note: newNote, dueDate: newDate)
        }else{
            guard let name = taskNameTextField.text,
                  let note = taskNotesTextView.text else {return}
                  let date = taskDueDatePicker.date
            
            TaskController.sharedInstance.createTaskWith(name: name, notes: note, dueDate: date)
            
        }
        navigationController?.popViewController(animated: true)
    }
    @IBAction func dueDateChanged(_ sender: Any) {
        
    }
    
    //MARK: - Functions
    
    func updateViews() {
        guard let task = task else {return}
        taskNameTextField.text = task.name
        taskNotesTextView.text = task.notes
        guard let date: Date = task.dueDate else {return}
        taskDueDatePicker.date = date
    }
    
}//End Of Class

