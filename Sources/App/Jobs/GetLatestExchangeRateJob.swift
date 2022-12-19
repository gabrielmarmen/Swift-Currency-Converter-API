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
        
        let uri = URI(string: "https://api.apilayer.com/exchangerates_data/latest?base=USD&apikey=30ZK03j1Mw4pdlxzG5c5ByhA1lGudvRj")
        let nextRunDate = Date(timeIntervalSince1970: Date().timeIntervalSince1970 + 300)
        
        do {
            print("\(Date.debugTimeStamp) Pulling exchange rates ...")
            //let (data, _) =  try await URLSession.shared.data(from: url!)
            //let exchangeRates = try JSONDecoder().decode(ExchangeRate.self, from: data)
            let response = try await app.client.get(uri)
            let exchangeRates = try response.content.decode(ExchangeRate.self)
            
           //let exchangeRates = ExchangeRate.exempleExchangeRate
            
            //Manually adding exchangeRates that are pegged to other currencies
            exchangeRates.rates["KID"] = exchangeRates.rates["AUD"]
            exchangeRates.rates["TVD"] = exchangeRates.rates["AUD"]
            exchangeRates.rates["FOK"] = exchangeRates.rates["DKK"]
            
            let _ = try await exchangeRates.save(on: app.db)
            print("\(Date.debugTimeStamp) Pulled latest exchange rates and updated database.")
            if Environment.get("enableUpdatingExchangeRates") ?? "true" == "true"{
                app.queues.schedule(GetLatestExchangeRateJob(app: app))
                    .at(nextRunDate)
                try app.queues.startScheduledJobs()
                print("\(Date.debugTimeStamp) Next update scheduled at \(nextRunDate.formattedTime)")
            }
        }
        catch {
            app.queues.schedule(GetLatestExchangeRateJob(app: app))
                .at(Date(timeIntervalSince1970: Date().timeIntervalSince1970 + 5))
            try app.queues.startScheduledJobs()
            print("\(Date.debugTimeStamp) An error occured while getting latest exchange rates. Error: " + error.localizedDescription)
            print("\(Date.debugTimeStamp) Trying again in 5 seconds ...")
        }
        
        
    }
    
    
    
}
