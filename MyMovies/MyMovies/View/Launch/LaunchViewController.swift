//
//  LaunchViewController.swift
//  MyMovies
//
//  Created by Wesley Brito on 03/04/20.
//  Copyright © 2020 Wesley Brito. All rights reserved.
//

import UIKit
import Lottie

class LaunchViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    
    @IBOutlet weak var animationView: LOTAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        startAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func startAnimation() {
        animationView.setAnimation(named: "33-video-cam")
        animationView.contentMode = .scaleAspectFit
        animationView.play { (finished) in
            if finished {
                self.coordinator?.goToHomeTableViewController()
            }
        }
    }

}
