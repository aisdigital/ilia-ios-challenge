//
//  MoviesViewController.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme Silva on 25/11/21.
//

import UIKit
import Moya

class MoviesViewController: UIViewController {
    var dataMovies = MoviesController()

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        moviesCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        showPreviousButton()
        fetchData()
    }
    
    func reloadData() {
        self.moviesCollectionView.reloadData()
    }
    
    func fetchData () {
        dataMovies.fetchData{
            // Do this when task has finished...
            self.reloadData()
        }
    }
    
    @IBAction func previousButtonPressed(_ sender: UIButton) {
        dataMovies.page -= 1
        showPreviousButton()
        showNextButton()
        fetchData()
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        dataMovies.page += 1
        showNextButton()
        fetchData()
    }
    
    func showPreviousButton() {
        if dataMovies.page == 1 {
            previousButton.isEnabled = false
            previousButton.isHidden = true
        } else {
            previousButton.isEnabled = true
            previousButton.isHidden = false
        }
    }
    
    func showNextButton() {
        showPreviousButton()
        if dataMovies.page == dataMovies.maxPage {
            nextButton.isEnabled = false
            nextButton.isHidden = true
        } else {
            nextButton.isEnabled = true
            nextButton.isHidden = false
        }
    }
}

extension MoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataMovies.storedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        cell.onBind(data: dataMovies.storedMovies[indexPath.item])
        return cell
    }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 300)
    }
}

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dataMovies.newIndex = indexPath.item
        performSegue(withIdentifier: "movieSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieSegue" {
            let destinationVC = segue.destination as! MovieDetailsViewController
            destinationVC.data = dataMovies.storedMovies[dataMovies.newIndex]
        }
    }
}

