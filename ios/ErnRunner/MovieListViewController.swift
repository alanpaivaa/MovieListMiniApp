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
  
  // Requests UUIDs
  private var getMoviesRequestUUID: UUID?
  
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
    
    getMoviesRequestUUID = ElectrodeBridgeHolder
      .registerRequestHandler(withName: "MovieListMiniApp:getMovies",
                              requestCompletionHandler: getMovies(requestData:handler:))
    
  }
  
  private func getMovies(requestData: Any?, handler: ElectrodeBridgeResponseCompletionHandler) {
    guard
      let args = requestData as? [String: Any],
      let offset = args["offset"] as? Int,
      let limit = args["limit"] as? Int else {
        print("Invalid params")
        return
    }
    
    let store = MovieStore.shared
    let movies = Array(store.movies[offset..<(offset+limit)])
    
    handler(movies, nil)
  }
  
  deinit {
    if let UUID = getMoviesRequestUUID {
      ElectrodeBridgeHolder.unregisterRequestHandler(with: UUID)
    }
  }
}

class Movie: Bridgeable {
  let id: Int
  let title: String
  let genres: [String]
  let imageURL: String
  let releaseDate: String
  
  init(id: Int,
       title: String,
       genres: [String],
       imageURL: String,
       releaseDate: String) {
    self.id = id
    self.title = title
    self.genres = genres
    self.imageURL = imageURL
    self.releaseDate = releaseDate
  }
  
  func toDictionary() -> NSDictionary {
    return [
      "id": id,
      "title": title,
      "genres": genres,
      "imageURL": imageURL,
      "releaseDate": releaseDate
    ]
  }
}

class MovieStore {
  static let shared = MovieStore()
  private(set) var movies = [Movie]()
  
  private init() {
    movies.append(Movie(id: 1,
                        title: "The Lion King",
                        genres: ["Adventure", "Action"],
                        imageURL: "https://image.tmdb.org/t/p/w500/dzBtMocZuJbjLOXvrl4zGYigDzh.jpg",
                        releaseDate: "2019-07-12"))
    movies.append(Movie(id: 2,
                        title: "Fast & Furious Presents: Hobbs & Shaw",
                        genres: ["Cars", "Other"],
                        imageURL: "https://image.tmdb.org/t/p/w500/8biauVsABUKLwKeDyfawi8wTggS.jpg",
                        releaseDate: "2019-08-01"))
    movies.append(Movie(id: 3,
                        title: "Once Upon a Time in Hollywood",
                        genres: ["Adventure", "Action"],
                        imageURL: "https://image.tmdb.org/t/p/w500/8j58iEBw9pOXFD2L0nt0ZXeHviB.jpg",
                        releaseDate: "2019-07-25"))
  }
}
