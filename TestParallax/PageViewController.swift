//
//  PageViewController.swift
//  TestParallax
//
//  Created by Frédéric ADDA on 28/12/2018.
//  Copyright © 2018 Frédéric ADDA. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    // MARK: - Properties

    let pageDataSource = PageDataSource()
    var currentIndex = 0

    /// Helper computed property to the current page controller
    var currentPageController: PageController? {
        guard pageDataSource.pageControllers.indices.contains(currentIndex)
            else { return nil }
        return pageDataSource.pageControllers[currentIndex]
    }

    /// Helper computed property to the previous page controller
    var previousPageController: PageController? {
        guard pageDataSource.pageControllers.indices.contains(currentIndex - 1)
            else { return nil }
        return pageDataSource.pageControllers[currentIndex - 1]
    }

    /// Helper computed property to the next page controller
    var nextPageController: PageController? {
        guard pageDataSource.pageControllers.indices.contains(currentIndex + 1)
            else { return nil }
        return pageDataSource.pageControllers[currentIndex + 1]
    }


    // MARK: - View controller life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = pageDataSource
        delegate = self

        // Get a hold on the scrollView of the UIPageController
        if let scrollView = view.subviews.compactMap({ $0 as? UIScrollView }).first {
            scrollView.delegate = self
        }

        setupInitialPageController()
    }


    // MARK: - Public functions

    private func setupInitialPageController() {
        
        if let pageController = pageDataSource.createPageController(at: 0) {
            setViewControllers([pageController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
}


// MARK: - UIPageViewControllerDelegate

extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else { return }

        // Update the current index
        if let newController = viewControllers?.first as? PageController,
            let newIndex = pageDataSource.pageControllers.firstIndex(of: newController) {
            currentIndex = newIndex
        }
    }
}


// MARK: - UIScrollViewDelegate

extension PageViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let screenWidth = scrollView.bounds.width
        /*
         In a UIPageViewController, the initial contentOffset.x is not 0, but equal to the screen width
         (so that the offset goes between (1 * screenWidth) and 0 when going to the previous view controller, and from (1 * screenWidth) to (2 * screenWidth) when going to the next view controller).
         Also, it's reset to the screenWidth when the scroll to a previous or next view controller is complete.
         Therefore, we calculate a new 'horizontalOffset' starting at 0, and going:
         - negative from 0 to (-screenWidth/2) when scrolling to the next view controller,
         - and from 0 to (screenWidth/2) when scrolling to the previous view controller.
         */
        let horizontalOffset = (scrollView.contentOffset.x - screenWidth)/2

        // Special case: initial situation, or when the horizontalOffset is reset to 0 by the UIPageViewController.
        guard horizontalOffset != 0 else {
            previousPageController?.offsetBackgroundImage(by: screenWidth/2)
            currentPageController?.offsetBackgroundImage(by: 0)
            nextPageController?.offsetBackgroundImage(by: -screenWidth/2)
            return
        }

        // The background image of the current page controller should always be offset by the horizontalOffset (which may be positive or negative)
        guard let currentPageController = currentPageController else { return }
        currentPageController.offsetBackgroundImage(by: horizontalOffset)

        if horizontalOffset > 0 { // swiping left, to the next page controller

            // The background image of the next page controller starts with an initial offset of (-screenWidth/2), then we apply the (positive) horizontalOffset
            if let nextPageController = nextPageController {
                let nextOffset = -screenWidth/2 + horizontalOffset
                nextPageController.offsetBackgroundImage(by: nextOffset)
            }
        } else { // swiping right, to the previous page controller

            // The background image of the previous page controller starts with an initial offset of (+screenWidth/2), then we apply the (negative) horizontalOffset
            if let previousPageController = previousPageController {
                let previousOffset = screenWidth/2 + horizontalOffset
                previousPageController.offsetBackgroundImage(by: previousOffset)
            }
        }
    }
}
