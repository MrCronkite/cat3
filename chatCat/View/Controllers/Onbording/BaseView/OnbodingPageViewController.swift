//
//  OnbodingPageViewController.swift
//  chatCat
//
//  Created by admin1 on 1.08.23.
//

import UIKit

final class OnbordingPageViewController: UIViewController, UIPageViewControllerDataSource {
    
    let pageControl: UIPageControl = {
        let view = UIPageControl()
        view.numberOfPages = 3
        //view.backgroundColor = .yellow
        view.currentPage = 0
        view.pageIndicatorTintColor = R.Colors.viewInactive
        view.currentPageIndicatorTintColor = R.Colors.viewActive
        // Создаем путь полуовала
                let ovalPath = UIBezierPath()
        let startPoint = CGPoint(x: view.bounds.midX, y: view.bounds.minY)
        let endPoint = CGPoint(x: view.bounds.midX, y: view.bounds.maxY)
        let controlPoint = CGPoint(x: view.bounds.midX + view.bounds.width * 0.5, y: view.bounds.midY)
                ovalPath.move(to: startPoint)
                ovalPath.addQuadCurve(to: endPoint, controlPoint: controlPoint)

                // Создаем CAShapeLayer и устанавливаем его путь и цвет заливки
                let shapeLayer = CAShapeLayer()
                shapeLayer.path = ovalPath.cgPath
                shapeLayer.fillColor = UIColor.blue.cgColor
        view.layer.addSublayer(shapeLayer)
        return view
    }()
    
    let nextButton = UIButton(type: .system)
    
    var pageViewController: UIPageViewController!
    var textsImages: [String] = ["catAndMe1", "catAndMe2", "catAndMe3", "cats"]
    var texts: [String] = ["Cat and human", "Speech simulation", "Have fun!", "Enjoy all features"]
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
        
        
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.frame = CGRect(x: view.bounds.width - 100, y: view.bounds.height - 100, width: 80, height: 40)
        view.addSubview(nextButton)
        
        view.addSubview(pageControl)
        
        setupView()
    }
    
    
        @objc func nextButtonTapped() {
            currentIndex = (currentIndex + 1) % texts.count
            
            pageControl.currentPage = currentIndex
            if let nextViewController = viewControllerAtIndex(currentIndex) {
                pageViewController.setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
            }
        }
    
    func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        if index >= 0 && index < texts.count {
            let contentViewController = OnbordingBaseController(image: UIImage(named: textsImages[index]), text: texts[index])
            
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

extension OnbordingPageViewController {
    private func setupView() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            pageControl.heightAnchor.constraint(equalToConstant: 68),
        ])
    }
}
