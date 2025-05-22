//
//  DataHandle.swift
//  SportsApp
//
//  Created by Macos on 21/05/2025.
//

import Foundation

protocol DataHandling{
    func getData(data:[String:Any])
    func showError(error: Error)
}
