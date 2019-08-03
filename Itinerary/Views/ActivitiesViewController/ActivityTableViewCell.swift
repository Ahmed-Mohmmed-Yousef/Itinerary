//
//  ActivityTableViewCell.swift
//  Itinerary
//
//  Created by MAK on 6/19/19.
//  Copyright © 2019 MAK. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var subTiltle: UILabel!
    @IBOutlet weak var activityImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.addShadowAndRoundedCorner()
        titleLable.font = UIFont(name: Theme.bodyFontNameDemiBold, size: 17)
        subTiltle.font = UIFont(name: Theme.bodyFontName, size: 17)
    }

    func setup(model: ActivityModel){
        activityImageView.image = getActivityImageView(type: model.activityType)
        titleLable.text = model.title
        subTiltle.text = model.subTitle
        
    }

    func getActivityImageView(type: ActivityType) -> UIImage {
        
        switch type{
        case .auto:
            return #imageLiteral(resourceName: "car")
        case .excursion:
            return #imageLiteral(resourceName: "excursion")
        case .flight:
            return #imageLiteral(resourceName: "flight")
        case .food:
            return #imageLiteral(resourceName: "food")
        case .hotel:
            return #imageLiteral(resourceName: "hotel")
        }
    }
}
