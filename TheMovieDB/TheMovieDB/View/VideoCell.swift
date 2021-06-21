//
//  VideoCell.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 20/06/21.
//

import UIKit
import AVKit


class VideoCell: UICollectionViewCell {
    //MARK: - Properties
    var player: AVPlayer!
    var playerController: AVPlayerViewController!
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()

    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(containerView)
        containerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 260)
        preparePlayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func preparePlayer() {
        let url = URL(fileURLWithPath: "http://trailers.apple.com/movies/lucasfilm/star-wars-the-last-jedi/star-wars-the-last-jedi-trailer-2_h720p.mov")
        player = AVPlayer(url: url)
        playerController = AVPlayerViewController()
        playerController.player = player
        playerController.showsPlaybackControls = true
        playerController.player?.play()
        playerController.view.frame = containerView.bounds
        containerView.addSubview(playerController.view)
        
    }

}

