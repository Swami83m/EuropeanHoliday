//
//  HolidayTableViewCell.swift
//  EuropeanHoliday
//
//  
//

import UIKit

class HolidayTableViewCell: UITableViewCell {
    
    private var date: String?
    private var localName: String?
    private var fixed: Bool?
    
    let dateLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let localNameLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let countryCodeLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fixedLabel: UILabel = {
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
        super.init(style: style, reuseIdentifier: "holidayListTableCell")
        setupViews()
    }
    
    private func setupViews() {
        self.contentView.backgroundColor = UIColor.clear
        self.contentView.clipsToBounds = true
        
        self.contentView.addSubview(dateLable)
        dateLable.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        dateLable.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        
        self.contentView.addSubview(nameLable)
        nameLable.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        nameLable.topAnchor.constraint(equalTo: self.dateLable.bottomAnchor, constant: 10).isActive = true
        
        self.contentView.addSubview(fixedLabel)
        fixedLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        fixedLabel.topAnchor.constraint(equalTo: self.nameLable.bottomAnchor, constant: 10).isActive = true
        
        self.selectionStyle = .none
        self.selectedBackgroundView = nil
    }
    
    func setupHolidayInformation(holidayData: GetHolidayListData) {
        dateLable.text = holidayData.date
        fixedLabel.text = "Fixed Holiday: " + holidayData.fixed.map { String($0) }!
        nameLable.text = holidayData.name
    }
}
