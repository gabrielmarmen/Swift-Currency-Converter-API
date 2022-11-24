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
        
        let url = URL(string: "https://api.apilayer.com/exchangerates_data/latest?base=USD&apikey=30ZK03j1Mw4pdlxzG5c5ByhA1lGudvRj")
        
        do {
            print("\(Date.debugTimeStamp) Pulling exchange rates ...")
            let (data, _) =  try await URLSession.shared.data(from: url!)
            let exchangeRates = try JSONDecoder().decode(ExchangeRate.self, from: data)
            let _ = try await exchangeRates.save(on: app.db)
            print("\(Date.debugTimeStamp) Pulled latest exchange rates and updated database.")
            if Environment.get("enableUpdatingExchangeRates") ?? "true" == "true"{
                app.queues.schedule(GetLatestExchangeRateJob(app: app))
                    .at(Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 + 300))
                try app.queues.startScheduledJobs()
                print("\(Date.debugTimeStamp) Next update scheduled at \(Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 + 300).formattedTime)")
            }
        }
        catch {
            app.queues.schedule(GetLatestExchangeRateJob(app: app))
                .at(Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 + 5))
            try app.queues.startScheduledJobs()
            print("\(Date.debugTimeStamp) An error occured while getting latest exchange rates. Error: " + error.localizedDescription)
            print("\(Date.debugTimeStamp) Trying again in 5 seconds ...")
        }
        
        
    }
    
    
    
}
