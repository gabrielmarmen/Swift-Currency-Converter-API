//
//  File.swift
//  
//
//  Created by Gabriel Marmen on 2022-11-17.
//

import Queues
import Vapor

struct GetLatestExchangeRateJob: AsyncScheduledJob {
    let app: Application
    
    func run(context: Queues.QueueContext) async throws {
        
        let url = URL(string: "https://api.apilayer.com/exchangerates_data/latest?base=USD&apikey=IpUgMSLO7llA73jcvjiANZCAgCHsxx7H")
            
        do {
            let (data, _) =  try await URLSession.shared.data(from: url!)
            let exchangeRates = try JSONDecoder().decode(ExchangeRate.self, from: data)
            let _ = try await exchangeRates.save(on: app.db)
            print("\(Date.debugTimeStamp) Pulled latest exchange rates and updated database.")
        }
        catch {
            app.queues.schedule(GetLatestExchangeRateJob(app: app))
                .at(Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 + 300))
            try app.queues.startScheduledJobs()
            print("An error occured while getting latest exchange rates. Error: " + String(describing: error))
        }
        
        app.queues.schedule(GetLatestExchangeRateJob(app: app))
            .at(Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 + 300))
        try app.queues.startScheduledJobs()
    }
    
    
    
}
