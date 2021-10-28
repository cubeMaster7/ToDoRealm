//
//  CustomTableViewCell.swift
//  ToDoRealm
//
//  Created by Paul James on 28.10.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var readyButton: UIButton!
    
    //для активации кнопки
    weak var cellTaskDelegate: PressReadyTaskButtonProtocols?
    var index: IndexPath?
    
    override func awakeFromNib() {
        readyButton.tintColor = .black
        selectionStyle = .none
    }
    
    @IBAction func readyButtonTapped(_ sender: Any) {
        guard let index = index else {return}
        cellTaskDelegate?.readyButtonTapped(indexPath: index)
    }
    
    func configure(model: RealmModel) {
        
        switch model.priority {
        case 1:
            titleLabel.text = "❗️ \(model.title)"
        default:
            titleLabel.text = model.title
        }

        if model.taskReady {
            readyButton.setBackgroundImage(UIImage(systemName: "chevron.down.circle.fill"), for: .normal)
        } else {
            readyButton.setBackgroundImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        }
    }
}
