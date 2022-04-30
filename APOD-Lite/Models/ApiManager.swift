//
//  ApiManager.swift
//  APOD-Lite
//
//  Created by Sae Pasomba on 30/04/22.
//

import Foundation

class ApiManager: ObservableObject {
    @Published var apod: APOD? = nil
    
    func fetchData(date: Date? = nil) {
        let apiKey = "taQSnNzxUQVhkLelLliOuD5gZE2CCjeLxSbck8Eq"
        var mainString = "https://api.nasa.gov/planetary/apod?api_key=\(apiKey)"
        
        if let safeDate = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let targetDate = dateFormatter.string(from: safeDate)
            
            mainString += "&date=\(targetDate)"
        }
        if let url = URL(string: mainString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    
                    if let safeData = data {
                        do {
                            let result = try decoder.decode(APOD.self, from: safeData)
                            DispatchQueue.main.async {
                                self.apod = result
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
        
    }
}
