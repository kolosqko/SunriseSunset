//
//  GooglePlacesManager.swift
//  SunriseSunset
//
//  Created by Kolos on 1/25/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import Foundation

class GooglePlacesManager {
    
    private let key = "AIzaSyATmJrmL0nLUp5uZvzzCeZLV7nWIE1yvFw"
    private let timeZimeKey = "AIzaSyDq5hWky2YGA_YWkTlVLZyPScyXTAkH9Es"
    
    func findCity(text: String,
                  onSucces: @escaping (GooglePlaceInfo) -> (),
                  onFailure: @escaping (String) -> ()) {
        guard let urlString = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(text)&key=\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            onFailure("Failed URL")
            return
        }
        guard let url = URL(string: urlString) else {
            onFailure("Failed URL")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, resopnse, error) in
            if error != nil {
                onFailure(error?.localizedDescription ?? "URLSession error")
                return
            }
            guard let data = data else {
                onFailure("No data")
                return
            }
            guard let result = try? JSONDecoder().decode(GooglePlaceInfo.self, from: data) else {
                onFailure("Error: Couldn't parse json")
                return
            }
            onSucces(result)
        }
        task.resume()
    }
    
    func getTimeZone(latitude: Float,
                     longitude: Float,
                     onSucces: @escaping (TimeZoneModel) -> (),
                     onFailure: @escaping (String) -> ()) {
        let strURL = "https://maps.googleapis.com/maps/api/timezone/json?location=\(String(format:"%f", latitude)),\(String(format:"%f", longitude))&timestamp=1331766000&key=\(timeZimeKey)"
        guard let url = URL(string: strURL) else {
            onFailure("Failed URL")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, resopnse, error) in
            if error != nil {
                onFailure(error?.localizedDescription ?? "URLSession error")
            }
            guard let data = data else {
                onFailure("no data")
                return
            }
            guard let result = try? JSONDecoder().decode(TimeZoneModel.self, from: data) else {
                onFailure("Error: Couldn't parse json")
                return
            }
            if result.status != "OK" {
                onFailure(result.status)
                return
            }
            onSucces(result)
        }
        task.resume()
    }
}
