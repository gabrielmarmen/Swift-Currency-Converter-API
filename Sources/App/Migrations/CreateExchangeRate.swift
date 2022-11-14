//
//  CreateExchangeRate.swift
//  
//
//  Created by Gabriel Marmen on 2022-11-14.
//

import Fluent
import Foundation

struct CreateExchangeRate: Migration {
    func prepare(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        database.schema("exchange_rates")
            .id()
            .field("date_time", .datetime, .required)
            .field("conversion_rates", .dictionary(of: .double), .required)
            .create()
        
    }
    
    func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        database.schema("exchange_rates").delete()
    }
    
    

}
