//
//  AddViewController.swift
//  ToDoRealm
//
//  Created by Paul James on 28.10.2021.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var segmentedControll: UISegmentedControl!
    
    var realmModel = RealmModel()
    var selectedIndex: RealmModel?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedIndex != nil {
            textField.text = selectedIndex?.title
        }
    }
    

    @IBAction func saveButtonTapped(_ sender: Any) {
        
        if selectedIndex == nil {
            //save
            realmModel.title = textField.text!
            realmModel.priority = Int32(segmentedControll.selectedSegmentIndex)
            RealmManager.shared.saveModel(model: realmModel)
            navigationController?.popViewController(animated: true)
            
        } else {
            
            //update
            let results = realm.objects(RealmModel.self)
            if let result = results.first {
                try! realm.write {
                    result.title = textField.text!
                    result.priority = Int32(segmentedControll.selectedSegmentIndex)
                }
            }
            navigationController?.popViewController(animated: true)
        }
    }
}
