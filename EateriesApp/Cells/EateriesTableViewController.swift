//
//  EateriesTableViewController.swift
//  EateriesApp
//
//  Created by Dev Apps4Selling on 08/01/2019.
//  Copyright © 2019 Dev Apps4Selling. All rights reserved.
//

import UIKit
import CoreData

class EateriesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var fetchResultsController : NSFetchedResultsController<Restaurant>!
    var searchController: UISearchController!
    var filteredResultArray: [Restaurant] = []
    var restaurants : [Restaurant] = []
//        Restaurants(name: "Pet", location: "Воронеж", type: "паназиатская кухня", isVisited: false, image: "0001.jpg"),
//        Restaurants(name: "Sahara", location: "Багдад", type: "азиатская кухня", isVisited: false, image: "0002.jpg"),
//        Restaurants(name: "GrillBar", location: "Нью-Йорк", type: "гриль бар", isVisited: false, image: "0003.png"),
//        Restaurants(name: "Grizzli", location: "Лос-Анджелес", type: "стейк бар", isVisited: false, image: "0004.png"),
//        Restaurants(name: "Ahtung", location: "Самара", type: "бар айтишников", isVisited: false, image: "0005.png"),
//        Restaurants(name: "LoliCafe", location: "Ульяновск, улица Полбина, дом 25", type: "лоли мейд кафе", isVisited: false, image: "0007.jpg")
//    ]
    
    @IBAction func close(segue: UIStoryboardSegue) {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
    }
    
    func filterContentFor(searchText text: String) {
        filteredResultArray = restaurants.filter{ (restaurant) -> Bool in
            return (restaurant.name?.lowercased().contains(text.lowercased()))!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableView.automaticDimension
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController.delegate = self
        }
        do {
            try fetchResultsController.performFetch()
            restaurants = fetchResultsController.fetchedObjects!
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    // MARK: Fetch results controller delegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert: guard let indexPath = newIndexPath else { break }
            tableView.insertRows(at: [indexPath], with: .fade)
        case .delete: guard let indexPath = indexPath else { break }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .update: guard let indexPath = indexPath else { break }
            tableView.reloadRows(at: [indexPath], with: .fade)
        default:
            tableView.reloadData()
        }
        restaurants = controller.fetchedObjects as! [Restaurant]
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredResultArray.count
        }
        return restaurants.count
    }

    func restaurantToDispalyAt(indexPath: IndexPath) -> Restaurant {
        let restaurant: Restaurant
        
        if searchController.isActive && searchController.searchBar.text != "" {
            restaurant = filteredResultArray[indexPath.row]
            
        } else {
             restaurant = restaurants[indexPath.row]
        }
        return restaurant
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EateriesTableViewCell
        
        let restaurant = restaurantToDispalyAt(indexPath: indexPath)
        
        cell.imgView.image = UIImage(data: restaurant.image! as Data)
        cell.imgView.layer.cornerRadius = 12
        cell.imgView.clipsToBounds = true
        cell.nameLabel.text = restaurant.name
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text = restaurant.type
       
        cell.accessoryType = restaurant.isVisited ? .checkmark : .none
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let ac = UIAlertController(title: nil, message: "Выберите действие", preferredStyle: .actionSheet)
//        let callAction = UIAlertAction(title: "Позвонить: +7(8422)111-111\(indexPath.row)", style: .default) {
//            (action: UIAlertAction) -> Void in
//            let alertC = UIAlertController(title: nil, message: "Вызов не может быть совершен", preferredStyle: .alert)
//            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alertC.addAction(ok)
//            self.present(alertC, animated: true, completion: nil)
//        }
//        let isVisitedCafe = self.cafeIsVisited[indexPath.row] ? "Я не был здесь" : "Я был здесь"
//        let isVisited = UIAlertAction(title: isVisitedCafe, style: .default) { (action) in
//            let cell = tableView.cellForRow(at: indexPath)
//            self.cafeIsVisited[indexPath.row] = !self.cafeIsVisited[indexPath.row]
//            cell?.accessoryType = self.cafeIsVisited[indexPath.row] ? .checkmark : .none
//
//        }
//        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
//        ac.addAction(callAction)
//        ac.addAction(isVisited)
//        ac.addAction(cancel)
//
//        present(ac, animated: true, completion: nil)
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            self.cafeIsVisited.remove(at: indexPath.row)
//            self.numbs.remove(at: indexPath.row)
//            self.location.remove(at: indexPath.row)
//            self.type.remove(at: indexPath.row)
//            self.imgView.remove(at: indexPath.row)
//        }
//        tableView.deleteRows(at: [indexPath], with: .bottom)
//    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let share = UITableViewRowAction(style: .default, title: "Поделиться") { (action, indexPath) in
            let defaultText = "Я сейчас в " + self.restaurants[indexPath.row].name!
            if let image = UIImage(data: self.restaurants[indexPath.row].image! as Data) {
                let activityController = UIActivityViewController(activityItems: [defaultText, image], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
        }
        let delete = UITableViewRowAction(style: .default, title: "Удалить") { (action, indexPath) in
            self.restaurants.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
                let objectToDelete = self.fetchResultsController.object(at: indexPath)
                context.delete(objectToDelete)
                
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        share.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        delete.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        
        return [delete, share]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let dvc = segue.destination as! EateryDetailViewController
                dvc.restaurant = self.restaurants[indexPath.row]
            }
        }
    }
    
    
    
}


extension EateriesTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentFor(searchText: searchController.searchBar.text!)
        tableView.reloadData()
    }
}
