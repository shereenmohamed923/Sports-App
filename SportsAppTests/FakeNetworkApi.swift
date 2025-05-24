//
//  FakeNetworkApi.swift
//  SportsAppTests
//
//  Created by Macos on 24/05/2025.
//

import Foundation

@testable import SportsApp

import Alamofire

class FakeNetworkApi : Fetchable{
    var shouldFail=false
    var mockData: [[String: Any]]?
    var mockError: Error?
    
    func fetchData(sport: Sport, endpoint: Endpoint, addOn: String, completion: @escaping ([[String : Any]]?, Error?) -> Void) {
        if shouldFail{
            completion(nil, mockError)
        }
        else{
            completion(mockData, nil)
        }
        }
    
}
    
    
