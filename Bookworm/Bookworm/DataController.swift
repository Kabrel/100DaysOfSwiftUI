//
//  DataController.swift
//  Bookworm
//
//  Created by Константин Шутов on 16.09.2023.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name:"Bookworm")
    
    init() {
        container.loadPersistentStores {
            descriptoin, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
