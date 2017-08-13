//
//  MapViewController.swift
//  Coins
//
//  Created by Vitaly Berg on 8/13/17.
//  Copyright © 2017 Vitaly Berg. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
