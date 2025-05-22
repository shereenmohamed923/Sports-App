//
//  LastestViewCell.swift
//  SportsApp
//
//  Created by Macos on 21/05/2025.
//

import UIKit

class LastestViewCell: UICollectionViewCell {
    @IBOutlet weak var team1Img: UIImageView!
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var team2Result: UILabel!
    @IBOutlet weak var team1Result: UILabel!
    @IBOutlet weak var team2Text: UILabel!
    @IBOutlet weak var team1Text: UILabel!
    @IBOutlet weak var team2Img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

}
