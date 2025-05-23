//
//  PlayersCollectionViewCell.swift
//  SportsApp
//
//  Created by Macos on 23/05/2025.
//

import UIKit

class PlayersCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var playerNumber: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerPos: UILabel!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            setupCellStyle()
        }

        private func setupCellStyle() {
            contentView.layer.cornerRadius = 15
            contentView.layer.masksToBounds = true
            // Optional: add shadow to cell itself (if desired)
            layer.cornerRadius = 15
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.15
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowRadius = 4
            layer.masksToBounds = false
        }
}
