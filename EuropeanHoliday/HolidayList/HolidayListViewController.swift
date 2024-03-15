//
//  HolidayListVC.swift
//  EuropeanHoliday
//
//  
//

import UIKit

class HolidayListViewController: UIViewController {
    var countryCode: String?
    var countryName: String?
    private lazy var tableView: UITableView = { [unowned self] in
        $0.dataSource = self
        $0.delegate = self
        $0.separatorColor = UIColor.brown
        $0.bounces = true
        $0.backgroundColor = UIColor.white
        $0.tableFooterView = UIView()
        $0.tableHeaderView = UIView()
        $0.sectionIndexBackgroundColor = .clear
        $0.sectionIndexTrackingBackgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView(frame: .zero, style: .plain))
    
    private let holidayListTableCell = "HolidayTableViewCell"
    private var holidayListViewModel: HolidayListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        tableView.register(HolidayTableViewCell.self, forCellReuseIdentifier: holidayListTableCell)
        tableView.backgroundColor = UIColor.white
        
        holidayListViewModel = HolidayListViewModel.init(viewDelegate: self, selectedCountry: countryCode ?? "")
        holidayListViewModel.getHolidayListfromServer()
        
        setUpNavigationBar()
        
    }
    
    private func setUpNavigationBar() {
        
        let titleView = UILabel()
        titleView.text = countryName
        titleView.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleView.textAlignment = .center
        titleView.lineBreakMode = .byTruncatingTail
        titleView.sizeToFit()
        navigationItem.titleView = titleView
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}

extension HolidayListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 0
        if let holidayCount = holidayListViewModel?.holidayModel.count {
            rowCount = holidayCount
        }
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: holidayListTableCell) as? HolidayTableViewCell else {
            return UITableViewCell()
        }
        cell.accessoryType = UITableViewCell.AccessoryType.none
        if holidayListViewModel.holidayModel.count > 0 {
            let item = holidayListViewModel.holidayModel[indexPath.row]
            cell.setupHolidayInformation(holidayData: item)
        }
        return cell
    }
}

extension HolidayListViewController: HolidayListViewModelDelegate {
    
    func fetchDataFailure(message: String, canRetry: Bool) {
        if canRetry {
            Alert.showAlert(self, message: message,
                            defaultButtonTitle: StringFactory.Actions.retry,
                            cancelable: true, cancelButtonTitle: StringFactory.Actions.cancel) { (action) in
            }
        } else {
            Alert.showAlert(self, message: message)
        }
    }
    
    func updateViewUsingFetchedData() {
        tableView.reloadData()
    }
}
