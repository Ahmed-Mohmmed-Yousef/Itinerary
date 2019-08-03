//
//  TripsViewController.swift
//  Itinerary
//
//  Created by MAK on 6/14/19.
//  Copyright © 2019 MAK. All rights reserved.
//

import UIKit

class TripsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var AddButton: FloatingActionBtn!
    @IBOutlet var helpView: UIVisualEffectView!
    @IBOutlet weak var logoImgView: UIImageView!
    var tripIndexToEdit: Int?
    var seenTripHelp = "seenTripHelp"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = Theme.background
        
        // 360 * pi/180
        let radians = CGFloat(200 * Double.pi / 180)
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseIn], animations: {
            self.logoImgView.alpha = 0
            self.logoImgView.transform = CGAffineTransform(rotationAngle: radians).scaledBy(x: 3, y: 3)
            
            let yRoyation = CATransform3DMakeRotation(radians, 0, radians, 0)
            self.logoImgView.layer.transform = CATransform3DConcat(self.logoImgView.layer.transform, yRoyation)
            
        }) { (success) in
            self.getTripData()
        }
        
       
    }
    
    fileprivate func getTripData() {
        TripFunctions.readTrips(completion: { [unowned self] in
            // completion
            
            
            if Data.tripModels.count > 0 {
                if UserDefaults.standard.bool(forKey: self.seenTripHelp) == false {
                    //self.view.addSubview(self.helpView)
                    //self.helpView.frame = self.view.frame
                }
            }
            self.tableView.reloadData()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddTropSegue"{
            let popup = segue.destination as! AddTripViewController
            popup.tripIndexToEdit = tripIndexToEdit
            popup.doneSaving = { [weak self] in
                guard let self = self else {return}
                self.tableView.reloadData()
            }
            tripIndexToEdit = nil
        }
    }
    
    @IBAction func closeHelView(_ sender: AppUIButton) {
        UIView.animate(withDuration: 0.7, animations: {
            self.helpView.alpha = 0
        }) { (success) in
            self.helpView.removeFromSuperview()
            UserDefaults.standard.set(true, forKey: self.seenTripHelp)
        }
    }
    
}


extension TripsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.tripModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TripsTableViewCell.identifire) as! TripsTableViewCell
        cell.setup(tripModel: Data.tripModels[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let trip = Data.tripModels[indexPath.row]
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, actionPerformed: @escaping (Bool) -> ()) in
            // Perform delete
            let alert  = UIAlertController(title: "Delete Trip", message: "Are you sure you want to delete this trip:\(trip.title)", preferredStyle: .alert)
            let delete = UIAlertAction(title: "Delete", style: .default, handler: { (action) in
                TripFunctions.deleteTrip(index: indexPath.row)
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
            self.tripIndexToEdit = indexPath.row
            self.performSegue(withIdentifier: "toAddTropSegue", sender: nil)
            actionPerformed(true)
        }
        edit.image = #imageLiteral(resourceName: "edit")
        edit.backgroundColor = UIColor(named: "Edit")
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trip = Data.tripModels[indexPath.row]
        let vc = ActivitiesViewController.getInstance() as! ActivitiesViewController
        vc.tripId = trip.id
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
