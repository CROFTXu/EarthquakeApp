//
//  EarthquakeInfoCell.swift
//  EarthquakeApp
//
//  Created by xzy on 2024/1/31.
//

import UIKit

class EarthquakeInfoCell: UITableViewCell {
    
    private var statusPointView: UIView!
    private var titleLabel: UILabel!
    private var timeLabel: UILabel!
    private var magLabel: UILabel!
    private var netLabel: UILabel!
    private var seperatorLine: UIView!
    
    var feature: Features? {
        didSet {
            self.setData()
        }
    }
    
    private func setData() {
        if let mag = feature?.properties?.mag {
            if mag >= 7.5 {
                self.statusPointView.backgroundColor = UIColor.red
            } else if mag >= 7 {
                self.statusPointView.backgroundColor = UIColor.orange
            } else if mag >= 6 {
                self.statusPointView.backgroundColor = UIColor.yellow
            } else {
                self.statusPointView.backgroundColor = UIColor.green
            }
            self.magLabel.text = "MagVal: \(mag)"
        } else {
            self.statusPointView.backgroundColor = UIColor.clear
            self.magLabel.text = ""
        }
        
        if let title = feature?.properties?.place {
            self.titleLabel.text = title
        } else {
            self.titleLabel.text = ""
        }
        
        if let time = feature?.properties?.time {
            let timeStr = Date.convertTimestampToDateTime(timestamp: time)
            self.timeLabel.text = timeStr
        } else {
            self.timeLabel.text = ""
        }

        if let net = feature?.properties?.net {
            self.netLabel.text = "Net: \(net.uppercased())"
        } else {
            self.netLabel.text = ""
        }
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.UIInit()
        
        NSLayoutConstraint.activate([
            self.statusPointView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.statusPointView.heightAnchor.constraint(equalToConstant: 30),
            self.statusPointView.widthAnchor.constraint(equalToConstant: 30),
            self.statusPointView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 50),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            
            self.timeLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.timeLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor),
            self.timeLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 2),
            
            self.magLabel.leadingAnchor.constraint(equalTo: self.timeLabel.leadingAnchor),
            self.magLabel.trailingAnchor.constraint(equalTo: self.timeLabel.trailingAnchor),
            self.magLabel.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: 2),
            
            self.netLabel.leadingAnchor.constraint(equalTo: self.magLabel.leadingAnchor),
            self.netLabel.trailingAnchor.constraint(equalTo: self.magLabel.trailingAnchor),
            self.netLabel.topAnchor.constraint(equalTo: self.magLabel.bottomAnchor, constant: 2),
            
            self.seperatorLine.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            self.seperatorLine.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            self.seperatorLine.topAnchor.constraint(equalTo: self.netLabel.bottomAnchor, constant: 5),
            self.seperatorLine.heightAnchor.constraint(equalToConstant: 0.5),
            self.seperatorLine.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    private func UIInit() {
        self.statusPointView = UIView()
        self.statusPointView.translatesAutoresizingMaskIntoConstraints = false
        self.statusPointView.layer.cornerRadius = 15
        self.contentView.addSubview(self.statusPointView)
        
        self.titleLabel = UILabel()
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.numberOfLines = 0
        self.contentView.addSubview(self.titleLabel)
        
        self.timeLabel = UILabel()
        self.timeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.timeLabel.numberOfLines = 0
        self.contentView.addSubview(self.timeLabel)
        
        self.magLabel = UILabel()
        self.magLabel.translatesAutoresizingMaskIntoConstraints = false
        self.magLabel.numberOfLines = 0
        self.contentView.addSubview(self.magLabel)
        
        self.netLabel = UILabel()
        self.netLabel.translatesAutoresizingMaskIntoConstraints = false
        self.netLabel.numberOfLines = 0
        self.contentView.addSubview(self.netLabel)
        
        self.seperatorLine = UIView()
        self.seperatorLine.translatesAutoresizingMaskIntoConstraints = false
        self.seperatorLine.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        self.contentView.addSubview(self.seperatorLine)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
