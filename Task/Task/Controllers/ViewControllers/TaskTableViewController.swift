//
//  TaskTableViewController.swift
//  Task
//
//  Created by Ben Erekson on 7/21/21.
//

import UIKit

class TaskTableViewController: UITableViewController, taskCompletionDelegate {
    //MARK: - Lifecycles
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.sharedInstance.loadFromPresistenceStore()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TaskController.sharedInstance.tasks.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else {return UITableViewCell()}
        let task = TaskController.sharedInstance.tasks[indexPath.row]
        cell.task = task
        
        cell.delegate = self
        
        return cell
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let taskToDelete = TaskController.sharedInstance.tasks[indexPath.row]
            TaskController.sharedInstance.delete(task: taskToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


 
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DetailsViewController,
              let indexPath = tableView.indexPathForSelectedRow else {return}
        
        if segue.identifier == "toDetails" {
            destination.task = TaskController.sharedInstance.tasks[indexPath.row]
        }
        
    }
    
    func taskCellButtonTapped(_ sender: TaskTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        let task = TaskController.sharedInstance.tasks[indexPath.row]
        TaskController.sharedInstance.toggleIsComplete(task: task)
        sender.updateViews()
    }


}//End Of Class

