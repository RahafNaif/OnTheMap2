//
//  parseAPI.swift
//  OnTheMap
//
//  Created by Rahaf Naif on 15/10/1441 AH.
//  Copyright © 1441 Rahaf Naif. All rights reserved.
//

import Foundation

class parseAPI {
    
    enum Endpoint {
        case base
        case limit
        case skip
        case order
        case uniqueKey
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
        

        var stringValue: String {
            switch self {
        
            case .base:
                return "https://onthemap-api.udacity.com/v1/StudentLocation"
            case .limit:
                return "https://onthemap-api.udacity.com/v1/StudentLocation?limit=100"
            case .skip:
                return "https://onthemap-api.udacity.com/v1/StudentLocation?limit=200&skip=400"
            case .order:
                return "https://onthemap-api.udacity.com/v1/StudentLocation?order=-updatedAt"
            case .uniqueKey:
                return "https://onthemap-api.udacity.com/v1/StudentLocation?uniqueKey=1234"
                
            }
        }
    }
    
    class func getRequest(_: String, completionHandler: @escaping (StudentLocation?, Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: Endpoint.base.url) { data, response, error in
          guard let data = data else {
              completionHandler(nil, error)
              return
          }
          let decoder = JSONDecoder()
          let student = try! decoder.decode(StudentLocation.self, from: data)
          completionHandler(student , error)
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
        
    }
    
    
    
    
    
}
