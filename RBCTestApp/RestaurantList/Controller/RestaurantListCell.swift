//
//  RestaurantListCell.swift
//  RBCApp
//
//  Created by Visha Shanghvi on 2019-07-28.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import UIKit

class RestaurantListCell: UITableViewCell {

    @IBOutlet weak var ratingContainerView: UIView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        restaurantImage.layer.masksToBounds = true
        restaurantImage.layer.cornerRadius = 10
    }
    
    func configureRating(ratingValue: Double) {
        let ratingView =  Rating.create(ratingValue: ratingValue )
        ratingContainerView.addConstraintSubview(ratingView)
    }
    
}
