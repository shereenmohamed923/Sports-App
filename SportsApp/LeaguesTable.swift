//
//  LeaguesTable.swift
//  SportsApp
//
//  Created by Macos on 19/05/2025.
//

import UIKit

class LeaguesTable: UITableView {
        
    @IBOutlet weak var LeaguesTableView: UITableView!
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibFile()
    }
    
    func loadNibFile(){
        Bundle.main.loadNibNamed("LeaguesTable", owner: self)
        self.addSubview(LeaguesTableView)
        LeaguesTableView.frame = self.bounds
        LeaguesTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    
}
