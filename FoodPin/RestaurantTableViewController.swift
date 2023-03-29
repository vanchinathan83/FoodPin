//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Vanchinathan AC on 3/23/23.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    var restaurantNames =  [ "Saravana Bhavan", "Arya Bhavan", "Adyar Anandha Bhavan",
                             "Starbucks", "Sangam", "Chick-fil-a", "HopDoddy", "Waffle House",
                             "IHOP", "Denny's", "Dominos", "Biriyani Paradise", "Chennai Cafe",
                             "Chipotle", "Rosa's Cafe", "What a Burger", "Taco Bell", "McDonalds",
                             "Italian Cafe", "Juicey Bar", "El Poyo"
    ]
    
    var favoritedRestaurants = Array (repeating: false, count: 21)
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
    
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkee", "posatelier", "bourkestreetbakery", "haigh", "palomino", "upstate", "traif", "graham", "waffleandwolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "cask"]
    
    
    enum Section {
        case all
    }
    
    lazy var dataSource = configureDataSource()
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        if let popoverController = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath){
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
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
            let cell = tableView.cellForRow(at: indexPath)
            self.favoritedRestaurants[indexPath.row] = true
            cell?.accessoryType = .checkmark
        })
        
        optionMenu.addAction(favoriteAction)
        optionMenu.addAction(reserveAction)
        optionMenu.addAction(cancelAction)
        present(optionMenu, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.dataSource = dataSource
        tableView.separatorStyle = .none
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurantNames, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, String> {
        let cellIdentifier = "favoritecell"
        let dataSource = UITableViewDiffableDataSource<Section, String>(
        tableView: tableView, cellProvider: {tableView, indexPath, restaurantName in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
            cell.nameLabel?.text = restaurantName
            cell.thumbnailViewImage?.image = UIImage(named: self.restaurantImages[indexPath.row])
            cell.locationLabel?.text = self.restaurantLocations[indexPath.row]
            cell.typeLabel?.text = self.restaurantTypes[indexPath.row]
            cell.accessoryType = self.favoritedRestaurants[indexPath.row] ? .checkmark : .none
            return cell
        })
        
        return dataSource
    }

}
