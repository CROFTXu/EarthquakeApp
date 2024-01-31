//
//  ListPageViewModel.swift
//  EarthquakeApp
//
//  Created by xzy on 2024/1/31.
//

import Foundation

class ListPageViewModel {
    
    /// feature data array
    var features: [Features]?
    
    /// define a closure to notice vc refresh the tableview
    var onDataUpdate: ((Bool, NetworkError?) -> ())?
    
    init() {
        // read cache from disk
        if let data = UserDefaults.standard.data(forKey: "DataCache") {
            do {
                let decoder = JSONDecoder()
                decoder.dataDecodingStrategy = .base64
                let response = try decoder.decode(Response.self, from: data)
                if let features = response.features {
                    self.features = features
                    self.onDataUpdate?(true, nil)
                } else {
                    self.onDataUpdate?(false, .invalidData)
                }
            } catch {
                
            }
        }
    }
    
    /// vc can call this to refresh data
    func freshData() {
        self.requestFeaturesData()
    }
    
    /// make as a private function
    /// set another public function that vc can use
    private func requestFeaturesData() {
        LoadingViewManager.shared.showLoadingView()
        let url = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2023-01-01&endtime=2024-01-01&minmagnitude=7"
        NetworkManager.shared.request(urlString: url, method: .get, success: { data in
            do {
                // save data as cache
                UserDefaults.standard.setValue(data, forKey: "DataCache")
                
                let decoder = JSONDecoder()
                decoder.dataDecodingStrategy = .base64
                let response = try decoder.decode(Response.self, from: data)
                if let features = response.features {
                    self.features = features
                    self.onDataUpdate?(true, nil)
                    LoadingViewManager.shared.hideLoadingView()
                } else {
                    self.onDataUpdate?(false, .invalidData)
                    LoadingViewManager.shared.hideLoadingView()
                }
            } catch {
                self.onDataUpdate?(false, .decodeError)
                LoadingViewManager.shared.hideLoadingView()
            }
        }, failure: { error in
            self.onDataUpdate?(false, error)
            LoadingViewManager.shared.hideLoadingView()
        })
    }
}
