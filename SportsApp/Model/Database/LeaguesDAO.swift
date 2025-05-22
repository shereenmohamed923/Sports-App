//
//  LeaguesDAO.swift
//  SportsApp
//
//  Created by Macos on 21/05/2025.
//

import CoreData

class LeaguesDAO {

    private let context = CoreDataManager.shared.context

    func saveLeagueToFavorites(league: League) {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "LeagueEntity", into: context)
            entity.setValue(Int64(league.key!), forKey: "key")
            entity.setValue(league.name, forKey: "name")
            entity.setValue(league.img, forKey: "img")
            
            try? context.save()
    }

    func fetchFavoriteLeagues() -> [League] {
        let request = NSFetchRequest<NSManagedObject>(entityName: "LeagueEntity")
           
           if let entities = try? context.fetch(request) {
               return entities.compactMap { entity in
                   guard
                       let key = entity.value(forKey: "key") as? Int64,
                       let name = entity.value(forKey: "name") as? String,
                       let img = entity.value(forKey: "img") as? String
                   else { return nil }
                   
                   return League(key: Int(key), name: name, img: img)
               }
           }
           
           return []
    }

    func deleteLeagueFromFavorites(key: Int) {
        let request = NSFetchRequest<NSManagedObject>(entityName: "LeagueEntity")
            request.predicate = NSPredicate(format: "key == %d", key)
            
            if let results = try? context.fetch(request) {
                for object in results {
                    context.delete(object)
                }
                try? context.save()
            }
    }
}
