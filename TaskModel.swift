//
//  TaskModel.swift
//  TaskItProject
//
//  Created by Adriel Carsete on 5/29/15.
//  Copyright (c) 2015 Adriel Carsete. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel) //creates a bridge that allow to use obj-c later if needed
class TaskModel: NSManagedObject {

    @NSManaged var iscompleted: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var subtask: String
    @NSManaged var task: String

}
