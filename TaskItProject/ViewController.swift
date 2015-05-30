//
//  ViewController.swift
//  TaskItProject
//
//  Created by Adriel Carsete on 5/27/15.
//  Copyright (c) 2015 Adriel Carsete. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchedResultsController = getFetchedResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
 
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showTaskDetail" {
            let detailVC:TaskDetailViewController = segue.destinationViewController as! TaskDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            let thisTask = fetchedResultsController.objectAtIndexPath(indexPath!) as! TaskModel
            detailVC.detailTaskModel = thisTask
           
            
        }
        else if (segue.identifier == "showTaskAdd") {
            let addTaskVC:AddTaskViewController = segue.destinationViewController as! AddTaskViewController
            
            
        }
    }
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
        
    }
    
    
    //TABLE VIEW DATA SOURCE
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return fetchedResultsController.sections!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let taskElement = fetchedResultsController.objectAtIndexPath(indexPath) as! TaskModel
        
        
        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as! TaskCell
        
        cell.taskLabel.text = taskElement.task
        cell.descriptionLabel.text = taskElement.subtask
        cell.dateLabel.text = Date.toString(date: taskElement.date)

        return cell
    }
    
    
    //TABLE VIEW DELEGATE
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("showTaskDetail", sender: indexPath)
 
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "To do"
        }
        else {
            return "Completed"
        }
    }
    //SWIPE FUNC
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as! TaskModel
        
        if indexPath.section == 0 {
            thisTask.iscompleted = true
    
        }
        else {
            thisTask.iscompleted = false
            
        }
        (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext() // save changes
    }
    
    //NSFetchedResultsControllerDelegate
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    //HELPER
    func taskFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        let completedDescriptor = NSSortDescriptor(key: "iscompleted", ascending: true)
        
        fetchRequest.sortDescriptors = [completedDescriptor, sortDescriptor]
        
        return fetchRequest
        
    }
    
    func getFetchedResultsController() -> NSFetchedResultsController {
        fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "iscompleted", cacheName: nil)
        return fetchedResultsController
    }
    
}

