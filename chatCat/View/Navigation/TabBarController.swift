//
//  TabBarController.swift
//  chatCat
//
//  Created by admin1 on 1.08.23.
//

import UIKit

enum Tabs: Int, CaseIterable {
    case chat
    case emotions
    case notes
    case whistle
}

final class TabBarController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        configure()
        swichTo(tab: .notes)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func swichTo(tab: Tabs) {
        selectedIndex = tab.rawValue
    }
    
    private func configure() {
        tabBar.tintColor = R.Colors.btnActive
        tabBar.barTintColor = R.Colors.btnActive
        tabBar.layer.borderColor = UIColor.black.cgColor
        tabBar.layer.masksToBounds = true
        
        let controllers: [UINavigationController] = Tabs.allCases.map { tab in
            let controller = UINavigationController(rootViewController: getController(for: tab))
            controller.tabBarItem = UITabBarItem(title: R.Strings.TabBar.title(for: tab),
                                                 image: R.Images.TabBar.icon(for: tab),
                                                 tag: tab.rawValue)
            return controller
        }
        
        setViewControllers(controllers, animated: false)
    }
    
    private func getController(for tab: Tabs) -> UIViewController {
        switch tab {
        case .chat: return ChatViewController()
        case .whistle: return WhistleViewController()
        case .emotions: return EmotionsViewController()
        case .notes: return NotesViewController()
        }
    }
}
