//
//  PersonCell.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 04/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

final class PersonCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    static func newRow(with person: Person) -> Row {
        let row = Row(identifier: String(describing: PersonCell.self))
        
        row.setConfiguration { (cell, _, _) in
            guard let cell = cell as? PersonCell else { return }
            
            if let profilePath = person.profilePath {
                cell.imageView.downloadImage(for: profilePath, withSize: .big, imageType: .profileImage)
            } else {
                cell.createProfileName(from: person.name)
            }
            
            cell.imageView.cornerOn(.all, radius: 5)
            cell.nameLabel.text = person.name
        }
        
        return row
    }
    
    func createProfileName(from name: String) {
        let initials = name.components(separatedBy: " ").reduce("") {
            ($0 == "" ? "" : "\($0.first ?? Character(""))") + "\($1.first ?? Character(""))"
        }
        
        let imageFrame = imageView.frame
        let size = imageFrame.height
        
        let label = UILabel()
        label.frame.size = CGSize(width: size, height: size)
        label.text = initials
        label.textColor = .white
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
            
        guard let image = createImageFrom(view: label) else {
                return
        }
        imageView.image = image
    }

    func createImageFrom(view: UIView) -> UIImage? {
        UIGraphicsBeginImageContext(view.frame.size)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        view.layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
