//
//  LoadingManager.swift
//  EarthquakeApp
//
//  Created by xzy on 2024/1/31.
//

import Foundation
import UIKit

class LoadingViewManager {
    static let shared = LoadingViewManager()
    private var loadingView: UIView?
    private init() {}
    
    func showLoadingView() {
        self.loadingView = UIView(frame: UIScreen.main.bounds)
        self.loadingView?.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = self.loadingView!.center
        activityIndicator.startAnimating()
        self.loadingView?.addSubview(activityIndicator)
        if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            keyWindow.addSubview(self.loadingView!)
        }
    }
    
    func hideLoadingView() {
        self.loadingView?.removeFromSuperview()
        self.loadingView = nil
    }
}
