//
//  File.swift
//  SportsApp
//
//  Created by Macos on 19/05/2025.
//

import Foundation
import Alamofire

protocol Fetchable{
    func fetchData(sport:Sport, endpoint:Endpoint, addOn: String, completion: @escaping ([[String : Any]]?, Error?) -> Void)
}

class NetworkService: Fetchable{
    func fetchData(sport: Sport, endpoint: Endpoint, addOn: String="", completion: @escaping ([[String : Any]]?, Error?) -> Void) {
        let url = "https://apiv2.allsportsapi.com/"+sport.data+endpoint.data+"&APIkey="+api+addOn
        AF.request(url).responseJSON{ response in
            switch response.result {
                case .success(let value):
                    if let dict = value as? [String: Any],
                       let result = dict["result"] as? [[String: Any]] {
                        completion(result, nil)
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Response is not a dictionary"])
                        completion(nil,(error))
                    }
                case .failure(let error):
                    completion(nil,(error))
            }
        }

    }
    
    
    private let api="ac1b0f4d9b0422c8b9ff75a77b912aa88f43c594e2f695c29af83c8460f4e205"

    
    
}
