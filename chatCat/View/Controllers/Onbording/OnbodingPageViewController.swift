//
//  OnbodingPageViewController.swift
//  chatCat
//
//  Created by admin1 on 1.08.23.
//

import UIKit

final class OnbordingPageViewController: UIViewController {

    var currentIndex: Int = 0
    
    let pageControl: UIPageControl = {
        let view = UIPageControl()
        view.numberOfPages = 3
        view.currentPage = 0
        view.currentPageIndicatorTintColor = R.Colors.viewActive
        view.pageIndicatorTintColor = R.Colors.viewInactive
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
        view.backgroundColor = .white
        
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
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -28),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 52),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -280),
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
        pageViewController.delegate = self
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }
    
    @objc func nextButtonTapped() {
        currentIndex += 1
        pageControl.currentPage = currentIndex
        if let nextViewController = viewControllerAtIndex(currentIndex) {
            pageViewController.setViewControllers([nextViewController],
                                                  direction: .forward,
                                                  animated: true,
                                                  completion: nil)
        }
    }
}

extension OnbordingPageViewController: StartFreeViewControllerDelegate {
    func showButton() {
        UIView.animate(withDuration: 0.5) {
            self.pageControl.currentPageIndicatorTintColor = .white
            self.pageControl.pageIndicatorTintColor = .white
            self.nextButton.backgroundColor = .white
            self.nextButton.isHidden = true
            self.pageControl.isHidden = true
        }
        
    }
}

extension OnbordingPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        if index >= 0 && index < 3 {
            pageControl.isHidden = false
            let contentViewController = OnbordingBaseController(
                image: UIImage(named: R.Strings.Onboarding.textsImages[index]),
                text: R.Strings.Onboarding.texts[index],
                subtitle: R.Strings.Onboarding.subtitles[index])
            return contentViewController
        }else {
            let vc = StartFreeViewController()
            vc.delegate = self
            return vc
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = R.Strings.Onboarding.subtitles.firstIndex(of: (viewController.view.subviews.last as? UILabel)?.text ?? "") {
            let previousIndex = (index - 1 + R.Strings.Onboarding.subtitles.count) % R.Strings.Onboarding.subtitles.count
            if previousIndex < 3 {
                return viewControllerAtIndex(previousIndex)
            }
        } else if currentIndex == 3 {
            return viewControllerAtIndex(2)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = R.Strings.Onboarding.subtitles.firstIndex(of: (viewController.view.subviews.last as? UILabel)?.text ?? "") {
            pageControl.currentPage = index
            let nextIndex = (index + 1) % R.Strings.Onboarding.subtitles.count
            return viewControllerAtIndex(nextIndex)
        } else if currentIndex == 3 {
            return nil
        }
        return nil
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let viewController = pendingViewControllers.first, let index = R.Strings.Onboarding.subtitles.firstIndex(of: (viewController.view.subviews.last as? UILabel)?.text ?? "") {
            
            currentIndex = index
            pageControl.currentPage = currentIndex
            
            if index == 2 {
                UIView.animate(withDuration: 0.5) {
                    self.pageControl.currentPageIndicatorTintColor = R.Colors.viewActive
                    self.pageControl.pageIndicatorTintColor = R.Colors.viewInactive
                    self.nextButton.backgroundColor = R.Colors.btnActive
                    self.nextButton.isHidden = false
                    self.pageControl.isHidden = false
                }
            }
        }
    }
}


