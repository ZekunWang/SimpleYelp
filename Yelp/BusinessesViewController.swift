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

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIScrollViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let businessCell = "BusinessCell"
    let businessDetailViewControllerSegueId = "BusinessDetailViewControllerSegueId"
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var mapView: MKMapView!
    
    let yelp_red = UIColor(red:0.69, green:0.02, blue:0.02, alpha:1.0)
    let flipDuration: Double = 1
    var isTable: Bool = true
    var businesses: [Business]!
    var searchBar: UISearchBar!
    var tableRefreshControl: UIRefreshControl!
    
    var isMoreDataLoading = true
    let limit = 20
    var offset = 0
    var searchText = ""
    var loadingMoreView: InfiniteScrollActivityView?
    var locationManger: CLLocationManager!
    var rightBarButton: UIButton!
    
    var selectedBusiness: Business!
    var annotations: [MKPointAnnotation]!
    var location: CLLocation!
    var parameters: [String : AnyObject]!
    var refreshing: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup location manager
        locationManger = CLLocationManager()
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManger.distanceFilter = 200
        locationManger.requestWhenInUseAuthorization()
        
        // Setup right bar button
        rightBarButton = UIButton(type: .custom)
        rightBarButton.setTitle("Map", for: .normal)
        rightBarButton.frame = CGRect(x: 0, y: 0, width: 38, height: 30)
        rightBarButton.addTarget(self, action: #selector(self.onTapDown), for: .touchDown)
        rightBarButton.addTarget(self, action: #selector(self.onTapUpOutside), for: .touchUpOutside)
        rightBarButton.addTarget(self, action: #selector(self.onFlipView), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: rightBarButton)
        
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
        
        // Initialize a search bar and put in navigation view
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        // Refresh control
        tableRefreshControl = UIRefreshControl()
        tableRefreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        tableView.insertSubview(tableRefreshControl, at: 0)
        
        searchBar.delegate = self

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        tableView.register(UINib(nibName: self.businessCell, bundle: nil), forCellReuseIdentifier: self.businessCell)
        
        // Setup map view
        mapView.delegate = self
        
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
        
        annotations = [MKPointAnnotation]()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if AppFilters.hasUpdated {
            onRefresh()
            AppFilters.hasUpdated = false
        }
    }
    
    func onRefresh() {
        refreshing = true
        refreshFilters()
        self.tableView.setContentOffset(CGPoint.zero, animated: true)
        loadDataWithOffset(searchText: self.searchText)
    }
    
    func addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D, business: Business) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = business.name
        return annotation
    }
    
    func goToLocation(location: CLLocationCoordinate2D) {
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(location, span)
        self.mapView.setRegion(region, animated: false)
    }
    
    func clearAnnotations() {
        self.mapView.removeAnnotations(self.mapView.annotations)
        annotations = [MKPointAnnotation]()
    }
    
    func refreshFilters() {
        offset = 0
        
        parameters = [String : AnyObject]()
        parameters["term"] = self.searchText as AnyObject
        parameters["limit"] = limit as AnyObject
        parameters["offset"] = offset as AnyObject
        
        if location == nil {
            return
        }
        
        parameters["ll"] = "\(location.coordinate.latitude),\(location.coordinate.longitude)" as AnyObject
        let filters = AppFilters.instance.parameters
        for (key, value) in filters {
            parameters[key] = value
        }
    }
    
    // MARK - Bar Button
    func onTapDown() {
        rightBarButton.alpha = 0.2
    }
    
    func onTapUpOutside() {
        rightBarButton.alpha = 1
    }
    
    func onFlipView() {
        rightBarButton.alpha = 1
        if (isTable) {
            rightBarButton.setTitle("List", for: .normal)
            UIView.transition(from: tableView, to: mapView, duration: flipDuration, options: UIViewAnimationOptions.transitionFlipFromLeft, completion: nil)
        } else {
            rightBarButton.setTitle("Map", for: .normal)
            UIView.transition(from: mapView, to: tableView, duration: flipDuration, options: UIViewAnimationOptions.transitionFlipFromRight, completion: nil)
        }        
        
        isTable = !isTable
    }
    
    // MARK - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            locationManger.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.location = location
            let span = MKCoordinateSpanMake(0.1, 0.1)
            let region = MKCoordinateRegionMake(location.coordinate, span)
            mapView.setRegion(region, animated: true)
        }
    }

    // MARK - ScrollViewDelegate
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
            } else {
                self.loadingMoreView!.stopAnimating()
            }
        }
    }
    
    func loadDataWithOffset(searchText: String) {
        if location == nil {
            self.tableRefreshControl.endRefreshing()
            self.loadingMoreView!.stopAnimating()
            return
        }
        
        parameters["term"] = self.searchText as AnyObject
        parameters["offset"] = self.offset as AnyObject
        
        Business.searchWithTerm(parameters, completion: { (newBusinesses: [Business]?, error: Error?) -> Void in
            self.loadingMoreView!.stopAnimating()
            
            if newBusinesses == nil {
                return
            }
            
            if self.refreshing {
                self.businesses = newBusinesses
                self.refreshing = false
            } else {
                self.businesses.append(contentsOf: newBusinesses!)
            }
            
            self.offset += self.limit
            self.isMoreDataLoading = false
            self.tableView.reloadData()
            
            self.clearAnnotations()
            
            for i in 0 ..< self.businesses.count {
                let business = self.businesses[i]
                if business.coordinate.count == 2 {
                    let centerLocation = CLLocationCoordinate2D(latitude: business.coordinate[0], longitude: business.coordinate[1])
                    let annotation = self.addAnnotationAtCoordinate(coordinate: centerLocation, business: business)
                    self.annotations.append(annotation)
                    if (i == 0) {
                        self.goToLocation(location: centerLocation)
                    }
                }
            }
            self.mapView.addAnnotations(self.annotations)
            self.tableRefreshControl.endRefreshing()
        })
    }
    
    // MARK - SearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchText = searchBar.text!
        onRefresh()
        searchBar.resignFirstResponder()
    }
    
    // MARK - TableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses.count
        }
        return 0
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") as? MKPinAnnotationView
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            view!.canShowCallout = true
            view!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        var index = -1
        
        for i in 0 ..< annotations.count {
            if self.businesses[i].name == (view.annotation?.title)! {
                index = i
                break
            }
        }
        
        if index >= 0 {
            self.showDetailsForResult(self.businesses[index])
        }
    }
    
    func showDetailsForResult(_ business: Business) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "BusinessDetailViewController") as! BusinessDetailViewController
        controller.business = business
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.businessCell, for: indexPath) as! BusinessCell
        
        cell.business = businesses[indexPath.row]
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedBusiness = businesses[indexPath.row]
        performSegue(withIdentifier: self.businessDetailViewControllerSegueId, sender: tableView)
        
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == self.businessDetailViewControllerSegueId {
            let businessDetailViewController = segue.destination as! BusinessDetailViewController
            businessDetailViewController.business = selectedBusiness
        }
    }
    

}
