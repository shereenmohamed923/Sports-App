//
//  LeaguesTableViewCell.swift
//  SportsApp
//
//  Created by Macos on 19/05/2025.
//

import UIKit

class LeaguesTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueImage: UIImageView!
    
    @IBOutlet weak var leageName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let horizontalInset: CGFloat = 10
        let verticalInset: CGFloat = 7
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset))
        
        leagueImage.layer.cornerRadius = leagueImage.frame.size.width/2
        leagueImage.layer.borderWidth = 2
        leagueImage.layer.borderColor = UIColor.lightGray.cgColor
        
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 0.3
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
}
