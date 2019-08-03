//
//  HeaderTableViewCell.swift
//  Itinerary
//
//  Created by MAK on 6/19/19.
//  Copyright © 2019 MAK. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont(name: Theme.bodyFontNameBold, size: 17)
        subTitleLabel.font = UIFont(name: Theme.bodyFontName, size: 17)
    }

    func setup(model: DayModel){
        titleLabel.text = model.title.mediumDate()
        subTitleLabel.text = model.subTitle
    }

}
