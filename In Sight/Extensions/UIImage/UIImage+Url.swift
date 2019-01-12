//
//  UIImage+Url.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 07/01/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func image(with url: URL?,
               defaultImage: UIImage? = nil) {
        self.kf.setImage(with: url) { result in
            switch result {
            case .success(let value):
                UIView.transition(with: self,
                                  duration: 0.3,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                    self.image = value.image
                }, completion: nil)
            case .failure:
                self.image = defaultImage
            }
        }
    }
}
