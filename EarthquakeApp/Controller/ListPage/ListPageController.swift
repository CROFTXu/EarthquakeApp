//
//  ListPageController.swift
//  EarthquakeApp
//
//  Created by xzy on 2024/1/31.
//

import UIKit

class ListPageController: UIViewController {
    
    private var tableView: UITableView!
    private var refreshBtn: UIBarButtonItem!
    private var viewModel = ListPageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.UIInit()
        self.viewModel.freshData()
        // receive data update callback
        self.viewModel.onDataUpdate = { [weak self] (shouldUpdate, error) in
            if shouldUpdate {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func UIInit() {
        self.view.backgroundColor = UIColor.white
        // set title
        self.navigationItem.title = "Earthquake Info"
        // add refresh btn
        self.refreshBtn = UIBarButtonItem(title: "refresh", style: .plain, target: self, action: #selector(clickRefreshBtnAction))
        self.navigationItem.setRightBarButton(self.refreshBtn, animated: false)
        
        //init tableview
        self.tableView = UITableView(frame: self.view.bounds, style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(EarthquakeInfoCell.self, forCellReuseIdentifier: "cell")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44
        self.tableView.separatorStyle = .none
        self.view.addSubview(self.tableView)
    }
                                          
    @objc private func clickRefreshBtnAction() {
        self.viewModel.freshData()
    }

}

extension ListPageController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let features = self.viewModel.features {
            return features.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let feature = self.viewModel.features?[indexPath.row] {
            let mapVC = MapPageController()
            mapVC.feature = feature
            self.navigationController?.pushViewController(mapVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! EarthquakeInfoCell
        cell.selectionStyle = .none
        if let feature = self.viewModel.features?[indexPath.row] {
            cell.feature = feature
        }
        
        return cell
    }
    
}
