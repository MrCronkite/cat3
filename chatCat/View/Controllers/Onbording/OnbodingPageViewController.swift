//
//  OnbodingPageViewController.swift
//  chatCat
//
//  Created by admin1 on 1.08.23.
//

import UIKit

final class OnbordingPageViewController: UIViewController {
    
    var textsImages: [String] = ["catAndMe1", "catAndMe2", "catAndMe3", "cats"]
    var texts: [String] = ["Cat and human", "Speech simulation", "Have fun!", "Enjoy all features"]
    var subtitles: [String] = ["Simulation of human and cat speech and vice versa", "Express any emotion to your cat", "Make friends with your pets", ""]
    var currentIndex: Int = 0
    
    let pageControl: UIPageControl = {
        let view = UIPageControl()
        view.numberOfPages = 3
        view.currentPage = 0
        view.pageIndicatorTintColor = R.Colors.viewInactive
        view.currentPageIndicatorTintColor = R.Colors.viewActive
        return view
    }()
    
    let nextButton: UIButton = {
        let view = UIButton()
        view.setTitle("Continuу", for: .normal)
        view.backgroundColor = R.Colors.btnActive
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 25
        return view
    }()
    
    var pageViewController: UIPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupPageViewController()
        setupView()
    }
}

extension OnbordingPageViewController {
    private func setupView() {
        [pageControl, nextButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -58),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 52),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 485),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            pageControl.heightAnchor.constraint(equalToConstant: 8),
        ])
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    private func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                  navigationOrientation: .horizontal,
                                                  options: nil)
        
        if let firstViewController = viewControllerAtIndex(0) {
            pageViewController.setViewControllers([firstViewController],
                                                  direction: .forward,
                                                  animated: true,
                                                  completion: nil)
        }
        
        pageViewController.dataSource = self
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
    }
    
    @objc func nextButtonTapped() {
        currentIndex = (currentIndex + 1) % texts.count
        
        pageControl.currentPage = currentIndex
        if let nextViewController = viewControllerAtIndex(currentIndex) {
            pageViewController.setViewControllers([nextViewController],
                                                  direction: .forward,
                                                  animated: true,
                                                  completion: nil)
        }
    }
}

extension OnbordingPageViewController: UIPageViewControllerDataSource {
    func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        if index >= 0 && index < 3 {
            pageControl.isHidden = false
            let contentViewController = OnbordingBaseController(
                image: UIImage(named: textsImages[index]),
                text: texts[index],
                subtitle: subtitles[index])
            return contentViewController
        }else {
            let vc = StartFreeViewController()
            pageControl.isHidden = true
            nextButton.isHidden = true
            return vc
        }
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
