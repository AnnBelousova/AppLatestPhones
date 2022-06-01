//
//  ViewController.swift
//  AppLatestPhones
//
//  Created by user214004 on 4/15/22.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var picker_view: UIPickerView!
    
    var pages = ["Select option" ," Apple Phones", "Latest Phones", "My Preferences"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker_view.dataSource = self
        picker_view.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var rows = 0
        rows = pages.count
        return rows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var title = ""
        title = pages[row]
        return title
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (row == 2) {
            performSegue(withIdentifier: "latest", sender: self)
        }
        if (row == 1) {
            performSegue(withIdentifier: "apple", sender: self)
        }
        if (row == 3){
            performSegue(withIdentifier: "preferences", sender: self)        }
        
    }
}

