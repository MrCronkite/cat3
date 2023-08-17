//
//  PreviewViewController.swift
//  chatCat
//
//  Created by admin1 on 5.08.23.
//

import UIKit
import GoogleMobileAds
import Lottie

final class PreviewViewController: UIViewController, GADBannerViewDelegate {
    
    var timer: Timer?
    
    @IBOutlet weak var loadViewBar: UIView!
    
    private let banner: GADBannerView = {
        let banner = GADBannerView()
        banner.adUnitID = "ca-app-pub-9036313325916079/1525004192"
        banner.load(GADRequest())
        banner.backgroundColor = .secondarySystemBackground
        return banner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.Colors.btnActive
        
        banner.rootViewController = self
        banner.delegate = self
        view.backgroundColor = R.Colors.bgColor
        view.addSubview(banner)
        
        let animationView = LottieAnimationView(name: "cat_loader")
        animationView.frame = loadViewBar.frame
        animationView.loopMode = .loop // или .playOnce для воспроизведения один раз
        animationView.animationSpeed = 1// Скорость анимации
        view.addSubview(animationView)
        
        animationView.play()
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(timerFinished), userInfo: nil, repeats: false)
    }
    
    @objc func timerFinished() {
           let vc = OnbordingPageViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("Баннер загрузил рекламу")
    }
    
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print("Баннер не смог загрузить рекламу: \(error.localizedDescription)")
    }
}
