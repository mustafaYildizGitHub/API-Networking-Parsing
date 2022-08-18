//
//  ViewController.swift
//  UITextFieldNetworkingAPIParsing
//
//  Created by mustafa yildiz on 18.08.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    var brain = Brain()
    var city = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brain.delegate = self
        searchTextField.delegate = self
    }
    

}

//MARK: - TextField Delegate Methods

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            city = self.searchTextField.text ?? "Try Again"
            brain.fetchData(cityName: textField.text!)
            textField.endEditing(true)
            textField.text = ""
            textField.placeholder = "Type a city name"
            return true
        }else{
            textField.placeholder = "Type Something"
            return false
        }
    }
    

    
}

extension ViewController: BrainDelegate {
    func updateUI(with: String) {
        DispatchQueue.main.async {
            self.cityNameLabel.text = "\(self.city) \(with) °C"
        }
    }
    
    
}
