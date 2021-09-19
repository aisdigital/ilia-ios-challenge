//
//  SecondScreenViewController.swift
//  ilia-ios-challenge
//
//  Created by marcelo frost marchesan on 18/09/21.
//

import UIKit

class SecondScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    private var movieData = [String]()

    private let movie: Result

    init (movie: Result) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = movie.title
        setMovieData()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .lightGray
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(dismissSelf))
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        for i in indexPath{
            cell.textLabel?.text = movieData[i]
            cell.textLabel?.numberOfLines = 0
        }
         return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @objc func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
    func setMovieData(){
        movieData.append("Release date: \(movie.releaseDate)")
        movieData.append("Original language: \(movie.originalTitle)")
        movieData.append("Release date: \(movie.overview)")
    }
}
