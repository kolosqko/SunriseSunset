//
//  SunriseSunsetManager.swift
//  SunriseSunset
//
//  Created by Kolos on 1/25/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import Foundation


class SunriseSunsetManager {
    
    private var latitude: Float
    private var longitude: Float
    
    private func getUrl() -> URL? {
        let url = URL(string: "https://api.sunrise-sunset.org/json?lat=\(String(format:"%f", latitude))&lng=\(String(format:"%f", longitude))&formatted=0")
        return url
    }
    
    func getSunriseSunsetInfo(onSucces: @escaping (SunsetSunriseInfo) -> (),
                              onFailure: @escaping (String) -> ()){
        guard let url = getUrl() else {
            onFailure("Error: URL fail")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                onFailure(error?.localizedDescription ?? "Error: URLSession failed")
                return
            }
            guard let data = data else {
                onFailure("Error: Data was not found")
                return
            }
            guard let result = try? JSONDecoder().decode(SunsetSunriseInfo.self, from: data) else {
                onFailure("Error: Couldn't parse json")
                return
            }
            onSucces(result)
        }
        task.resume()
    }
    
    init(latitude: Float, longitude: Float) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
