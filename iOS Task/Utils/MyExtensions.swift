//
//  MyExtensions.swift
//  iOS Task
//
//  Created by Touhid on 21/5/21.
//

import UIKit
import Foundation


extension UIImageView {
    // Load image from web link
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
