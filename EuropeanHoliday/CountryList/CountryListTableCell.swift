//
//  CountryListTableCell.swift
//  EuropeanHoliday
//
//  
//

import UIKit

class CountryListTableCell: UITableViewCell {
    
   private var countryTitle: String?
   private let headingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "countryTableViewCell")
        setupViews()
    }
    
    private func setupViews() {
        self.contentView.backgroundColor = UIColor.clear
        self.contentView.clipsToBounds = true
        
        self.contentView.addSubview(headingLabel)
        headingLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        headingLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        
        self.selectionStyle = .none
        self.selectedBackgroundView = nil
    }
    
    func setupCountryInformation(countryData: GetCountryListData) {
        self.countryTitle = countryData.countryName
        headingLabel.text = self.countryTitle
    }

}
