//
//  CoreDataManager.swift
//  SportsApp
//
//  Created by Macos on 20/05/2025.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SportsApp")
        container.loadPersistentStores { _, error in
            if let error = error { print("Error: \(error)") }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
    
}
