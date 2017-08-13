//
//  MapViewController.swift
//  Coins
//
//  Created by Vitaly Berg on 8/13/17.
//  Copyright © 2017 Vitaly Berg. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

extension Category {
    init?(json: JSON) {
        guard let id = json["id"].int else {
            return nil
        }
        guard let name = json["name"].string else {
            return nil
        }
        self.init(id: id, name: name)
    }
}

extension Place {
    init?(json: JSON) {
        guard let id = json["id"].int else {
            return nil
        }
        guard let name = json["name"].string else {
            return nil
        }
        guard let lat = json["latitude"].double, let lon = json["longitude"].double else {
            return nil
        }
        
        self.init(
            id: id,
            categoryId: json["category_id"].int,
            name: name,
            location: (lat, lon)
        )
    }
}

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    func setupMapView() {
        if let url = Bundle.main.url(forResource: "map-dark-style", withExtension: "json") {
            mapView.mapStyle = try? GMSMapStyle(contentsOfFileURL: url)
        }
    }
    
    // MARK: -
    
    private var categories: [Category] = []
    private var places: [Place] = []
    
    private func loadCategories() {
        request("http://91.121.144.57:3000/api/v3/place_categories").validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.categories = json.arrayValue.flatMap { Category(json: $0) }
                self.loadPlaces()
            case .failure:
                break
            }
        }
    }
    
    private func loadPlaces() {
        request("http://91.121.144.57:3000/api/v3/places").validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.places = json.arrayValue.flatMap { Place(json: $0) }
                self.handlePlaces()
            case .failure:
                break
            }
        }
    }
    
    private func handlePlaces() {
        for place in places {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: place.location.lat, longitude: place.location.lon)
            marker.icon = iconFor(category: place.categoryId)
            marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
            marker.map = mapView
        }
    }
    
    private var icons: [Int : UIImage] = [:]
    private var defaultIcon: UIImage?
    
    private func iconFor(category: Int?) -> UIImage? {
        func iconFor(emoji: String) -> UIImage {
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 36, height: 36), false, UIScreen.main.scale)
            
            let context = UIGraphicsGetCurrentContext()!
            context.setShadow(offset: .zero, blur: 2, color: UIColor.black.withAlphaComponent(0.4).cgColor)
            
            let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 30)]
            let string = NSAttributedString(string: emoji, attributes: attributes)
            
            let size = string.size()
            
            string.draw(at: CGPoint(x: (36 - size.width) / 2, y: (36 - size.height) / 2))
            
            let icon = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            return icon
        }
        
        if let category = category {
            if let icon = icons[category] {
                return icon
            }
            
            if let emoji = emojiFor(category: category) {
                let icon = iconFor(emoji: emoji)
                icons[category] = icon
                return icon
            } else {
                let icon = iconFor(emoji: "🙂")
                icons[category] = icon
                return icon
            }
        } else {
            if let icon = defaultIcon {
                return icon
            }
            defaultIcon = iconFor(emoji: "🙂")
            return defaultIcon
        }
    }
    
    private func emojiFor(category: Int) -> String? {
        return [
            1: "💵",
            2: "🍽",
            3: "🥐",
            4: "🍺",
            5: "🛏",
            6: "🍕",
            7: "🍟",
            8: "🏥",
            9: "💊",
            10: "🚕",
            ][category]
    }

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        loadCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
