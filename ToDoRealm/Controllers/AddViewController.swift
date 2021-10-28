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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func saveButtonTapped(_ sender: Any) {
    
            realmModel.title = textField.text!
            realmModel.priority = Int32(segmentedControll.selectedSegmentIndex)
            RealmManager.shared.saveModel(model: realmModel)
            
            navigationController?.popViewController(animated: true)
        
    }
    
}
