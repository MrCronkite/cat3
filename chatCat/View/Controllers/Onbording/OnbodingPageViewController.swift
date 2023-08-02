//
//  OnbodingPageViewController.swift
//  chatCat
//
//  Created by admin1 on 1.08.23.
//

import UIKit

final class OnbodingPageViewController: UIViewController, UIPageViewControllerDataSource {

    var pageViewController: UIPageViewController!
    var texts: [String] = ["Page 1", "Page 2", "Page 3", "Page 4"]
    var currentIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self

        if let firstViewController = viewControllerAtIndex(0) {
            pageViewController.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }

        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)

        let nextButton = UIButton(type: .system)
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.frame = CGRect(x: view.bounds.width - 100, y: view.bounds.height - 100, width: 80, height: 40)
        view.addSubview(nextButton)
    }

    @objc func nextButtonTapped() {
        currentIndex = (currentIndex + 1) % texts.count

        if let nextViewController = viewControllerAtIndex(currentIndex) {
            pageViewController.setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        if index >= 0 && index < texts.count {
            let contentViewController = UIViewController()
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 100))
            label.text = texts[index]
            label.textAlignment = .center
            label.center = view.center
            contentViewController.view.addSubview(label)
            
            return contentViewController
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = texts.firstIndex(of: (viewController.view.subviews.first as? UILabel)?.text ?? "") {
            let previousIndex = (index - 1 + texts.count) % texts.count
            return viewControllerAtIndex(previousIndex)
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = texts.firstIndex(of: (viewController.view.subviews.first as? UILabel)?.text ?? "") {
            let nextIndex = (index + 1) % texts.count
            return viewControllerAtIndex(nextIndex)
        }
        return nil
    }
}
