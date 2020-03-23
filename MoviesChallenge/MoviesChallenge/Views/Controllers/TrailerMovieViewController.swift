//
//  TrailerMovieViewController.swift
//  MoviesChallenge
//
//  Created by Lucas Santana Brito on 22/03/20.
//  Copyright © 2020 lsb. All rights reserved.
//

import UIKit
import WebKit
import RxSwift


class TrailerMovieViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var webView: WKWebView!
    
    var viewModel: TrailerMovieViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
}

extension TrailerMovieViewController {
    private func setupWebView() {
        viewModel
            .getUrlTrailer()
            .subscribe(onNext: { [unowned self] urlRequest in
                self.webView.load(urlRequest)
            }).disposed(by: disposeBag)
    }
}
