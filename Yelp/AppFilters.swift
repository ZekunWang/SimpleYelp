//
//  AppFilters.swift
//  Yelp
//
//  Created by Zekun Wang on 10/22/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class AppFilters {
    
    var filters = [
        Filter(
            label: "",
            options: [
                Option(label: "Order Pickup or Delivery", value: "", type: .switch),
                Option(label: "", value: "", type: .segmentedControl)
            ],
            type: .default
        ),
        Filter(
            label: "Most Popular",
            options: [
                Option(label: "Offering a Deal", name: "deals_filter", value: "true", type: .switch),
                Option(label: "Hot and New", value: "", type: .switch),
                Option(label: "Open Now", value: "", type: .switch)
            ],
            expanded: true,
            type: .default
        ),
        Filter(
            label: "Distance",
            name: "radius_filter",
            options: [
                Option(label: "Best Match", value: "40000", selected: true, type: .check),
                Option(label: "0.3 miles", value: "483", type: .check),
                Option(label: "1 mile", value: "1609", type: .check),
                Option(label: "5 miles", value: "8047", type: .check),
                Option(label: "20 miles", value: "32187", type: .check)
            ],
            type: .single
        ),
        Filter(
            label: "Sort by",
            name: "sort",
            options: [
                Option(label: "Best Match", value: "0", selected: true, type: .check),
                Option(label: "Distance", value: "1", type: .check),
                Option(label: "Rating", value: "2", type: .check),
                Option(label: "Most Reviewed", value: "", type: .check)
            ],
            type: .single
        ),
        Filter(
            label: "General Features",
            options: [
                Option(label: "Take-out", value: "", type: .switch),
                Option(label: "Good for Kids", value: "", type: .switch),
                Option(label: "Takes Reservations", value: "", type: .switch),
                Option(label: "Accepts Credit Cards", value: "", type: .switch),
                Option(label: "Outdoor Searting", value: "", type: .switch),
                Option(label: "Good for Groups", value: "", type: .switch),
                Option(label: "Wheelchair Accessible", value: "", type: .switch),
                Option(label: "PokéStop Nearby", value: "", type: .switch),
                Option(label: "Full Bar", value: "", type: .switch),
                Option(label: "Happy Hour", value: "", type: .switch),
                Option(label: "Good for Breakfast", value: "", type: .switch),
                Option(label: "Good for Brunch", value: "", type: .switch),
                Option(label: "Good for Lunch", value: "", type: .switch),
                Option(label: "Good for Dinner", value: "", type: .switch),
                Option(label: "Good for Dessert", value: "", type: .switch),
                Option(label: "Good for Late Night", value: "", type: .switch),
                Option(label: "Free Wi-Fi", value: "", type: .switch)
            ],
            visibleCount: 3,
            type: .multiple
        ),
        Filter(
            label: "Categories",
            name: "category_filter",
            options: [
                Option(label: "Afghan", value: "afghani", type: .switch),
                Option(label: "African", value: "african", type: .switch),
                Option(label: "American (New)", value: "newamerican", type: .switch),
                Option(label: "American (Traditional)", value: "tradamerican", type: .switch),
                Option(label: "Arabian", value: "arabian", type: .switch),
                Option(label: "Argentine", value: "argentine", type: .switch),
                Option(label: "Armenian", value: "armenian", type: .switch),
                Option(label: "Asian Fusion", value: "asianfusion", type: .switch),
                Option(label: "Australian", value: "australian", type: .switch),
                Option(label: "Austrian", value: "austrian", type: .switch),
                Option(label: "Bangladeshi", value: "bangladeshi", type: .switch),
                Option(label: "Barbeque", value: "bbq", type: .switch),
                Option(label: "Basque", value: "basque", type: .switch),
                Option(label: "Belgian", value: "belgian", type: .switch),
                Option(label: "Brasseries", value: "brasseries", type: .switch),
                Option(label: "Brazilian", value: "brazilian", type: .switch),
                Option(label: "Breakfast & Brunch", value: "breakfast_brunch", type: .switch),
                Option(label: "British", value: "british", type: .switch),
                Option(label: "Buffets", value: "buffets", type: .switch),
                Option(label: "Burgers", value: "burgers", type: .switch),
                Option(label: "Burmese", value: "burmese", type: .switch),
                Option(label: "Cafes", value: "cafes", type: .switch),
                Option(label: "Cafeteria", value: "cafeteria", type: .switch),
                Option(label: "Cajun/Creole", value: "cajun", type: .switch),
                Option(label: "Cambodian", value: "cambodian", type: .switch),
                Option(label: "Caribbean", value: "caribbean", type: .switch),
                Option(label: "Catalan", value: "catalan", type: .switch),
                Option(label: "Cheesesteaks", value: "cheesesteaks", type: .switch),
                Option(label: "Chicken Wings", value: "chicken_wings", type: .switch),
                Option(label: "Chinese", value: "chinese", type: .switch),
                Option(label: "Comfort Food", value: "comfortfood", type: .switch),
                Option(label: "Creperies", value: "creperies", type: .switch),
                Option(label: "Cuban", value: "cuban", type: .switch),
                Option(label: "Czech", value: "czech", type: .switch),
                Option(label: "Delis", value: "delis", type: .switch),
                Option(label: "Diners", value: "diners", type: .switch),
                Option(label: "Ethiopian", value: "ethiopian", type: .switch),
                Option(label: "Fast Food", value: "hotdogs", type: .switch),
                Option(label: "Filipino", value: "filipino", type: .switch),
                Option(label: "Fish & Chips", value: "fishnchips", type: .switch),
                Option(label: "Fondue", value: "fondue", type: .switch),
                Option(label: "Food Court", value: "food_court", type: .switch),
                Option(label: "Food Stands", value: "foodstands", type: .switch),
                Option(label: "French", value: "french", type: .switch),
                Option(label: "Gastropubs", value: "gastropubs", type: .switch),
                Option(label: "German", value: "german", type: .switch),
                Option(label: "Gluten-Free", value: "gluten_free", type: .switch),
                Option(label: "Greek", value: "greek", type: .switch),
                Option(label: "Halal", value: "halal", type: .switch),
                Option(label: "Hawaiian", value: "hawaiian", type: .switch),
                Option(label: "Himalayan/Nepalese", value: "himalayan", type: .switch),
                Option(label: "Hot Dogs", value: "hotdog", type: .switch),
                Option(label: "Hot Pot", value: "hotpot", type: .switch),
                Option(label: "Hungarian", value: "hungarian", type: .switch),
                Option(label: "Iberian", value: "iberian", type: .switch),
                Option(label: "Indian", value: "indpak", type: .switch),
                Option(label: "Indonesian", value: "indonesian", type: .switch),
                Option(label: "Irish", value: "irish", type: .switch),
                Option(label: "Italian", value: "italian", type: .switch),
                Option(label: "Japanese", value: "japanese", type: .switch),
                Option(label: "Korean", value: "korean", type: .switch),
                Option(label: "Kosher", value: "kosher", type: .switch),
                Option(label: "Laotian", value: "laotian", type: .switch),
                Option(label: "Latin American", value: "latin", type: .switch),
                Option(label: "Live/Raw Food", value: "raw_food", type: .switch),
                Option(label: "Malaysian", value: "malaysian", type: .switch),
                Option(label: "Mediterranean", value: "mediterranean", type: .switch),
                Option(label: "Mexican", value: "mexican", type: .switch),
                Option(label: "Middle Eastern", value: "mideastern", type: .switch),
                Option(label: "Modern European", value: "modern_european", type: .switch),
                Option(label: "Mongolian", value: "mongolian", type: .switch),
                Option(label: "Moroccan", value: "moroccan", type: .switch),
                Option(label: "Pakistani", value: "pakistani", type: .switch),
                Option(label: "Persian/Iranian", value: "persian", type: .switch),
                Option(label: "Peruvian", value: "peruvian", type: .switch),
                Option(label: "Pizza", value: "pizza", type: .switch),
                Option(label: "Polish", value: "polish", type: .switch),
                Option(label: "Portuguese", value: "portuguese", type: .switch),
                Option(label: "Russian", value: "russian", type: .switch),
                Option(label: "Salad", value: "salad", type: .switch),
                Option(label: "Sandwiches", value: "sandwiches", type: .switch),
                Option(label: "Scandinavian", value: "scandinavian", type: .switch),
                Option(label: "Scottish", value: "scottish", type: .switch),
                Option(label: "Seafood", value: "seafood", type: .switch),
                Option(label: "Singaporean", value: "singaporean", type: .switch),
                Option(label: "Slovakian", value: "slovakian", type: .switch),
                Option(label: "Soul Food", value: "soulfood", type: .switch),
                Option(label: "Soup", value: "soup", type: .switch),
                Option(label: "Southern", value: "southern", type: .switch),
                Option(label: "Spanish", value: "spanish", type: .switch),
                Option(label: "Steakhouses", value: "steak", type: .switch),
                Option(label: "Sushi Bars", value: "sushi", type: .switch),
                Option(label: "Taiwanese", value: "taiwanese", type: .switch),
                Option(label: "Tapas Bars", value: "tapas", type: .switch),
                Option(label: "Tapas/Small Plates", value: "tapasmallplates", type: .switch),
                Option(label: "Tex-Mex", value: "tex-mex", type: .switch),
                Option(label: "Thai", value: "thai", type: .switch),
                Option(label: "Turkish", value: "turkish", type: .switch),
                Option(label: "Ukrainian", value: "ukrainian", type: .switch),
                Option(label: "Uzbek", value: "uzbek", type: .switch),
                Option(label: "Vegan", value: "vegan", type: .switch),
                Option(label: "Vegetarian", value: "vegetarian", type: .switch),
                Option(label: "Vietnamese", value: "vietnamese", type: .switch)
            ],
            visibleCount: 3,
            type: .multiple
        )
    ]
    
    struct Static {
        static let instance = AppFilters()
    }
    
    static var hasUpdated: Bool = true
    
    class var instance: AppFilters {
        return Static.instance
    }
    
    var parameters: [String : AnyObject] {
        get {
            var parameters = [String : AnyObject]()
            for filter in self.filters {
                switch filter.type {
                case .single:
                    if filter.name != nil {
                        let option = filter.options[filter.selectedOption]
                        if option.value != "" {
                            parameters[filter.name!] = option.value as AnyObject
                        }
                    }
                case .multiple:
                    if filter.name != nil {
                        let selectedOptions = filter.selectedOptions
                        if selectedOptions.count > 0 {
                            var str = ""
                            for i in 0 ..< selectedOptions.count {
                                str += selectedOptions[i].value
                                if i + 1 != selectedOptions.count {
                                    str += ","
                                }
                            }
                            parameters[filter.name!] = str as AnyObject
                        }
                    }
                default:
                    for option in filter.options {
                        if option.selected && option.name != nil && option.value != "" {
                            parameters[option.name!] = option.value as AnyObject
                        }
                    }
                }
            }
            return parameters
        }
    }
    
    init(appFilters: AppFilters! = nil) {
        if appFilters != nil {
            self.loadAppFilters(appFilters: appFilters)
        }
    }
    
    func loadAppFilters(appFilters: AppFilters) {
        for i in 0 ..< self.filters.count {
            for j in 0 ..< self.filters[i].options.count {
                self.filters[i].options[j].selected = appFilters.filters[i].options[j].selected
            }
        }
    }
}

enum FilterType {
    case `default`, single, multiple
}

class Filter {
    var label: String
    var name: String?
    var options: [Option]
    var visibleCount: Int
    var type: FilterType
    var expanded: Bool
    
    var selectedOption: Int {
        get {
            for i in 0 ..< self.options.count {
                if self.options[i].selected {
                    return i
                }
            }
            return -1
        }
        
        set {
            let selectedOption = self.selectedOption
            if self.type == .single && selectedOption != -1 {
                self.options[selectedOption].selected = false
            }
            self.options[newValue].selected = true
        }
    }
    
    init(label: String, name: String? = nil, options: [Option], visibleCount: Int = 1, expanded: Bool = false, type: FilterType) {
        self.label = label
        self.name = name
        self.options = options
        self.visibleCount = visibleCount
        self.expanded = expanded
        self.type = type
    }
    
    var selectedOptions: [Option] {
        get {
            var options = [Option]()
            for option in self.options {
                if option.selected {
                    options.append(option)
                }
            }
            return options
        }
    }
}

enum OptionType {
    case `switch`, check, segmentedControl
}

class Option {
    var label: String
    var name: String?
    var value: String
    var selected: Bool
    var type: OptionType
    
    init(label: String, name: String? = nil, value: String, selected: Bool = false, type: OptionType) {
        self.label = label
        self.name = name
        self.value = value
        self.selected = selected
        self.type = type
    }
}
