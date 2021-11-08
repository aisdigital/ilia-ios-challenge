//
//  AppCoordinator.swift
//  NowPlayingMovies
//
//  Created by Dara Caroline on 08/11/21.
//

import Foundation
import UIKit

protocol Coordinator {
    
    var navigationController: UINavigationController { get set }

    func start()
    
}

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let movieListViewController = MovieListViewController(viewModel: MovieListViewModel())
        movieListViewController.coordinator = self
        self.navigationController.pushViewController(movieListViewController, animated: false)
    }
    
//    func showPosts(with userId: Int, by name: String) {
//        let postTableViewController = PostTableViewController(viewModel: PostViewModel(with: userId, by: name))
//        postTableViewController.coordinator = self
//        self.navigationController.pushViewController(postTableViewController, animated: true)
//    }
//    
//    func showDetails(with movieId: Int) {
//        let movieDetailsViewController = MovieDetailsViewController(movie: MovieViewModel())
//        movieDetailsViewController.coordinator = self
//        self.navigationController.pushViewController(movieDetailsViewController, animated: true)
//    }
//    
//    func showComments(with postId: Int, by userName: String) {
//        let commentTableViewController = CommentTableViewController(viewModel: CommentViewModel(with: postId, by: userName))
//        commentTableViewController.coordinator = self
//        self.navigationController.pushViewController(commentTableViewController, animated: true)
//
//    }
//    
//    func showPhotos(with albumId: Int, by userName: String) {
//        let photoTableViewController = PhotoTableViewController(viewModel: PhotoViewModel(with: albumId, by: userName))
//        photoTableViewController.coordinator = self
//        self.navigationController.pushViewController(photoTableViewController, animated: true)
//    }
//    
//    func showDetails(with photoUrl: String, by description: String) {
//        let detailsViewController = DetailsViewController(viewModel: DetailsViewModel(with: photoUrl, by: description))
//        detailsViewController.coordinator = self
//        self.navigationController.pushViewController(detailsViewController, animated: true)
//    }
    
}
