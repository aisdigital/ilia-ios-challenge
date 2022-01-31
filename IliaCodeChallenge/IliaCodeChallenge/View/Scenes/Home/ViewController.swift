//
//  ViewController.swift
//  IliaCodeChallenge
//
//  Created by Stephanie Torisu on 25/01/22.
//

import UIKit
import Lottie


class ViewController: UIViewController{


    private var service: Service = Service()
    private var movies : [Movie] = []
    private let loadingAnimation = AnimationView(name: "loading")
    
    @IBOutlet weak var collectionViewMovies: UICollectionView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movies"
        setupCollections()
        //bindEvents()
        showScreen()
        //setupAnimation()

        
    }
    private func showScreen(){
        setupAnimation()
        bindEvents()
    }
    
    private func setupCollections(){
        collectionViewMovies?.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        collectionViewMovies?.delegate = self
        collectionViewMovies?.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 200, height: 250)
        collectionViewMovies?.setCollectionViewLayout(layout, animated: true)
    }
    
    private func bindEvents(){
        service.getPopularMovies { (movies) in
            DispatchQueue.main.async {
                self.collectionViewMovies?.reloadData()
                self.stopAnimation()
            }
        }
    }

    private func setupAnimation(){
        view.addSubview(loadingAnimation)
        loadingAnimation.frame = view.bounds
        loadingAnimation.contentMode = .scaleAspectFit
        loadingAnimation.animationSpeed = 0.5
        loadingAnimation.loopMode = .loop
        loadingAnimation.play()
    }
    
    private func stopAnimation(){
        loadingAnimation.stop()
    }
}


extension ViewController: UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return service.getMoviesListSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = service.getMovieAt(indexPath.row)
        guard let cell = collectionViewMovies.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else{
            return UICollectionViewCell.init(frame: .zero)
        }
       cell.setUpModel(movie)
        return cell
    }
}
extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = service.getMovieAt(indexPath.row)
        let movieDetailViewController = MovieDetailViewController(selectedMovie: movie)
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}


