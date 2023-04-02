//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Vanchinathan AC on 3/23/23.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    var restaurants: [Restaurant] = [
            Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", image: "cafedeadend", isFavorite: false),
            Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image: "homei", isFavorite: false),
            Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "teakha", isFavorite: false),
            Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", image: "cafeloisl", isFavorite: false),
            Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong", image: "petiteoyster", isFavorite: false),
            Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong", image: "forkee", isFavorite: false),
            Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", image: "posatelier", isFavorite: false),
            Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney", image: "bourkestreetbakery", isFavorite: false),
            Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", image: "haigh", isFavorite: false),
            Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", image: "palomino", isFavorite: false),
            Restaurant(name: "Upstate", type: "American", location: "New York", image: "upstate", isFavorite: false),
            Restaurant(name: "Traif", type: "American", location: "New York", image: "traif", isFavorite: false),
            Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", image: "graham", isFavorite: false),
            Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York", image: "waffleandwolf", isFavorite: false),
            Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", image: "fiveleaves", isFavorite: false),
            Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", image: "cafelore", isFavorite: false),
            Restaurant(name: "Confessional", type: "Spanish", location: "New York", image: "confessional", isFavorite: false),
            Restaurant(name: "Barrafina", type: "Spanish", location: "London", image: "barrafina", isFavorite: false),
            Restaurant(name: "Donostia", type: "Spanish", location: "London", image: "donostia", isFavorite: false),
            Restaurant(name: "Royal Oak", type: "British", location: "London", image: "royaloak", isFavorite: false),
            Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", image: "cask", isFavorite: false)
    ]
    
    lazy var dataSource = configureDataSource()
    
    // MARK: - UITableViewDelegate leadingSwipeActionConfigurationForRowAt
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if self.dataSource.itemIdentifier(for: indexPath) == nil {
            return UISwipeActionsConfiguration()
        }
        
        let favoriteAction = UIContextualAction(style: .normal, title: ""){(action, sourceView, completionHandler) in
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
            self.restaurants[indexPath.row].isFavorite = !self.restaurants[indexPath.row].isFavorite
            cell.heart.isHidden = !self.restaurants[indexPath.row].isFavorite
            completionHandler(true)
        }
        
        favoriteAction.backgroundColor = UIColor.systemPink
        favoriteAction.image = UIImage(systemName:"heart.fill")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [favoriteAction])
        
        
        return swipeConfiguration
    }
    
    // MARK: - UITableViewDelegate trailingSwipeActionConfigurationForRowAt
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath:IndexPath) -> UISwipeActionsConfiguration? {
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title:"Delete") {
            (action, sourceView, completionHandler) in
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteItems([restaurant])
            self.dataSource.apply(snapshot, animatingDifferences: true)
            completionHandler(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
            let defaultText = "Just Checking in at " + restaurant.name
            let activityController: UIActivityViewController
            
            if let imageToShare =  UIImage(named: restaurant.image) {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            } else {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }
            if let popoverController = activityController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath){
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.frame
                }
            }
            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }
        
        shareAction.backgroundColor = UIColor.systemOrange
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        return swipeConfiguration
    }
    // MARK: - UITableViewDelegate didSelectRowAt
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        if let popoverController = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath){
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.frame
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let reserveAction = UIAlertAction(title: "Reserve", style: .default, handler: { (action: UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: nil, message: "Sorry! Feature not available!", preferredStyle: .actionSheet)
            if let alertPopoverController = alertMessage.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    alertPopoverController.sourceView = cell
                    alertPopoverController.sourceRect = cell.bounds
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default)
            alertMessage.addAction(cancelAction)
            self.present(alertMessage, animated: true)
        })
        let favoriteAction = UIAlertAction(title: "Mark Favorite", style: .default, handler: {
            (action: UIAlertAction!) -> Void in
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
            self.restaurants[indexPath.row].isFavorite = !self.restaurants[indexPath.row].isFavorite
            cell.heart.isHidden = !self.restaurants[indexPath.row].isFavorite
        })
        
        optionMenu.addAction(favoriteAction)
        optionMenu.addAction(reserveAction)
        optionMenu.addAction(cancelAction)
        present(optionMenu, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: false)
    }

    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true

        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.dataSource = dataSource
        tableView.separatorStyle = .none
        var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurants, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    // MARK: - UITableViewDiffableDataSource
    func configureDataSource() -> RestaurantDiffableDataSource {
        let cellIdentifier = "datacell"
        let dataSource = RestaurantDiffableDataSource(
        tableView: tableView, cellProvider: {tableView, indexPath, restaurant in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
            cell.nameLabel?.text = restaurant.name
            cell.thumbnailViewImage?.image = UIImage(named: self.restaurants[indexPath.row].image)
            cell.locationLabel?.text = self.restaurants[indexPath.row].location
            cell.typeLabel?.text = self.restaurants[indexPath.row].type
            cell.heart.isHidden =  self.restaurants[indexPath.row].isFavorite ? false : true
            return cell
        })
        
        return dataSource
    }

}
