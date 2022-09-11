//
//  ViewController.swift
//  IP Details
//
//  Created by Preetam Beeravelli on 9/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ipTextField: UITextField!
    @IBOutlet weak var ipDisplayLabel: UILabel!
    @IBOutlet weak var cityDisplayLabel: UILabel!
    @IBOutlet weak var regionDisplayLabel: UILabel!
    @IBOutlet weak var countryDisplayLabel: UILabel!
    @IBOutlet weak var locationDisplayLabel: UILabel!
    @IBOutlet weak var postalCodeDisplayLabel: UILabel!
    @IBOutlet weak var timeZoneDisplayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ipTextField.delegate = self
    }

    @IBAction func getDetailsButtonPressed(_ sender: UIButton) {
        
        let enteredText = ipTextField.text?.count
        if enteredText == 0 {
            DispatchQueue.main.async { [self] in
                let alert = UIAlertController(title: "Error", message: "Please enter an IP address before Proceding", preferredStyle: .alert)
                let action = UIAlertAction(title: "Dismiss", style: .default)
                alert.addAction(action)
                present(alert, animated: true)
        }
        }else{
            if let enteredIP = ipTextField.text{
            getDetails(with: enteredIP)
                }
        }
        ipTextField.text = ""
        
    }
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        
        ipDisplayLabel.text = "-"
        cityDisplayLabel.text = "-"
        regionDisplayLabel.text = "-"
        countryDisplayLabel.text = "-"
        locationDisplayLabel.text = "-"
        postalCodeDisplayLabel.text = "-"
        timeZoneDisplayLabel.text = "-"
        
    }
   
    
}
//MARK: - text field delegates

extension ViewController: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if ipTextField.hasText == true{
            getDetails(with: ipTextField.text!)
            view.endEditing(true)
            ipTextField.text = ""
            return true
        }else{
            return false
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        view.endEditing(true)
    }
}
//MARK: - networking


extension ViewController{
    
    func getDetails(with Ip: String){
        
        let urlString = "https://ipinfo.io/\(Ip)/geo"
        let URL = URL(string: urlString)
        if let URL = URL{
            URLSession.shared.dataTask(with: URL) { [self] data, response, error in
                if  data != nil && error == nil{
                    do{
                        if let safeData = data{
                            let fetchedData = try JSONDecoder().decode(Details.self, from: safeData)
                            DispatchQueue.main.async { [self] in
                                ipDisplayLabel.text = fetchedData.ip
                                cityDisplayLabel.text = fetchedData.city
                                regionDisplayLabel.text = fetchedData.region
                                countryDisplayLabel.text = fetchedData.country
                                locationDisplayLabel.text = fetchedData.loc
                                postalCodeDisplayLabel.text = fetchedData.postal
                                timeZoneDisplayLabel.text = fetchedData.timezone
    
                            }
                            
                        }
                        
                    }catch {
                        DispatchQueue.main.async { [self] in
                            let alert = UIAlertController(title: "Error", message: "Please enter correct IP address before Proceding", preferredStyle: .alert)
                            let action = UIAlertAction(title: "Dismiss", style: .default)
                            alert.addAction(action)
                            present(alert, animated: true)
                        }
                        print("Error in decoding data")
                        return
                    }
                }
            }
            .resume()
        }
    }
}
