//
//  AppleDetailsViewController.swift
//  AppLatestPhones
//
//  Created by user214004 on 4/16/22.
//

import UIKit

class AppleDetailsViewController: UIViewController, networkingDelegateProtocole {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    var imageFromURL : String = ""
    var phone_name : String = ""
    var phone_slug : String = ""
    var result = [phones]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkService.Shared.getImage(url: imageFromURL)
            { result in
                switch result {
                case .success(let imageFromURL):
                    DispatchQueue.main.async {
                        self.image.image = imageFromURL
                        self.name.text = "Phone name: " + self.phone_name                    }
                   break
               case .failure(_):
                   break
               }        }
    }
                                       
                                       
    
    @IBAction func saveApple(_ sender: Any) {
        let alert = UIAlertController.init(title: "Are You Sure", message: "Do you want to save this phone?", preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { action in
           
            CoreDataService.Shared.insertPhoneIntoCoreData(name: self.phone_name, date: Date.now, url: self.imageFromURL)
            
        }))
        present(alert, animated: true)
        
    }
    
    
    func imageDownloadedCorrectly(image: UIImage) {
        DispatchQueue.main.async {
                               self.image.image = image
                            }
        
    }
    
    func imageDidNotDownloadedCorrectly() {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
