//
//  AddTripViewController.swift
//  Itinerary
//
//  Created by MAK on 6/15/19.
//  Copyright © 2019 MAK. All rights reserved.
//
import Photos
import UIKit

class AddTripViewController: UIViewController {

    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var tripTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    var tripIndexToEdit: Int?
    
    var doneSaving: (() -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLable.font = UIFont(name: Theme.mainFontName, size: 26)
        imageView.layer.cornerRadius = 10
        
        //Dropshadow on title
        titleLable.layer.shadowOpacity = 1
        titleLable.layer.shadowColor = UIColor.white.cgColor
        titleLable.layer.shadowOffset = CGSize.zero
        titleLable.layer.shadowRadius = 5
        
        if let index = tripIndexToEdit{
            let trip = Data.tripModels[index]
            tripTextField.text = trip.title
            imageView.image = trip.image
            titleLable.text = "Edit Trip"
        }
    }
    @IBAction func cacel(_ sender: Any) {
        view.endEditing(true)
        dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        view.endEditing(true)
        tripTextField.rightViewMode = .never
        
        guard tripTextField.hasValue, let nameTrip = tripTextField.text else {
            return
        }
        
        if let index = tripIndexToEdit{
            TripFunctions.updateTrip(index: index, title: nameTrip, image: imageView.image)
        } else{
            TripFunctions.createTrip(tripModel: TripModel(title: nameTrip,image: imageView.image))
        }
        
        if let doneSaving = doneSaving{
            doneSaving()
        }
        dismiss(animated: true)
    }
    
    fileprivate func presentPhotoPickerController() {
        let myPickerController = UIImagePickerController()
        myPickerController.allowsEditing = true
        myPickerController.delegate = self
        myPickerController.sourceType = .photoLibrary
        self.present(myPickerController, animated: true)
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status{
                case .authorized:
                    self.presentPhotoPickerController()
                
                case .notDetermined:
                    if status == PHAuthorizationStatus.authorized{
                        self.presentPhotoPickerController()
                    }
                case .restricted:
                    let alert = UIAlertController(title: "Photo Library Restricted", message: "Photo Library is restricted and cannot be accessed", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default)
                    alert.addAction(okAction)
                    self.present(alert, animated: true)
                case .denied:
                    let alert = UIAlertController(title: "Photo Library Denied", message: "Photo Library is denied and cannot be accessed, Please go to setting and update it", preferredStyle: .alert)
                    let goToSetting = UIAlertAction(title: "go To Setting", style: .default, handler: { (action) in
                        DispatchQueue.main.async {
                            let url = URL(string: UIApplication.openSettingsURLString)
                            UIApplication.shared.open(url!, options: [:])
                        }
                    })
                    let cancel = UIAlertAction(title: "Cancel", style: .cancel)
                    
                    alert.addAction(cancel)
                    alert.addAction(goToSetting)
                    self.present(alert, animated: true)
                @unknown default:
                    break
                }
            }
        }
    }
}

extension AddTripViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage{
            self.imageView.image = image
        }
        else if let image = info[.originalImage] as? UIImage{
            self.imageView.image = image
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}

