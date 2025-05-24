//
//  LeaguesDAO.swift
//  SportsApp
//
//  Created by Macos on 21/05/2025.
//

import CoreData

class LeaguesDAO {

    private let context = CoreDataManager.shared.context

    func saveLeagueToFavorites(league: League, sport: String) {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "LeagueEntity", into: context)
            entity.setValue(Int64(league.key!), forKey: "key")
            entity.setValue(league.name, forKey: "name")
            entity.setValue(league.img ?? "", forKey: "img")
            entity.setValue(sport, forKey: "sport")
            
            try? context.save()
    }

    func fetchFavoriteLeagues() -> [FavoriteLeague] {
        let request = NSFetchRequest<NSManagedObject>(entityName: "LeagueEntity")
           
           if let entities = try? context.fetch(request) {
               return entities.compactMap { entity in
                   guard
                       let key = entity.value(forKey: "key") as? Int64,
                       let name = entity.value(forKey: "name") as? String,
                       let img = entity.value(forKey: "img") as? String,
                        let sport = entity.value(forKey: "sport") as? String
                   else { return nil }
                   
                   return FavoriteLeague(key: Int(key), name: name, img: img, sport: sport)
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
