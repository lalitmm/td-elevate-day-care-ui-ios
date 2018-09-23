//
//  ServicesManager.swift
//  services
//
//  Created by Akhlaq Rao on 9/22/18.
//  Copyright © 2018 BMO. All rights reserved.
//

import Foundation

class ServicesManager{
    
    static let shared = ServicesManager()
    
    //var services:[Service]
    
    init(){}
    
    func getServices(_ completionHandler: @escaping  (([Service]?, NSError?) -> Void)){
        // Set up the URL request
        let todoEndpoint: String = "https://smartcommunities.cfapps.io/getAllData"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /getAllData")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            let services = self.servicesWithJSON(responseData)
            if nil == services {
                completionHandler(nil, NSError(domain: "Error: did not receive data", code: 0, userInfo: nil))
            } else {
                completionHandler(services!, nil)
            }
        }
        task.resume()
    }
    
    func getChildCareService(_ completionHandler: @escaping  (([Artwork]?, NSError?) -> Void)){
        // Set up the URL request
        let todoEndpoint: String = "https://smartcommunities.cfapps.io/availability"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /availability")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            let childCareservice = self.childCareServiceWithJSON(responseData)
            if nil == childCareservice {
                completionHandler(nil, NSError(domain: "Error: did not receive data", code: 0, userInfo: nil))
            } else {
                completionHandler(childCareservice!, nil)
            }
        }
        task.resume()
    }

    func childCareServiceWithJSON(_ optionalData: Data?) -> [Artwork]? {
        //try to parse the data
        guard
            let data = optionalData,
            // 2
            let json = try? JSONSerialization.jsonObject(with: data),
            // 3
            let works = json as? [[String: AnyObject]]
            // 4
            //let works = dictionary["data"] as? [[Any]]
            else { return nil }
        
        var artWorks = [Artwork]()
        
        for artWork in works {
            let arts = Artwork(json: artWork)
            artWorks.append(arts!)
        }
        
        return artWorks
    }
    
    func servicesWithJSON(_ data: Data) -> [Service]? {
        
        //try to parse the data
        do {
            
            if let rootJSON = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [[String:AnyObject]] {
                
                var services = [Service]()
                
                for serviceDict in rootJSON {
                    
                    let service = Service.map(serviceDict)
                    services.append(service)
                }
                
                return services
            }
        } catch {
            
            print("error trying to convert data to JSON")
            return nil
            
        }
        
        return nil
    }
}
