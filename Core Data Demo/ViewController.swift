//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Leonardo Schick on 1/27/16.
//  Copyright © 2016 Xicks. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let context : NSManagedObjectContext = appDel.managedObjectContext
        
        var newPerson = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: context)
        
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        
        newPerson.setValue("Peter", forKey: "name")
        newPerson.setValue(23, forKey: "age")
        newPerson.setValue("1234-5678", forKey: "phone")
        newPerson.setValue(dateFormat.dateFromString("10/10/1992")!, forKey: "birthdate")
        
        newPerson = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: context)
        
        newPerson.setValue("John", forKey: "name")
        newPerson.setValue(30, forKey: "age")
        newPerson.setValue("6784-1489", forKey: "phone")
        newPerson.setValue(dateFormat.dateFromString("17/08/1985")!, forKey: "birthdate")
        
        newPerson = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: context)
        
        newPerson.setValue("Samantha", forKey: "name")
        newPerson.setValue(21, forKey: "age")
        newPerson.setValue("8978-1111", forKey: "phone")
        newPerson.setValue(dateFormat.dateFromString("09/12/1994")!, forKey: "birthdate")
        
        save(context)

        var request = NSFetchRequest(entityName: "Person")
        //Returns the objects and not only information about them
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.executeFetchRequest(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    print(result.valueForKey("name")!)
                    print(result.valueForKey("age")!)
                    let birthdate = result.valueForKey("birthdate") as! NSDate
                    print(dateFormat.stringFromDate(birthdate))
                    print(result.valueForKey("phone")!)
                    print("---------------\n")
                }
                
            }
        } catch {
            print("Could not fetch")
        }
        
        request = NSFetchRequest(entityName: "Person")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "name contains %@ OR age > %d", "Sa",23)
        
        do {
            let results = try context.executeFetchRequest(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    print("Fetched Result")
                    print(result.valueForKey("name")!)
                    print(result.valueForKey("age")!)
                    let birthdate = result.valueForKey("birthdate") as! NSDate
                    print(dateFormat.stringFromDate(birthdate))
                    print(result.valueForKey("phone")!)
                    print("---------------\n")
                    
                    result.setValue("Carlos", forKey: "name")
                    
                    save(context)
                }
            }
        } catch {
            print("Could not fetch")
        }
    
        
        request = NSFetchRequest(entityName: "Person")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.executeFetchRequest(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    print("Removing...")
                    print(result.valueForKey("name")!)
                    print(result.valueForKey("age")!)
                    let birthdate = result.valueForKey("birthdate") as! NSDate
                    print(dateFormat.stringFromDate(birthdate))
                    print(result.valueForKey("phone")!)
                    print("---------------\n")
                    context.deleteObject(result)
                    save(context)
                }
                
            }
        } catch {
            print("Could not fetch")
        }
        
    }
    
    func save(context : NSManagedObjectContext) {
        do{
            try context.save()
        } catch {
            print("Could not save")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

