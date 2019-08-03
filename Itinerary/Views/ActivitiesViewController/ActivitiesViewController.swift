//
//  ActivitiesViewController.swift
//  Itinerary
//
//  Created by MAK on 6/17/19.
//  Copyright © 2019 MAK. All rights reserved.
//

import UIKit

class ActivitiesViewController: UIViewController {

    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBtn: FloatingActionBtn!
    var tripId: UUID!
    var tripModel: TripModel?
    var sectionHeaderHight: CGFloat = 0.0
    
    fileprivate func updateTableViewWithTripData() {
        TripFunctions.readTrip(by: tripId) { [weak self] (model) in
            guard let self = self else {return}
            self.tripModel = model
            
            guard let model = model else {return}
            self.title = model.title
            self.backgroundImg.image = model.image
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        updateTableViewWithTripData()
        sectionHeaderHight = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifire)?.contentView.bounds.height ?? 0
    }
    
    @IBAction func addAction(_ sender: AppUIButton) {
        let alert = UIAlertController(title: "Add item", message: "Which like to add?", preferredStyle: .actionSheet)
        let day = UIAlertAction(title: "Day", style: .default,handler: handelDay)
        let activity = UIAlertAction(title: "Activity", style: .default,handler: handelActivity)
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        activity.isEnabled = tripModel!.dayModels.count > 0
        
        alert.addAction(day)
        alert.addAction(activity)
        alert.addAction(cancel)
        alert.popoverPresentationController?.sourceView = sender
        alert.popoverPresentationController?.sourceRect = sender.bounds
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func getTripIndex() -> Int! {
        return Data.tripModels.firstIndex(where: { (tripModel) -> Bool in
            tripModel.id == tripId
        })
    }
    
    func handelDay(action: UIAlertAction){
        let  vc = AddDayViewController.getInstance() as! AddDayViewController
        vc.tripModel = tripModel
        vc.tripIndex = getTripIndex()
        vc.doneSaving = { [weak self] dayModel in
            guard let self = self else {return}
            self.tripModel?.dayModels.append(dayModel)
            let indexArray = [self.tripModel?.dayModels.firstIndex(of: dayModel) ?? 0]
            self.tableView.insertSections(IndexSet(indexArray), with: .automatic)
            
        }
        present(vc, animated: true, completion: nil)
        
    }
    
    func handelActivity(action: UIAlertAction){
        let vc  = AddActivityViewController.getInstance() as! AddActivityViewController
        vc.tripModel = tripModel
        vc.tripIndex = getTripIndex()
        vc.doneSaving = { [weak self] dayIndex, activityModel in
            guard let self = self else {return}
            self.tripModel?.dayModels[dayIndex].activityModels.append(activityModel)
            let row = ((self.tripModel?.dayModels[dayIndex].activityModels.count)!) - 1
            let indexPath = IndexPath(row: row, section: dayIndex)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        present(vc, animated: true, completion: nil)
    }
    
}

extension ActivitiesViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tripModel?.dayModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderHight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dayModel = tripModel?.dayModels[section]
        let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifire) as! HeaderTableViewCell
        cell.setup(model: dayModel!)
        return cell.contentView
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripModel?.dayModels[section].activityModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let activityModel = tripModel?.dayModels[indexPath.section].activityModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ActivityTableViewCell.identifire) as! ActivityTableViewCell
        cell.setup(model: activityModel!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let activityModel = tripModel!.dayModels[indexPath.section].activityModels[indexPath.row]
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, actionPerformed: @escaping (Bool) -> ()) in
            // Perform delete
            let alert  = UIAlertController(title: "Delete Activity", message: "Are you sure you want to delete this activity :\(activityModel.title)", preferredStyle: .alert)
            let delete = UIAlertAction(title: "Delete", style: .default, handler: { (action) in
                ActivityFunctions.deleteActivity(at: self.getTripIndex(), for: indexPath.section, using: activityModel)
                self.tripModel!.dayModels[indexPath.section].activityModels.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                actionPerformed(true)
            })
            let cancel = UIAlertAction(title: "Cancel", style: .cancel,handler: { (action) in
                actionPerformed(false)
            })
            alert.addAction(delete)
            alert.addAction(cancel)
            self.present(alert, animated: true)
            
        }
        delete.image = #imageLiteral(resourceName: "delete")
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, actionPerformed: @escaping (Bool) -> Void) in
            
            let vc = AddActivityViewController.getInstance() as! AddActivityViewController
            vc.tripModel = self.tripModel
            
            // which trip are working with?
            vc.tripIndex = self.getTripIndex()
            
            // which day are we on?
            vc.dayIndexToEdit = indexPath.section
            
            // which Activity are we on?
            vc.activityModelToEdit =  self.tripModel?.dayModels[indexPath.section].activityModels[indexPath.row]
            
            // what do we want after activity is saved?
            vc.doneUpdating = { [weak self] oldDayIndex, newDayIndex, activityModel in
                guard let self = self else {return}
                
                let oldActivityIndex = (self.tripModel?.dayModels[oldDayIndex].activityModels.firstIndex(of: activityModel))!
                
                if oldDayIndex == newDayIndex{
                    // 1. Update the local table date
                    self.tripModel?.dayModels[newDayIndex].activityModels[oldActivityIndex] = activityModel
                    // 2. refresh that row
                    let indexPath = IndexPath(row: oldActivityIndex, section: newDayIndex)
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                    
                } else{
                    // activity move to different
                    
                    // 1. remove activity from local data
                    self.tripModel?.dayModels[oldDayIndex].activityModels.remove(at: oldActivityIndex)
                    
                    // 2. insert activity to new location
                    let lastIndex = (self.tripModel?.dayModels[newDayIndex].activityModels.count)!
                    self.tripModel?.dayModels[newDayIndex].activityModels.insert(activityModel, at: lastIndex)
                    
                    // 3. update table rows
                    tableView.performBatchUpdates({
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                        let insertIndexPath = IndexPath(row: lastIndex, section: newDayIndex)
                        tableView.insertRows(at: [insertIndexPath], with: .automatic)
                    })
                }
            }
            self.present(vc, animated: true)
            actionPerformed(true)
        }
        edit.image = #imageLiteral(resourceName: "edit")
        edit.backgroundColor = UIColor(named: "Edit")
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
    
    
    
}
