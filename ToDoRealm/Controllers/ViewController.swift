//
//  ViewController.swift
//  ToDoRealm
//
//  Created by Paul James on 28.10.2021.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    let localRealm = try! Realm()
    var todos: Results<RealmModel>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "ToDo with Realm"
        navigationController?.navigationBar.tintColor = .black
        
        tableView.delegate = self
        tableView.dataSource = self

        todos = localRealm.objects(RealmModel.self)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        cell.cellTaskDelegate = self
        cell.index = indexPath
        let model = todos[indexPath.row]
        cell.configure(model: model)
        
        return cell
    }
    
}

extension ViewController: PressReadyTaskButtonProtocols {
    func readyButtonTapped(indexPath: IndexPath) {
        let todo = todos[indexPath.row]
        RealmManager.shared.updateReadyButtonTaskModel(task: todo, bool: !todo.taskReady)
        tableView.reloadData()
    }
}

