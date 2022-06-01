//
//  AppleTableViewController.swift
//  AppLatestPhones
//
//  Created by user214004 on 4/16/22.
//

import UIKit

class AppleTableViewController: UITableViewController {

    var result = [phones]()
    var currentPhoneCollection : [phones]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkService.Shared.fetchDataFromURLApple{result in
                     switch (result) {
                       case .success(let PhoneCollection) :
                            DispatchQueue.main.async {
                                self.currentPhoneCollection = PhoneCollection
                                self.result = PhoneCollection
                                self.tableView.reloadData()
                           }
                            break
                        case .failure(_):
                            break
                        }
            
            }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return result.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellap", for: indexPath) as UITableViewCell
        cell.textLabel?.text = "Name:  " + result[indexPath.row].phone_name
        cell.detailTextLabel?.text = "Slug:  " + result[indexPath.row].slug

        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "toDetailApple"){
    let destination = segue.destination as! AppleDetailsViewController
        destination.phone_name = result[tableView.indexPathForSelectedRow!.row].phone_name
        destination.imageFromURL =  result[tableView.indexPathForSelectedRow!.row].image
    }
    }

}
