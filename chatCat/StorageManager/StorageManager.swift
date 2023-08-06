//
//  StorageManager.swift
//  chatCat
//
//  Created by admin1 on 6.08.23.
//

import UIKit

protocol StorageManager {
    func set(_ object: [Voices], forKey key: StorageManagerImpl.Keys)
    func get(forKey key: StorageManagerImpl.Keys) -> [Voices]?
}

final class StorageManagerImpl {
    public enum Keys: String {
        case keyVoice
    }
    
    private let userDefault = UserDefaults.standard
    
    private func store(_ object: Any?, key: String) {
        userDefault.set(object, forKey: key)
    }
    
    private func restore(forKey key: String) -> Any? {
        userDefault.object(forKey: key)
    }
}

extension StorageManagerImpl: StorageManager {
    func set(_ object: [Voices], forKey key: Keys) {
        var jsonData: [Data] = []
        object.forEach { i in
            let data = try! PropertyListEncoder().encode(i)
            jsonData.append(data)
        }
        store(jsonData, key: key.rawValue)
    }
    
    func get(forKey key: Keys) -> [Voices]? {
            guard let data = restore(forKey: key.rawValue) as? [Data] else { return nil }
            var element: [Voices] = []
            data.forEach { i in
                let decoded = try! PropertyListDecoder().decode(Voices.self, from: i)
                element.append(decoded)
            }
            return element
        }
}
