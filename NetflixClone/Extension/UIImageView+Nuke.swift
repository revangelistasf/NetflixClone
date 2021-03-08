//
//  UIImageView+Nuke.swift
//  NetflixClone
//
//  Created by Roberto Evangelista on 08/03/2021.
//

import UIKit
import Nuke

extension UIImageView {
    
    func loadImageFromUrl(_ url: URL?, completion: @escaping (() -> Void)) {
        if let url = url {
            Nuke.loadImage(with: url, into: self)
            let imageLoadingOptions = ImageLoadingOptions(placeholder: nil, transition: .fadeIn(duration: 0.25))
            Nuke.loadImage(with: url, options: imageLoadingOptions, into: self) { _ in
                completion()
            }
        }
    }
    
}
