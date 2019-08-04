//
//  SectionHeaderView.swift
//  RBCTestApp
//
//  Created by Visha Shanghvi on 2019-08-04.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import UIKit

final class SectionHeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier: String = String(describing: self)
    
    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .red
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    

}
