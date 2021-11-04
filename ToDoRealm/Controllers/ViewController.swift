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
    var taskArray: Results<RealmModel>!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "ToDo на Realm"
        navigationController?.navigationBar.tintColor = .black
        
        tableView.delegate = self
        tableView.dataSource = self

        taskArray = localRealm.objects(RealmModel.self)
    }
}

// MARK: TableView methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        cell.cellTaskDelegate = self
        cell.index = indexPath
        let model = taskArray[indexPath.row]
        cell.configure(model: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editingRow = taskArray[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Не удаляй меня!") { _, _, completionHandler in
            RealmManager.shared.deleteModel(model: editingRow)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editTask" {
            let indexPath = tableView.indexPathForSelectedRow!
            let detailVC = segue.destination as? AddViewController
            detailVC?.selectedIndex = taskArray[indexPath.row]
        }
    }
}

//MARK: checkmark method
extension ViewController: PressReadyTaskButtonProtocols {
    func readyButtonTapped(indexPath: IndexPath) {
        let todo = taskArray[indexPath.row]
        RealmManager.shared.updateReadyButtonTaskModel(task: todo, bool: !todo.taskReady)
        tableView.reloadData()
    }
}

