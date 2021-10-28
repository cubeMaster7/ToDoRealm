//
//  RealmModel.swift
//  ToDoRealm
//
//  Created by Paul James on 28.10.2021.
//

import RealmSwift

class RealmModel: Object {
    @Persisted var title: String
    @Persisted var priority: Int32 
    @Persisted var taskReady: Bool = false
}


