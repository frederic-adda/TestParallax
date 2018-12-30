//
//  Page.swift
//  TestParallax
//
//  Created by Frédéric ADDA on 28/12/2018.
//  Copyright © 2018 Frédéric ADDA. All rights reserved.
//

import Foundation

struct Page {
    var cityName: String
    var temperature: Int
    var image: String
}

extension Page {
    static var samples: [Page] {
        return [
            Page(cityName: "Tel-Aviv", temperature: 21, image: "tel-aviv"),
            Page(cityName: "Nice", temperature: 14, image: "nice"),
            Page(cityName: "Rio de Janeiro", temperature: 35, image: "rio"),
        ]
    }
}

extension Page: Equatable {
    static func == (lhs: Page, rhs: Page) -> Bool {
        return
            lhs.cityName == rhs.cityName
    }
}
