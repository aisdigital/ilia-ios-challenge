//
//  Row.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 01/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

typealias RowConfiguration = (_ cell: UIView, _ row: Row, _ indexPath: IndexPath) -> Void
typealias DidSelectConfiguration = (_ cell: UIView, _ row: Row, _ indexPath: IndexPath) -> Void

protocol RowRepresentable {
    var identifier: String { get }
    var configuration: RowConfiguration? { get set }
}

final class Row: RowRepresentable {
    var identifier: String
    
    var configuration: RowConfiguration?
    var didSelect: DidSelectConfiguration?
    
    init(identifier: String) {
        self.identifier = identifier
    }
    
    func setConfiguration(_ configurationClosure: @escaping RowConfiguration) {
        self.configuration = configurationClosure
    }
    
    func setDidSelect(_ didSelectClosure: @escaping DidSelectConfiguration) {
        self.didSelect = didSelectClosure
    }
}

