//
//  CountryListViewController.swift
//  EuropeanHoliday
//
//  
//

import UIKit

class CountryListViewController: UIViewController, UINavigationControllerDelegate {
    
    private var safeLayout = 20.0
    private var tableRowHeight = 55.0
    private var fontSizeTitle = 28.0
    
    private let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private let headingLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.text = StringFactory.Titles.europeanHoliday
        return label
    }()
    
    private let subHeadingLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.text = "Please select the country to view holidays"
        return label
    }()
    
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
    
   private let countryTableViewCell = "CountryListTableCell"
    
   private  var countryListViewModel: CountryListModelView! {
        didSet {
            countryListViewModel.viewDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        topView.backgroundColor = UIColor.white
        
        view.addSubview(topView)
        if #available(iOS 11.0, *) {
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: safeLayout).isActive = true
        } else {
            topView.topAnchor.constraint(equalTo: view.topAnchor, constant: safeLayout).isActive = true
        }
        
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        topView.addSubview(headingLable)
        headingLable.topAnchor.constraint(equalTo: topView.topAnchor, constant: 15).isActive = true
        headingLable.centerXAnchor.constraint(equalTo: topView.centerXAnchor, constant: 0).isActive = true
        
        topView.addSubview(subHeadingLable)
        subHeadingLable.topAnchor.constraint(equalTo: headingLable.bottomAnchor, constant: 15).isActive = true
        subHeadingLable.centerXAnchor.constraint(equalTo: topView.centerXAnchor, constant: 0).isActive = true
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.topView.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        tableView.register(CountryListTableCell.self, forCellReuseIdentifier: countryTableViewCell)
        
        countryListViewModel = CountryListModelView()
        countryListViewModel.getCountryListFromServer()
    }
    
}

extension CountryListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableRowHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 0
        if let countryCount = countryListViewModel?.countryModel.count {
            rowCount = countryCount
        }
        return  rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: countryTableViewCell) as? CountryListTableCell else {
            return UITableViewCell()
        }
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        if countryListViewModel.countryModel.count > 0 {
            let item = countryListViewModel.countryModel[indexPath.row]
            cell.setupCountryInformation(countryData: item)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCountry = countryListViewModel.countryModel[indexPath.row]
        let holidayViewController = HolidayListViewController()
        holidayViewController.countryName = selectedCountry.countryName
        holidayViewController.countryCode = selectedCountry.countryCode
        
        if let navigationController = self.navigationController {
            navigationController.pushViewController(holidayViewController, animated: true)
        }
        
    }
}

extension CountryListViewController: CountryListVMDelegate {
    
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
