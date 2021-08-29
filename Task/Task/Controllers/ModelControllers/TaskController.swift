//
//  TaskController.swift
//  Task
//
//  Created by Ben Erekson on 7/21/21.
//

import Foundation

class TaskController {
    static var sharedInstance = TaskController()
    var tasks: [Task] = []
    
    //MARK: - CRUD Functions
    
    func createTaskWith(name: String, notes: String, dueDate: Date){
        tasks.append(Task(name: name, notes: notes, dueDate: dueDate))
        saveToPresistenceStore()
    }
    
    func update(task:  Task, name: String, note: String, dueDate: Date){
        guard let index = tasks.firstIndex(of: task) else {return}
        tasks[index].name = name
        tasks[index].notes = note
        tasks[index].dueDate = dueDate
        saveToPresistenceStore()
    }
    
    func toggleIsComplete(task: Task){
        guard let index = tasks.firstIndex(of: task) else {return}
        tasks[index].isCompleted.toggle()
        saveToPresistenceStore()
    }
    
    func delete(task: Task){
        guard let index = tasks.firstIndex(of: task) else {return}
        tasks.remove(at: index)
        saveToPresistenceStore()
    }
    
    
    //MARK: - Persistance
    func createPresistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("tasks.json")
        return fileURL
    }
    
    func saveToPresistenceStore() {
        do {
            let data = try JSONEncoder().encode(tasks)
            try data.write(to: createPresistenceStore())
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    func loadFromPresistenceStore() {
        do {
            let data = try Data(contentsOf: createPresistenceStore())
            tasks = try JSONDecoder().decode([Task].self, from: data)
            
        }catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
}
