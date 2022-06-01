//
//  LatestTableViewController.swift
//  AppLatestPhones
//
//  Created by user214004 on 4/15/22.
//

import UIKit

class LatestTableViewController: UITableViewController
{

  
    var result = [phones]()
    var currentPhoneCollection : [phones]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkService.Shared.fetchDataFromURL{result in
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = "Name: " + result[indexPath.row].phone_name
        cell.detailTextLabel?.text = "Slug: " + result[indexPath.row].slug
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "toDetailLatest"){
    let destination = segue.destination as! DetailsViewController
        destination.phone_name = result[tableView.indexPathForSelectedRow!.row].phone_name
        destination.imageFromURL =  result[tableView.indexPathForSelectedRow!.row].image
    }
    }
    
}

    
    
