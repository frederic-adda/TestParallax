//
//  Storyboarded.swift
//  TestParallax
//
//  Created by Frédéric ADDA on 28/12/2018.
//  Copyright © 2018 Frédéric ADDA. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
