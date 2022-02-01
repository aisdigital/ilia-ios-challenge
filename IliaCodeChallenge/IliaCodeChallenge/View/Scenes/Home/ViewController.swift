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
   // let loadingAnimation = AnimationView(name: "loading")
    let tabBarVC = UITabBarController()
    
    @IBOutlet weak var collectionViewMovies: UICollectionView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movies"
        showScreen()
    }

     private func showScreen(){
         //addLoading()
         addSpinner()
         setupCollections()
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
                //self.removeLoading()
                self.removeSpinner()
            }
        }
    }
    
   /* private func addLoading(){
       view.addSubview(loadingAnimation)
        loadingAnimation.loopMode = .loop
        loadingAnimation.frame = view.bounds
        loadingAnimation.isHidden = false
        loadingAnimation.alpha = 0.5
        loadingAnimation.play()
    }
    
    private func removeLoading(){
        self.loadingAnimation.stop()
        self.loadingAnimation.isHidden = true
        self.loadingAnimation.removeFromSuperview()

    }*/

    private func addSpinner(){
        self.spinner?.startAnimating()
    }

    private func removeSpinner(){
        self.spinner?.stopAnimating()
        self.spinner?.isHidden = true
        self.spinner?.removeFromSuperview()
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


