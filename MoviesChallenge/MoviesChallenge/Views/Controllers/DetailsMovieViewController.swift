//
//  DetailsMovieViewController.swift
//  MoviesChallenge
//
//  Created by Lucas Santana Brito on 22/03/20.
//  Copyright © 2020 lsb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class DetailsMovieViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var runtimeLabels: UILabel!
    @IBOutlet weak var desctiptionTextView: UITextView!
    @IBOutlet weak var watchTrailerButton: UIButton!
    
    var viewModel: DetailsMovieViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    @IBAction func goWatchTrailer(_ sender: UIButton) {
    }
    
}

extension DetailsMovieViewController {
    private func setup() {
        setupPoster()
        setupTitleLabel()
        setupYear()
        setupGenres()
        setupRuntime()
        setupDescription()
        setupButton()
    }
    
    private func setupPoster() {
        viewModel.detailsMovie
            .asObservable()
            .subscribe(onNext: { [unowned self] movie in
                self.posterImageView.kf.setImage(with: movie?.getImagePoster())
            }).disposed(by: disposeBag)
    }
    
    private func setupTitleLabel() {
        viewModel.detailsMovie
            .asObservable()
            .map { $0?.title ?? "Sem titulo" }
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func setupYear() {
        viewModel.detailsMovie
            .asObservable()
            .map { $0?.getDate() }
            .bind(to: yearLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func setupGenres() {
        viewModel.detailsMovie
            .asObservable()
            .map { $0?.genres.first?.name ?? "" }
            .bind(to: genresLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func setupRuntime() {
        viewModel.detailsMovie
            .asObservable()
            .map { $0?.getRuntime() }
            .bind(to: runtimeLabels.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func setupDescription() {
        viewModel.detailsMovie
            .asObservable()
            .map { $0?.description }
            .bind(to: desctiptionTextView.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func setupButton() {
        
    }

}
