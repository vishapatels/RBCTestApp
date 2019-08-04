//
//  RestuarantListViewModel.swift
//  RBCApp
//
//  Created by Visha Shanghvi on 2019-07-27.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation
import UIKit

struct RestaurantListDataProvider {
    
    var name: String
    var imageURL: String
    var id: String
    var rating: Double
    
    init(name: String, imageURL: String, id:String, rating: Double ) {
        self.name = name
        self.imageURL = imageURL
        self.id = id
        self.rating = rating
    }
}

class RestaurantListViewModel {
    
    var searchRestaurant = [String]()
    var restaurantList : [RestaurantListDataProvider] = []
    var restaurantListArray :[RestaurantListDataProvider] = []
   
   
    var numberOfRows: Int {
        return restaurantListArray.count
    }
    
    func restaurantAtIndex(atIndex index: Int) -> RestaurantListDataProvider? {
        guard !restaurantListArray.isEmpty, restaurantListArray.count > 0 else { return nil }
        return restaurantListArray[index]
    }
    
    func sortRestaurantList(sortValue: SortType) {
        switch sortValue {
        case .ascending:
            return restaurantListArray.sort(by: { $0.name.lowercased() < $1.name.lowercased() })
        case .descending:
            return restaurantListArray.sort(by: { $0.name.lowercased() > $1.name.lowercased() })
        case .rating:
            return restaurantListArray.sort(by: { $0.rating > $1.rating } )
        }
    }
    
}

extension RestaurantListViewModel: ManagerInjected {
    
    func getRestaurantListData(offset:String, term:String, completion complete: @escaping(ServiceResult<Bool>) -> Void) {
        restaurantListManager.getRestaurantList(offset: "1", term: term) { result in
            switch result {
            case .success(let restaurantList):
                self.restaurantListArray = restaurantList
                complete(.success(true))
            case .failure(let error):
                complete(.failure(.invalidResponse))
            }
        }
    }
}

extension Collection where Element == RestaurantListDataProvider {
    
    func search(text: String) -> [RestaurantListDataProvider] {
        return filter { restaurantData in
            return restaurantData.name.lowercased().contains(text.lowercased())
        }
    }
}
