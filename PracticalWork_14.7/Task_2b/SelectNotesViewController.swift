//
//  SelectNotesViewController.swift
//  PracticalWork_14.7
//
//  Created by Alexandr on 25.11.2022.
//

import UIKit
import RealmSwift

class SelectNotesViewController: UITableViewController {

    var items: Results<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        self.items = realm.objects(Item.self)

    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let name = self.items[indexPath.row].name
        cell?.textLabel?.text = name
        return cell!
    }
    @IBAction func addAction(_ sender: Any) {
        let item = Item()
        item.name = "Задача №\(self.items.count + 1)"
        let realm = try! Realm()
        try! realm.write {
            realm.add(item)
        }
        self.tableView.reloadData()
    }
    @IBAction func editAction(_ sender: Any) {
        let edit = !self.tableView.isEditing
        self.tableView.setEditing(edit, animated: true)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let realm = try! Realm()
            let item = self.items[indexPath.row]
            try! realm.write {
                realm.delete(item)
            }
            self.tableView.reloadData()
        }
    }
    
}
