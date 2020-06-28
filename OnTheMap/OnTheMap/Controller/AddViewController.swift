//
//  AddViewController.swift
//  OnTheMap
//
//  Created by Rahaf Naif on 27/10/1441 AH.
//  Copyright © 1441 Rahaf Naif. All rights reserved.
//


import UIKit
import CoreLocation

class AddViewController :UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var link: UITextField!
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationText.delegate = self
        link.delegate = self
        
        
    }
    
    @IBAction func findLocation(_ sender: Any) {
        self.setFindLocation(tapped: true)
        guard locationText.text != "" ,  link.text != "" else {
            showFailure(title:"Error",message: "you should fill the location and the link textFields!")
            self.setFindLocation(tapped: false)
            return
        }
        
        ConfirmLocationViewController.locationInfo.location = self.locationText.text!
        ConfirmLocationViewController.locationInfo.link = self.link.text!
        
        CLGeocoder().geocodeAddressString((locationText.text)!) { (placemarks, error) in
           guard let placemarks = placemarks else {
              DispatchQueue.main.async {
                self.showFailure(title :"Geocder Error",message: "Error finding location!")
                self.setFindLocation(tapped: false)
              }
           return
           }
           let placemark = placemarks.first
           let latitude = placemark?.location?.coordinate.latitude
           let longitude = placemark?.location?.coordinate.longitude
           
            ConfirmLocationViewController.locationInfo.lat = latitude!
            ConfirmLocationViewController.locationInfo.long = longitude!
            
           DispatchQueue.main.async {
            self.setFindLocation(tapped: false)
              self.performSegue(withIdentifier: "completeLocationSegue", sender: self)
           }
        }
        
        
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showFailure(title:String,message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: false, completion:nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
    func setFindLocation(tapped : Bool){
        if tapped{
            activityIndicator.startAnimating()
        }else {
            activityIndicator.stopAnimating()
        }
        locationText.isEnabled = !tapped
        link.isEnabled = !tapped
        findButton.isEnabled = !tapped
        
    }
    
}
