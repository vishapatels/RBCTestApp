//
//  RestaurantListViewModelTests.swift
//  RBCAppTests
//
//  Created by Visha Shanghvi on 2019-08-02.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import XCTest

@testable import RBCTestApp

class RestaurantListViewModelTests: XCTestCase {
    
    
    func testViewmodel() {
        // Given a viewModel
        var viewModel: RestaurantListViewModel = RestaurantListViewModel()
        // When viewmodel restaurantList is Empty
        // Then number of Rows return will be 0
        XCTAssertEqual(viewModel.numberOfRows, 0)
        // Then restaruantIndex in nil
        XCTAssertNil(viewModel.restaurantAtIndex(atIndex: 0))
        
        viewModel.restaurantListArray = [RestaurantListDataProvider(name: "TimHortons", imageURL: "", id: "E8RJkjfdcwgtyoPMjQ_Olg", rating: 4.5), RestaurantListDataProvider(name: "CoffeeTime", imageURL: "", id: "E8RJkjfdcwgtyoPMjQ_Olk", rating: 4.0),RestaurantListDataProvider(name: "Timothy", imageURL: "", id: "E8RJkjfdcwgtyoPMjQ_Oll", rating: 2.0)]
        viewModel.restaurantList = viewModel.restaurantListArray
        XCTAssertEqual(viewModel.numberOfRows, 3)
        
        XCTAssertEqual(viewModel.restaurantAtIndex(atIndex: 0)?.name ?? "", "TimHortons")
        XCTAssertEqual(viewModel.restaurantAtIndex(atIndex: 1)?.name ?? "", "CoffeeTime")
        
        
        viewModel.sortRestaurantList(sortValue: SortType.ascending)
        XCTAssertEqual(viewModel.restaurantAtIndex(atIndex: 0)?.name ?? "", "CoffeeTime")
        
        viewModel.sortRestaurantList(sortValue: SortType.descending)
        XCTAssertEqual(viewModel.restaurantAtIndex(atIndex: 0)?.name ?? "", "Timothy")
        
        viewModel.sortRestaurantList(sortValue: SortType.rating)
        XCTAssertEqual(viewModel.restaurantAtIndex(atIndex: 0)?.name ?? "", "TimHortons")
        
    }
    
}
