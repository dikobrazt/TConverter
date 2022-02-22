//
//  Networking.swift
//  TConverter
//
//  Created by Vladislav Tuleiko on 17.02.22.
//

import Foundation

protocol NetworkingDelegate: class {
    func currencyDelegate (_: Networking, with currencyData: Currency)
}



class Networking {
    
    weak var delegateForCurrency: NetworkingDelegate?
    let apiKey: String = "533432a7abdb96a5147688fbd03de37d"
    var currencyData = Currency()
    func networking() {
        let url = URL(string: "http://api.exchangeratesapi.io/v1/latest?access_key=\(apiKey)")
        
        if url != nil {
            let session = URLSession.shared
            let task = session.dataTask(with: url!) { data, response, error in
                if error == nil {
                    do {
                        self.currencyData = try JSONDecoder().decode(Currency.self, from: data!)
                        self.delegateForCurrency?.currencyDelegate(self, with: self.currencyData)
                        //dataGlobal = self.currencyData
                        print(self.currencyData)
                        
                    } catch {
                        print("1")
                        print(error.localizedDescription)
                    }
                    }else {
                        print(error?.localizedDescription)
                        return
                     }
            }
            task.resume()
        }else{
            print("Incorrect url")
        }
    }
    
}
