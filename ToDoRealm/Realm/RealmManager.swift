//
//  RealmManager.swift
//  ToDoRealm
//
//  Created by Paul James on 28.10.2021.
//

import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {
    }
    
    
    //что надо чтобы сохранять?
    
    let localRealm = try! Realm()
    
    
    //scheduleModel
    func saveModel(model: RealmModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func deleteModel(model: RealmModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    
    func updateReadyButtonTaskModel(task: RealmModel, bool: Bool){
        try! localRealm.write {
            task.taskReady = bool
        }
    }
}
