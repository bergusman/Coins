//
//  MapViewController.swift
//  Coins
//
//  Created by Vitaly Berg on 8/13/17.
//  Copyright © 2017 Vitaly Berg. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    func setupMapView() {
        if let url = Bundle.main.url(forResource: "map-dark-style", withExtension: "json") {
            mapView.mapStyle = try? GMSMapStyle(contentsOfFileURL: url)
        }
    }

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
