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
                return "?limit=100"
            case .skip:
                return "&skip=400"
            case .order:
                return "&order=-updatedAt"
            case .uniqueKey:
                return "uniqueKey=1234"
                
            }
        }
    }
    
    class func getRequest(completionHandler: @escaping (StudentLocationList?, Error?) -> Void) {
        
        let url = URL(string: "\(Endpoint.base.url)\(Endpoint.limit.url)\(Endpoint.skip.url)\(Endpoint.order.url)")
        let task = URLSession.shared.dataTask(with: url! ) { data, response, error in
          guard let data = data else {
              completionHandler(nil, error)
              return
          }
          let decoder = JSONDecoder()
          let student = try! decoder.decode(StudentLocationList.self, from: data)
          completionHandler(student , error)
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
        
    }
    
    
    
    
    
}
