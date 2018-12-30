//
//  PageDataSource.swift
//  TestParallax
//
//  Created by Frédéric ADDA on 28/12/2018.
//  Copyright © 2018 Frédéric ADDA. All rights reserved.
//

import UIKit

class PageDataSource: NSObject {

    // MARK: - Properties

    let pages: [Page]
    var pageControllers: [PageController] = []


    // MARK: - Initializer

    override init() {
        self.pages = Page.samples

        super.init()
    }


    // MARK: - Public functions

    func createPageController(at index: Int) -> PageController? {
        guard pages.isEmpty == false else { return nil }
        if pages.count <= index || index < 0 { return nil }

        let pageController = PageController.instantiate()
        pageController.page = pages[index]
        pageControllers.insert(pageController, at: index)
        return pageController
    }
}


// MARK: - UIPageViewControllerDataSource

extension PageDataSource: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard
            let pageController = viewController as? PageController,
            let index = pages.firstIndex(of: pageController.page),
            index > 0
            else { return nil }

        // Check for an existing previous controller, or create it otherwise
        if pageControllers.indices.contains(index - 1) {
            let existingPreviousPageController = pageControllers[index - 1]
            return existingPreviousPageController
        } else {
            let newPageController = createPageController(at: index - 1)
            return newPageController
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard
            let pageController = viewController as? PageController,
            let index = pages.firstIndex(of: pageController.page),
            index < pages.count - 1
            else { return nil }


        // Check for an existing next controller, or create it otherwise
        if pageControllers.indices.contains(index + 1) {
            let existingNextPageController = pageControllers[index + 1]
            return existingNextPageController
        } else {
            let newPageController = createPageController(at: index + 1)
            return newPageController
        }
    }
}
