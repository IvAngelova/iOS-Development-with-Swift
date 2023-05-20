//
//  TableViewController.swift
//  Homework-L6
//
//  Created by Ivy Angelova (Apprentice Mobile, eDynamix Training Programme) on 13/01/2023.
//

import UIKit

class TableViewController: UITableViewController {
    
    let listSightseeing = ["Архитектурно - музеен резерват \"Царевец\"", "Аудио - визуален спектакъл \"Звук и светлина\"", "Църква \"Св. Четиридесет мъченици\"", "АЕК \"Самоводска чаршия\""]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listSightseeing.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        guard listSightseeing.count > indexPath.row else {
            return cell
        }

        cell.textLabel?.text = listSightseeing[indexPath.row]
        cell.tag = indexPath.row

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped at \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "showDetailsSegue", sender: self.tableView.cellForRow(at: indexPath))
    }
    
   
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else{
            return
        }
        
        switch segueIdentifier {
        case "showDetailsSegue":
            guard let destinationController = segue.destination as? DetailsVC else {
                return
            }
            guard let selectedCell = sender as? UITableViewCell else{
                return
            }
            
            destinationController.numberOfRowSelected = selectedCell.tag
        default:
            return
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

  

}
