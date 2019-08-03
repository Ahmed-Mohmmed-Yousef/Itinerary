//
//  AddDayViewController.swift
//  Itinerary
//
//  Created by MAK on 6/20/19.
//  Copyright © 2019 MAK. All rights reserved.
//

import UIKit

class AddDayViewController: UIViewController {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var subTitleTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var tripIndex: Int! // Need for saving
    var doneSaving: ((DayModel) -> ())?
    var tripModel: TripModel! //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLable.font = UIFont(name: Theme.mainFontName, size: 26)
        
        
       
    }
    @IBAction func cancel(_ sender: Any) {
        view.endEditing(true)
        dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        view.endEditing(true)
        if alreadyExists(datePicker.date) {
            let alert = UIAlertController(title: "Day already Exists", message: "Choose anther date", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true)
            return
        }
        
        let dayModel = DayModel(title: datePicker.date, subTitle: subTitleTextField.text ?? "", data: nil)
        
        DayFunctions.creatDays(tripIndex: tripIndex, dayModel: dayModel)

        
        if let doneSaving = doneSaving{
            doneSaving(dayModel)
        }
        dismiss(animated: true)
    }
    
    
    @IBAction func done(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    func alreadyExists(_ date: Date) -> Bool {
        if tripModel.dayModels.contains(where: { (dayModel) -> Bool in
            return dayModel.title.mediumDate() == date.mediumDate()
        }){
            return true
        }
        return false
    }
    
}
