//
//  TaskTableViewCell.swift
//  Task
//
//  Created by Ben Erekson on 7/21/21.
//

import UIKit

protocol taskCompletionDelegate: AnyObject{
    func taskCellButtonTapped(_ sender: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {
    
    var task: Task? {
        didSet{
            updateViews()
        }
    }
    
    //MARK: - Delegates
    weak var delegate: taskCompletionDelegate?
    

    //MARK: - IBOutlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //MARK: - Actions
    @IBAction func completionButtonTapped(_ sender: Any) {
            delegate?.taskCellButtonTapped(self)
    }
    
    //MARK: - Functions
    func updateViews(){
        guard let task = task else {return}
        taskNameLabel.text = task.name
        if task.isCompleted {
            completionButton.setBackgroundImage(UIImage(named: "complete"), for: .normal)
            } else {
                completionButton.setBackgroundImage(UIImage(named: "incomplete"), for: .normal)
            }
        }
    

    
    
}
