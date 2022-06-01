//
//  MyPreferencesTableViewController.swift
//  AppLatestPhones
//
//  Created by user214004 on 4/16/22.
//

import UIKit

class MyPreferencesTableViewController: UITableViewController {
    
    var allPhones : [PhoneEntity] = [PhoneEntity]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //allPhones = CoreDataService.Shared.getAllPhonesFromStorage()
        updateTable()
        
    }

    func updateTable(){
        allPhones = CoreDataService.Shared.getAllPhonesFromStorage()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allPhones.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellpr", for: indexPath)
        cell.textLabel?.text = allPhones[indexPath.row].name
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d yyyy hh:mm"
        let formattedDateInString = formatter.string(from: allPhones[indexPath.row].date.unsafelyUnwrapped)
        cell.detailTextLabel?.text = formattedDateInString
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               let alert = UIAlertController(title: "Are you sure you want to delete this phone?", message: "", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
                   CoreDataService.Shared.deleteMyPref(toDeletePref: self.allPhones[indexPath.row])
                   self.updateTable()
               }))
               alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
               
               present(alert, animated: true)

           }
       }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toImage"){
        let ivc = segue.destination as! imageViewController
            ivc.url = allPhones[tableView.indexPathForSelectedRow!.row].src!
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
