//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Zekun Wang on 10/9/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate {

    let switchCell = "SwitchCell"
    let checkCell = "CheckCell"
    let segmentedControllCell = "SegmentedControlCell"
    let headerView = "TableSectionHeader"
    
    @IBOutlet var tableView: UITableView!
    
    var appFilters: AppFilters!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.register(UINib(nibName: self.checkCell, bundle: nil), forCellReuseIdentifier: self.checkCell)
        tableView.register(UINib(nibName: self.switchCell, bundle: nil), forCellReuseIdentifier: self.switchCell)
        tableView.register(UINib(nibName: self.segmentedControllCell, bundle: nil), forCellReuseIdentifier: self.segmentedControllCell)
        tableView.register(UINib(nibName: self.headerView, bundle: nil), forHeaderFooterViewReuseIdentifier: self.headerView)
                
        appFilters = AppFilters.instance
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSearch(_ sender: AnyObject) {
        AppFilters.instance.loadAppFilters(appFilters: appFilters)
        AppFilters.hasUpdated = true
        dismiss(animated: true, completion: nil)
    }

    // MARK - TableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return appFilters.filters.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let filter: Filter = appFilters.filters[section]
        if filter.expanded {
            print("section: \(section) options: \(filter.options.count)")
            return filter.options.count
        } else if filter.type == .single {
            return 1
        } else if filter.type == .multiple {
            return filter.visibleCount + 1
        } else if filter.type == .default {
            print("section: \(section) options: \(filter.visibleCount)")
            return filter.visibleCount
        }
        return filter.options.count
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return appFilters.filters[section].label
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: self.headerView)
        print("header: \(header)")
        let cell = header as! TableSectionHeader
        let title =  self.appFilters.filters[section].label
        
        cell.title = title
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let filter: Filter = self.appFilters.filters[indexPath.section]
        
        print("section: \(indexPath.section) type: \(filter.type)")
        print("options: \(filter.options.count) visibleCount: \(filter.visibleCount), row: \(indexPath.row)")

        switch filter.type {
        case .single:
            print("single")
            let cell = tableView.dequeueReusableCell(withIdentifier: self.checkCell, for: indexPath) as! CheckCell
            cell.expanded = filter.expanded
            if filter.expanded {
                let option: Option! = indexPath.row < filter.options.count ? filter.options[indexPath.row] : nil
                print("option: \(option != nil ? option.label : "nil")")
                cell.option = option
            } else {
                let selectedOption = filter.selectedOption
                let option: Option! = indexPath.row < filter.visibleCount ? filter.options[selectedOption] : nil
                print("option: \(option != nil ? option.label : "nil")")
                cell.option = option
            }
            return cell
        case .multiple:
            print("multiple")
            let cell = tableView.dequeueReusableCell(withIdentifier: self.switchCell, for: indexPath) as! SwitchCell
            if filter.expanded {
                let option: Option! = indexPath.row < filter.options.count ? filter.options[indexPath.row] : nil
                print("option: \(option != nil ? option.label : "nil")")
                cell.option = option
            } else {
                let option: Option! = indexPath.row < filter.visibleCount ? filter.options[indexPath.row] : nil
                print("option: \(option != nil ? option.label : "nil")")
                cell.option = option
            }
            return cell
        default:
            print("default")
            let option: Option! = indexPath.row < filter.options.count ? filter.options[indexPath.row] : nil
            
            if option.type == .segmentedControl {
                let cell = tableView.dequeueReusableCell(withIdentifier: self.segmentedControllCell, for: indexPath) as! SegmentedControlCell
                print("option: \(option != nil ? option.label : "nil")")
                cell.option = option
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: self.switchCell, for: indexPath) as! SwitchCell
                print("option: \(option != nil ? option.label : "nil")")
                cell.indexPath = indexPath
                cell.delegate = self
                cell.option = option
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filter: Filter = self.appFilters.filters[indexPath.section]

        switch filter.type {
        case .single:
            if filter.expanded {
                let previousOption = filter.selectedOption
                let option: Option! = indexPath.row < filter.options.count ? filter.options[indexPath.row] : nil
                if (previousOption != -1) {
                    filter.options[previousOption].selected = false
                }
                option.selected = true
            }
            
            filter.expanded = !filter.expanded
            
            self.tableView.reloadSections(NSMutableIndexSet(index: indexPath.section) as IndexSet, with: .automatic)
        case .multiple:
            var option: Option! = indexPath.row < filter.visibleCount ? filter.options[indexPath.row] : nil
            if filter.expanded {
                option = indexPath.row < filter.options.count ? filter.options[indexPath.row] : nil
            }
            
            if option != nil {
                option.selected = !option.selected
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            } else {
                filter.expanded = true
                self.tableView.reloadSections(NSMutableIndexSet(index: indexPath.section) as IndexSet, with: .automatic)
            }
        default:
            let option: Option! = indexPath.row < filter.options.count ? filter.options[indexPath.row] : nil
            
            if option.type == .switch {
                if indexPath.section == 0 {
                    option.selected = !option.selected
                    filter.expanded = !filter.expanded
                    self.tableView.reloadSections(NSMutableIndexSet(index: indexPath.section) as IndexSet, with: .automatic)
                } else {
                    option.selected = !option.selected
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }
        }
    }
    
    func onSwitchDone(_ switchCell: SwitchCell) {
        if let indexPath = switchCell.indexPath {
            print("section: \(indexPath.section)")
            let filter = appFilters.filters[indexPath.section]
            filter.expanded = !filter.expanded
            self.tableView.reloadSections(NSMutableIndexSet(index: indexPath.section) as IndexSet, with: .automatic)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
