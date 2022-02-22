//
//  Networking.swift
//  TConverter
//
//  Created by Vladislav Tuleiko on 17.02.22.
//

import Foundation

//MARK: - Delegate Protocol
protocol NetworkingDelegate: class {
    func currencyDelegate (_: Networking, with currencyData: Currency)
    func alertDelegate( errorDescription: String)
}

//MARK: - Networking
class Networking {
    
    let apiKey: String = "533432a7abdb96a5147688fbd03de37d"
    var currencyData = Currency()
    weak var delegateFor: NetworkingDelegate?
    
    func networking() {
        let url = URL(string: "http://api.exchangeratesapi.io/v1/latest?access_key=\(apiKey)")
        
        if url != nil {
            let session = URLSession.shared
            let task = session.dataTask(with: url!) { data, response, error in
                if error == nil {
                    do {
                        self.currencyData = try JSONDecoder().decode(Currency.self, from: data!)
                        self.delegateFor?.currencyDelegate(self, with: self.currencyData)
                        //print(self.currencyData)
                    } catch {
                        //print(error.localizedDescription)
                        self.delegateFor?.alertDelegate(errorDescription: error.localizedDescription)
                    }
                    } else {
                        self.delegateFor?.alertDelegate(errorDescription: error?.localizedDescription ?? "Sorry, we have some problems")
                        //print(error?.localizedDescription)
                        return
                     }
            }
            task.resume()
        }else{
           // print("Incorrect url")
            self.delegateFor?.alertDelegate(errorDescription: "URL not found")
        }
    }
}
