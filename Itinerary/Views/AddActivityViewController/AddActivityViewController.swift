//
//  AddActivityViewController.swift
//  Itinerary
//
//  Created by MAK on 6/22/19.
//  Copyright © 2019 MAK. All rights reserved.
//

import UIKit

class AddActivityViewController: UITableViewController {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var dayPicker: UIPickerView!
    @IBOutlet weak var subTitleTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet var activityTypeButtons: [UIButton]!
    
    var doneSaving: ((Int,ActivityModel) -> ())?
    var tripIndex: Int! // Need for saving
    var tripModel: TripModel! // Need for showind days in PickerView
    
    // UPDATE VARs
    var dayIndexToEdit: Int?
    var activityModelToEdit: ActivityModel?
    var doneUpdating: ((Int, Int, ActivityModel) -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLable.font = UIFont(name: Theme.mainFontName, size: 24)
        dayPicker.dataSource = self
        dayPicker.delegate = self
        
        if let dayIndex = dayIndexToEdit, let activityModel = activityModelToEdit{
            // Update Activity : Popup
            titleLable.text = "Eidt Activity"
            
            // Select the day in Picker view
            dayPicker.selectRow(dayIndex, inComponent: 0, animated: true)
            
            // Populate the activity Data
            // TODO: Set the selected Activity Type Button
             activityTypeSelected(activityTypeButtons[activityModel.activityType.rawValue])
            titleTextField.text = activityModelToEdit?.title
            subTitleTextField.text = activityModel.subTitle
        } else{
            // New Activity : Set Default Value
            activityTypeSelected(activityTypeButtons[ActivityType.excursion.rawValue])
        }
    }
    @IBAction func activityTypeSelected(_ sender: UIButton) {
        activityTypeButtons.forEach({$0.tintColor = Theme.accent})
        sender.tintColor = Theme.tint
    }
    
    @IBAction func save(_ sender: UIButton){
        guard titleTextField.hasValue, let newTitel = titleTextField.text else { return }
        let activityType: ActivityType = getSelectedActivityType()
        let newDayIndex = dayPicker.selectedRow(inComponent: 0)
        if activityModelToEdit != nil{
            
            activityModelToEdit?.activityType = activityType
            activityModelToEdit?.title = newTitel
            activityModelToEdit?.subTitle = subTitleTextField.text ?? ""
            ActivityFunctions.updateActivity(at: tripIndex, oldDayIndex: dayIndexToEdit!, newDayIndex: newDayIndex, using: activityModelToEdit!)
            if let doneUpdating = doneUpdating, let oldDayIndex = dayIndexToEdit{
                doneUpdating(oldDayIndex,newDayIndex,activityModelToEdit!)
            }
            
        } else{
            let activityModel = ActivityModel(title: newTitel, subTitle: subTitleTextField.text ?? "", activityType: activityType)
            ActivityFunctions.creatActivity(at: tripIndex, for: newDayIndex, using:activityModel )
            
            if let doneSaving = doneSaving{
                doneSaving(newDayIndex, activityModel)
            }
        }
        
        dismiss(animated: true)
    }
    
    @IBAction func cancel(_ sender: UIButton){
        dismiss(animated: true)
    }
    
    @IBAction func done(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    
    func getSelectedActivityType() -> ActivityType{
        for (index, button) in activityTypeButtons.enumerated(){
            if button.tintColor == Theme.tint{
                return ActivityType(rawValue: index) ?? .excursion
            }
        }
        return .excursion
    }
    
}

extension AddActivityViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tripModel.dayModels.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let day = tripModel.dayModels[row]
        return day.title.mediumDate()
    }
    
}
