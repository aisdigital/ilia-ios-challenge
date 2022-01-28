//
//  ViewController.swift
//  IliaCodeChallenge
//
//  Created by Stephanie Torisu on 25/01/22.
//

import UIKit

class ViewController: UIViewController{


    private var service: Service = Service()
    private var movies : [Movie] = []
    
    @IBOutlet weak var collectionViewMovies: UICollectionView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movies"
        setupCollections()
        service.getPopularMovies { (movies) in
            DispatchQueue.main.async {
                self.collectionViewMovies?.reloadData()
            }
            
        }
        bindEvents()
        
    }
    
    
    func setupCollections(){
        collectionViewMovies?.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        collectionViewMovies?.delegate = self
        collectionViewMovies?.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 200, height: 250)
        collectionViewMovies?.setCollectionViewLayout(layout, animated: true)
    }
    
    func bindEvents(){
        service.updateLayout = {
            //print("CHEGUEI AQUI")
            [weak self] in
            DispatchQueue.main.async {
                self?.collectionViewMovies?.reloadData()
            }
        }
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


