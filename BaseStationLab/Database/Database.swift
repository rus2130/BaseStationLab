//
//  Database.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation
import RealmSwift

class Database {
    static let realmAsyncQueue = DispatchQueue(label: "realmDatabaseQueue", qos: .userInteractive, attributes: .concurrent)
        
    private var writeGroup = DispatchGroup()
    
    public func save(baseStations: [BaseStation], completion: (() -> ())? = nil) {
        Database.realmAsyncQueue.async { [self] in
            let asyncRealm = try! Realm()
            
            do {
                writeGroup.enter()
                try asyncRealm.write {
                    asyncRealm.add(baseStations, update: .modified)
                    writeGroup.leave()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        completion?()
                    }
                }
                writeGroup.wait()
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }
    
    public func getBases(completion: @escaping (Results<BaseStation>)->()) {
        Database.realmAsyncQueue.async {
            let asyncRealm = try! Realm()
            completion(asyncRealm.objects(BaseStation.self))
        }
    }
    
    public func getBasesCount(completion: @escaping (Int) -> ()) {
        Database.realmAsyncQueue.async {
            let asyncRealm = try! Realm()
            completion(asyncRealm.objects(BaseStation.self).count)
        }
    }
}
