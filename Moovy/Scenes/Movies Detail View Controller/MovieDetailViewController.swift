//
//  MoviesDetailViewController.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 03/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit
 
final class MovieDetailViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel: MovieDetailViewModel
    
    private let headerView = UIView()
    private let maxHeaderViewHeight: CGFloat = 400
    private let minHeaderViewHeight: CGFloat = 150
    
    private var statusBarHeight: CGFloat {
        return viewModel.findStatusBarHeight()
    }
    private var dataSource = DataSource() {
        didSet {
            bindDataSource()
            DispatchQueue.main.async {
                self.tableView.delegate = self.dataSource
                self.tableView.dataSource = self.dataSource
                self.tableView.reloadData()
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Init
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHeaderView()
        setupTableView()
        bindViewModelStreams()
        
        view.setActivityIndicator()
        viewModel.getInfos()
    }
    
    // MARK: - Setups
    private func setupTableView() {
        tableView.contentInset = UIEdgeInsets(top: maxHeaderViewHeight - statusBarHeight, left: 0, bottom: 15, right: 0)
        tableView.allowsSelection = false
        tableView.register(
            MovieOverviewTableViewCell.self,
            MovieRatingTableViewCell.self,
            VideosCollectionTableViewCell.self,
            CastAndCrewCollectionTableViewCell.self
        )
    }

    private func setupHeaderView() {
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: maxHeaderViewHeight)
        
        setupImageView()
        setupMovieTitleLabel()
        
        view.addSubview(headerView)
        setupCloseButton()
    }
    
    private func setupImageView() {
        let imageView = UIImageView()
        imageView.downloadImage(for: viewModel.movie.backdropPath ?? "", withSize: .medium, imageType: .backdropImage)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(imageView)
        
        let top = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .top, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: headerView, attribute: .bottom, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: headerView, attribute: .trailing, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: headerView, attribute: .leading, multiplier: 1, constant: 0)
        
        activateConstraints(top, bottom, trailing, leading)
        
        setupOpaqueView()
    }
    
    private func setupOpaqueView() {
        let opaqueView = UIView()
        opaqueView.frame = headerView.frame
        opaqueView.translatesAutoresizingMaskIntoConstraints = false
        opaqueView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        headerView.addSubview(opaqueView)
        
        let top = NSLayoutConstraint(item: opaqueView, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .top, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: opaqueView, attribute: .bottom, relatedBy: .equal, toItem: headerView, attribute: .bottom, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: opaqueView, attribute: .trailing, relatedBy: .equal, toItem: headerView, attribute: .trailing, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: opaqueView, attribute: .leading, relatedBy: .equal, toItem: headerView, attribute: .leading, multiplier: 1, constant: 0)
        
        activateConstraints(bottom, leading, top, trailing)
    }
    
    private func setupCloseButton() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(assetIdentifier: .cancelIcon), for: .normal)
        button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        button.tintColor = .baseOrange
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        let top = button.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5)
        let leading = NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 20)
        let height = NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
        let width = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
        
        activateConstraints(top, leading, height, width)
    }
    
    private func setupMovieTitleLabel() {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.text = viewModel.movie.title
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(label)
        
        let bottom = NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: headerView, attribute: .bottom, multiplier: 1, constant: -20)
        let leading = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: headerView, attribute: .leading, multiplier: 1, constant: 20)
        let trailing = NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: headerView, attribute: .trailing, multiplier: 1, constant: -20)
        
        activateConstraints(bottom, leading, trailing)
    }
    
    // MARK: - Bindings
    private func bindViewModelStreams() {
        viewModel.setDataSourceStream { [weak self] dataSource in
            self?.dataSource = dataSource
            DispatchQueue.main.async {
                self?.view.removeActivityIndicator()
            }
        }
    }
    
    private func bindDataSource() {
        dataSource.setScrollViewDidScroll { [weak self, maxHeaderViewHeight, minHeaderViewHeight] scrollView in
            let y = maxHeaderViewHeight - (scrollView.contentOffset.y + (maxHeaderViewHeight - (self?.statusBarHeight ?? 0)))
            let height = min(max(y, minHeaderViewHeight), maxHeaderViewHeight)
            self?.headerView.frame = CGRect(x: 0, y: 0, width: self?.view.frame.width ?? 0, height: height)
        }
    }
    
    // MARK: - Helper
    func activateConstraints(_ constraints: NSLayoutConstraint ...) {
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - IBActions
    @IBAction func dismiss(_ sender: UIButton) {
        viewModel.goBack()
    }
}
