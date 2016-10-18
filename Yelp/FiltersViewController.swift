//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Zekun Wang on 10/9/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    var categories: [[String : String]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        categories = yelpCategories()
        
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
        dismiss(animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! SwitchCell
        
        cell.switchLabel.text = categories[indexPath.row]["name"]
        
        return cell
    }
    
    func yelpCategories() -> [[String : String]] {
        return [["name" : "Afghan", "code" : "afghani"],
                ["name" : "African", "code" : "african"],
                ["name" : "American, New", "code" : "newamerican"],
                ["name" : "American, Traditional", "code" : "tradamerican"],
                ["name" : "Arabian", "code" : "arabian"],
                ["name" : "Argentine", "code" : "argentine"],
                ["name" : "African", "code" : "african"],
                ["name" : "African", "code" : "african"],
                ["name" : "African", "code" : "african"],
                ["name" : "African", "code" : "african"],
                ["name" : "African", "code" : "african"],
                ["name" : "African", "code" : "african"],
                ["name" : "African", "code" : "african"],
                ["name" : "African", "code" : "african"],
                ["name" : "African", "code" : "african"],
                ["name" : "African", "code" : "african"],
                ["name" : "African", "code" : "african"],
                ["name" : "African", "code" : "african"],
                ["name" : "African", "code" : "african"],
                ["name" : "African", "code" : "african"],
                ["name" : "African", "code" : "african"],
                ["name" : "African", "code" : "african"],
                ["name" : "African", "code" : "african"],
                ["name" : "African", "code" : "african"],
                ["name" : "African", "code" : "african"]]
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
