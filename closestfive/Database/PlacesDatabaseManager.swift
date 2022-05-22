//
//  PlacesDatabaseManager.swift
//  closestfive
//
//  Created by Abdurrahman Şanlı on 22.05.2022.
//

import CoreData

class PlacesDatabaseManager: BaseDatabaseManager {
    
    private let databaseName = "MainDatabase"
    
    private let entityName = "SavedPlacesResponse"
    
    private let entityDataKey = "data"
    
    func savePlacesResponse(_ newPlacesResponse: PlacesResponse) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(newPlacesResponse)
            guard let context = getContext(databaseName: databaseName) else { return }
            
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
            let savedPlacesResponses = try context.fetch(fetchRequest)
            if let savedPlacesResponse = savedPlacesResponses.last {
                savedPlacesResponse.setValue(data, forKey: entityDataKey)
            } else {
                let savedPlacesResponse = SavedPlacesResponse(context: context)
                savedPlacesResponse.data = data
            }
            try context.save()
        } catch {
            print("Encoding error: (\(error))")
        }
    }
    
    func getPlacesResponse(completion: ((PlacesResponse?) -> Void)) {
        guard let context = getContext(databaseName: databaseName) else { completion(nil); return }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let savedPlacesResponses = try context.fetch(fetchRequest)
            if let savedPlacesResponse = savedPlacesResponses.last,
               let data = savedPlacesResponse.value(forKeyPath: entityDataKey) as? Data {
                let placesResponse = try JSONDecoder().decode(PlacesResponse.self, from: data)
                completion(placesResponse)
            } else {
                completion(nil)
            }
        } catch {
            completion(nil)
        }
    }
}
