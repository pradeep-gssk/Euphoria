//
//  EUDietIndexTableViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/10/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
//import CoreData

class EUDietIndexTableViewController: UITableViewController {

    var selectedTaoist: Taoist = .Earth
//    let context = appDelegate.persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Diet.self))
//        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
//        fetchRequest.predicate = NSPredicate(format: "(taoist = %@)", self.selectedTaoist.rawValue)
//
//        do {
//            let data = try context.fetch(fetchRequest) as? [Diet]
//            print(data)
//
//        } catch {
//            print(error)
//        }
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
