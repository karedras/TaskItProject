//
//  AddTaskViewController.swift
//  TaskItProject
//
//  Created by Adriel Carsete on 5/29/15.
//  Copyright (c) 2015 Adriel Carsete. All rights reserved.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {

    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func addTaskButtonPressed(sender: UIButton) {
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let managedObjectContext = appDelegate.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        task.task = taskTextField.text
        task.subtask = subtaskTextField.text
        task.date = dueDatePicker.date
        task.iscompleted = false
        
        appDelegate.saveContext() //save all changes 
        
        var request = NSFetchRequest(entityName: "TaskModel") // request all entities from TASKMODEL
        var error:NSError? = nil
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        for res in results {
            println(res)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
}
