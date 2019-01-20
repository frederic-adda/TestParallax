//
//  PageController.swift
//  TestParallax
//
//  Created by Frédéric ADDA on 28/12/2018.
//  Copyright © 2018 Frédéric ADDA. All rights reserved.
//

import UIKit

class PageController: UIViewController, Storyboarded {

    // MARK: - Properties
    var page: Page! {
        didSet {
            setupUI()
        }
    }

    override var debugDescription: String {
        return "\(super.debugDescription) - cityName: \(page.cityName)"
    }

    // IBOutlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    // NSLayoutConstraints
    @IBOutlet weak var backgroundImageLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundImageTrailingConstraint: NSLayoutConstraint!

    
    // MARK: - View controller life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    

    // MARK: - Public functions

    func offsetBackgroundImage(by horizontalOffset: CGFloat) {
//        print("\(page.cityName) updating constraints with \(horizontalOffset)")
        backgroundImageLeadingConstraint?.constant = horizontalOffset
        backgroundImageTrailingConstraint?.constant = -horizontalOffset
        view.layoutIfNeeded()
    }


    // MARK: - Private functions
    
    private func setupUI() {
        backgroundImageView?.image = UIImage(named: page.image)
        cityLabel?.text = page.cityName
        temperatureLabel?.text = "\(page.temperature)°"
    }

}
