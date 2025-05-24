//
//  UIImage+Extension.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 24/05/25.
//

import UIKit

extension UIImage {
    func scaledDown(toMaxDimension max: CGFloat) -> UIImage {
        let aspectRatio = size.width / size.height

        var newSize: CGSize
        if size.width > size.height {
            newSize = CGSize(width: max, height: max / aspectRatio)
        } else {
            newSize = CGSize(width: max * aspectRatio, height: max)
        }

        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
