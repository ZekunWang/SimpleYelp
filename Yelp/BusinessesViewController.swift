//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIScrollViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var viewSwitchBarButton: UIBarButtonItem!
    
    let flipDuration: Double = 1
    var isTable: Bool = true
    var businesses: [Business]!
    var searchBar: UISearchBar!
    var tableRefreshControl: UIRefreshControl!
    
    var isMoreDataLoading = false
    let limit = 20
    var offset = 0
    var searchText = ""
    var loadingMoreView: InfiniteScrollActivityView?
    var rightBarButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        
//        rightBarButton = UIButton(type: .custom)
//        rightBarButton.setTitle("Map", for: .normal)
//        rightBarButton.frame = CGRect(x: 0, y: 0, width: 38, height: 30)
//        rightBarButton.addTarget(self, action: #selector(self.onFlipView), for: .touchUpInside)
//        viewSwitchBarButton.customView = rightBarButton
        //let item1 = UIBarButtonItem(customView: rightBarButton)
        
//        rightBarButton = UIButton(type: .custom)
//        rightBarButton.setTitle("Map", for: .normal)
//        rightBarButton.frame = CGRect(x: 0, y: 0, width: 38, height: 30)
//        rightBarButton.addTarget(self, action: #selector(self.onFlipView), for: .touchUpInside)
//        let item1 = UIBarButtonItem(customView: rightBarButton)
        
        //self.navigationItem.setRightBarButtonItems([item1], animated: true)
        
        // Initialize a search bar and put in navigation view
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        searchBar.delegate = self

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        // Setup map view
        let centerLocation = CLLocation(latitude: 37.7833, longitude: -122.4167)
        goToLocation(location: centerLocation)
        
        // Set up infinite scroll loading indicator
        let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.DEFAULT_HEIGHT)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset
        insets.bottom += InfiniteScrollActivityView.DEFAULT_HEIGHT
        tableView.contentInset = insets
        
        // Clear keyboard when scroll
        tableView.keyboardDismissMode = .onDrag

        businesses = [Business]()
        loadDataWithOffset(searchText:searchText)
        
/* Example of Yelp search with more search options specified
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        }
*/
    }
    
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func onFlipView(_ sender: AnyObject) {
        if (isTable) {
            viewSwitchBarButton.title = "List"
//            rightBarButton.setTitle("List", for: .normal)
            UIView.transition(from: tableView, to: mapView, duration: flipDuration, options: UIViewAnimationOptions.transitionFlipFromLeft, completion: nil)
        } else {
            viewSwitchBarButton.title = "Map"
//            rightBarButton.setTitle("Map", for: .normal)
            UIView.transition(from: mapView, to: tableView, duration: flipDuration, options: UIViewAnimationOptions.transitionFlipFromRight, completion: nil)
        }        
        
        isTable = !isTable
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            if (scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                
                // Update position of loadingMoreView, and start loading indicator
                let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.DEFAULT_HEIGHT)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                loadDataWithOffset(searchText: searchText)
            }
        }
    }
    
    func loadDataWithOffset(searchText: String) {
        Business.searchWithTerm(searchText, limit: limit, offset: offset, completion: { (newBusinesses: [Business]?, error: Error?) -> Void in
            self.businesses.append(contentsOf: newBusinesses!)
            
            self.offset += self.limit
            self.loadingMoreView!.stopAnimating()
            self.isMoreDataLoading = false
            self.tableView.reloadData()
        })
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false;
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        
        cell.business = businesses[indexPath.row]
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
