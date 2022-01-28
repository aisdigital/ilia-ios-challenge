//
//  ViewController.swift
//  IliaCodeChallenge
//
//  Created by Stephanie Torisu on 25/01/22.
//

import UIKit
import Alamofire

class ViewController: UIViewController{


    private var service: Service = Service()
    
    @IBOutlet weak var collectionViewMovies: UICollectionView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Filmes"
        setupCollections()
        service.getPopularMovies()
        bindEvents()
    }
    
    
    func setupCollections(){
        collectionViewMovies.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionViewMovies.delegate = self
        collectionViewMovies.dataSource = self
    }
    
    func bindEvents(){
        service.updateLayout = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionViewMovies.reloadData()
            }
        }
    }

}
extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Tap")
    }
}
extension ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return service.getMoviesListSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = service.getMovieAt(indexPath.row)
        let cell = collectionViewMovies.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCollectionViewCell
        cell.setUpModel(movie)
        return cell
    }
}
//extension ViewController: UICollectionViewDelegateFlowLayout{
//
//}


