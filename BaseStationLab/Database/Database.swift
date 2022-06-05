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
    
    private var realm = try! Realm()
    
    private var writeGroup = DispatchGroup()
    
    
}
