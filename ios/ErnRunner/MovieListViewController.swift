//
//  MovieListViewController.swift
//  ErnRunner
//
//  Created by Alan Jeferson on 8/2/19.
//  Copyright © 2019 Walmart. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
  private var rnView: UIView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .red
    
    let viewController =
      ElectrodeReactNative.sharedInstance().miniApp(withName: MainMiniAppName, properties: nil)
    viewController.view.frame = UIScreen.main.bounds;
    view.addSubview(viewController.view)
    
    let rnView = viewController.view as UIView;
    rnView.frame = UIScreen.main.bounds
    view.addSubview(rnView)
    view.layoutIfNeeded()
    self.rnView = rnView
    
    ElectrodeBridgeHolder.registerRequestHandler(withName: "br.com.foo") { (data, completion) in
      DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
        let arr = [
          [
            "id": 3,
            "title": "Spider Man: Far From Home",
            "year": 2019,
            "image": [
              "uri": "https://image.tmdb.org/t/p/w1280/rjbNpRMoVvqHmhmksbokcyCr7wn.jpg"
            ]
          ]
        ]
        completion(arr, nil)
      })
    }
  }
}
