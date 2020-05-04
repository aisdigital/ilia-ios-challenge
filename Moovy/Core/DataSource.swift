//
//  DataSource.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 01/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

typealias ScrollViewDidScrollClosure = (_ scrollView: UIScrollView) -> Void

final class DataSource: NSObject {
    var items: [[Row]] = [[]]
    var collectionViewFlowLayout: UICollectionViewFlowLayout?
    var scrollViewDidScrollClosure: ScrollViewDidScrollClosure?
    
    // MARK: - Init
    convenience init(items: [[Row]], collectionViewFlowLayout: UICollectionViewFlowLayout? = nil) {
        self.init()
        self.items = items
        self.collectionViewFlowLayout = collectionViewFlowLayout
    }
    
    func setScrollViewDidScroll(_ scrollViewDidScrollClosure: ScrollViewDidScrollClosure?) {
        self.scrollViewDidScrollClosure = scrollViewDidScrollClosure
    }
    
    func appendItems(_ items: [[Row]]) {
        for (index, item) in items.enumerated() {
            self.items[index].append(contentsOf: item)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollViewDidScrollClosure?(scrollView)
    }
}

// MARK: - Extension: UITableView
extension DataSource: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section][indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath)
        
        item.configuration?(cell, item, indexPath)
        
        return cell
    }
}

// MARK: - Extension: UICollectionView
extension DataSource: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.section][indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.identifier, for: indexPath)
        
        item.configuration?(cell, item, indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let item = items[indexPath.section][indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.identifier, for: indexPath)
        
        item.didSelect?(cell, item, indexPath)
    }
}

