//
//  Service.swift
//  services
//
//  Created by Akhlaq Rao on 9/22/18.
//  Copyright © 2018 BMO. All rights reserved.
//

import Foundation

struct Service {
    var id:String?
    var name:String?
    
    // MARK: - Object Mapper
    //
    internal static func map(_ dict: [String:Any]) -> Service {
        
        var service = Service()
        
        service.id = dict["service_id"] as? String
        service.name = dict["service_name"] as? String
        
        return service
    }
}
