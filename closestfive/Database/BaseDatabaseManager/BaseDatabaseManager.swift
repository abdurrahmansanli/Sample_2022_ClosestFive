//
//  BaseDatabaseManager.swift
//  closestfive
//
//  Created by Abdurrahman Şanlı on 22.05.2022.
//

import CoreData

class BaseDatabaseManager {
    
    func getContext(databaseName: String) -> NSManagedObjectContext? {
        let container = NSPersistentContainer(name: databaseName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error, \((error as NSError).userInfo)")
            }
        })
        return container.viewContext
    }
}
