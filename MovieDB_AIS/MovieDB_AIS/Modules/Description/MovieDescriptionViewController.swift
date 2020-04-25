//  
//  MovieDescriptionViewController.swift
//  MovieDB_AIS
//
//  Created by Rhullian Damião on 24/04/20.
//  Copyright © 2020 RDevign. All rights reserved.
//

import UIKit

class MovieDescriptionViewController: BaseViewController {

    enum MovieDescriptionRouter {}
    
    // MARK: - Outlets
    
    
    // MARK: - Properties
    var presenter: MovieDescriptionPresenter!
    
    // MARK: - View Lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupConfig()
        presenter.didLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.willAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.didAppear()
    }
    
    // MARK: - Methods
    func setupConfig() {
        self.presenter = MovieDescriptionPresenter(delegate: self)
    }
    
    // MARK: - Actions

}

// MARK: - MovieDescriptionPresenterDelegate
extension MovieDescriptionViewController: MovieDescriptionPresenterDelegate {
}

// MARK: - ROUTER FUNCTIONS
extension MovieDescriptionViewController {
    func navigate(to selected: MovieDescriptionRouter) {
    }
}
