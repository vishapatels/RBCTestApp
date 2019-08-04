//
//  ViewController.swift
//  RBCApp
//
//  Created by Visha Shanghvi on 2019-07-27.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import UIKit
import Kingfisher

enum SortType: String {

    case ascending = "Ascending"
    case descending = "Descending"
    case rating
}

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var pickerData: [String] = [String]()
    var model = RestaurantListViewModel()
    var sortValue: String?
    var rating: Double = 0.0
    var offset:String = "1"
    var pageIndex: Int = 1
    var isSearching: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.resignFirstResponder()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        showLoadingView()
        tableView.register(
            SectionHeaderView.nib,
            forHeaderFooterViewReuseIdentifier:
            SectionHeaderView.reuseIdentifier
        )
        getRestaurantList(searchText: searchBar.text ?? "delis")
    }
    
    @IBAction func sortButtonTapped(_ sender: Any) {
        
       let optionMenu = UIAlertController(title: nil, message: "Choose Sorting Option", preferredStyle: .actionSheet)
        let ascendingAction = UIAlertAction(title: "Ascending", style: .default){ action -> Void in
            self.model.sortRestaurantList(sortValue: .ascending)
            self.tableView.reloadData()
        }
        
        let descendingAction = UIAlertAction(title: "Descending", style: .default){ action -> Void in
            self.model.sortRestaurantList(sortValue: .descending)
            self.tableView.reloadData()
        }
        
        let ratingAction = UIAlertAction(title: "By Ratings", style: .default){ action -> Void in
            self.model.sortRestaurantList(sortValue: .rating)
            self.tableView.reloadData()
        }
        
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        optionMenu.addAction(ascendingAction)
        optionMenu.addAction(descendingAction)
        optionMenu.addAction(ratingAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.numberOfRows
    }

    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: SectionHeaderView.reuseIdentifier)
            as? SectionHeaderView
            else {
                return nil
        }
        let resultText = (searchBar.text == "" ? "delis" : searchBar.text) ?? "delis"
        view.headerLabel.text = "Results : \(resultText)"
        return view
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView,
                   estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantList", for: indexPath) as! RestaurantListCell
        cell.name.text = model.restaurantAtIndex(atIndex: indexPath.row)?.name
        cell.configureRating(ratingValue: model.restaurantAtIndex(atIndex: indexPath.row)?.rating ?? 0.0)
        if let url = URL(string: model.restaurantAtIndex(atIndex: indexPath.row)?.imageURL ?? "NA") {
            cell.restaurantImage.kf.setImage(with: url)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailList: RestaurantDetailViewController
        detailList  = storyboard?.instantiateViewController(withIdentifier: "DetailList") as! RestaurantDetailViewController
        detailList.id = model.restaurantAtIndex(atIndex: indexPath.row)?.id ?? ""
        navigationController?.pushViewController(detailList, animated: true)
    }
  
}



extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        getRestaurantList(searchText: searchBar.text ?? "delis")
    }
}

extension ViewController {
    private func getRestaurantList(searchText: String) {
        let searchTerm  = searchText == "" ? "delis" : searchText
        model.getRestaurantListData(offset: offset, term: searchTerm , completion: { [weak self] (result) in
            self?.removeLoadingView()
            switch result {
            case .success:
                self?.tableView.reloadData()
            case .failure(let err):
                print(err)
            }
        })
        
    }
}


