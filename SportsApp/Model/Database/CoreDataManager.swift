////
////  CoreDataManager.swift
////  SportsApp
////
////  Created by Macos on 20/05/2025.
////
//
//import Foundation
//import CoreData
//
//class CoreDataManager {
//    static let shared = CoreDataManager()
//    let persistentContainer: NSPersistentContainer
//
//    private init() {
//        persistentContainer = NSPersistentContainer(name: "SportsApp")
//        persistentContainer.loadPersistentStores { description, error in
//            if let error = error {
//                fatalError("Core Data failed: \(error)")
//            }
//        }
//    }
//
//    var context: NSManagedObjectContext {
//        return persistentContainer.viewContext
//    }
//
//    func saveContext() {
//        if context.hasChanges {
//            try? context.save()
//        }
//    }
//    
//    func saveLeague(_ league: League) {
//            let leagueEntity = LeagueEntity(context: context)
//        leagueEntity.key = league.key
//        leagueEntity.name = league.name
//
//            if let imageUrl = league.img, let url = URL(string: imageUrl) {
//                URLSession.shared.dataTask(with: url) { data, _, _ in
//                    if let imageData = data {
//                        LeaguesEntity = imageData
//                    }
//                    self.saveContext()
//                }.resume()
//            } else {
//                saveContext()
//            }
//        }
//
//        func fetchLeagues() -> [League] {
//            let request: NSFetchRequest<LeaguesEntity> = LeagueEntity.fetchRequest()
//
//            do {
//                let leagueEntities = try context.fetch(request)
//                return leagueEntities.map {
//                    League(key: $0.key, name: $0.name, img: nil)
//                }
//            } catch {
//                print("Failed to fetch leagues: \(error.localizedDescription)")
//                return []
//            }
//        }
//}
