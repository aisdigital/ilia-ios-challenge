//
//  BundleExtension.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme Silva on 01/12/21.
//

import Foundation

extension Bundle {
    static func loadJSONFromBundle(bundle: Bundle = Bundle.main, resourceName: String) -> Data {
            guard let url = bundle.url(forResource: resourceName, withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        }
}
