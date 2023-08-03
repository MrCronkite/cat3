//
//  R.swift
//  chatCat
//
//  Created by admin1 on 1.08.23.
//

import UIKit

enum R {
    enum Colors {
        static let btnActive = UIColor(hex: "#EDAE5D")
        static let viewActive = UIColor(hex: "#738FF5")
        static let viewInactive = UIColor(hex: "#B9C7FA")
        static let bgColor = UIColor(hex: "#fdf5ec")
        static let subtitle = UIColor(hex: "#9C9C9C")
        static let bgImg = UIColor(hex: "#F7D6DE")
        static let bgSettingd = UIColor(hex: "#F6F6F4")
        static let tintColor = UIColor(hex: "#DADADA")
        static let borderCircle = UIColor(hex: "#e4eafd")
        static let borderCircle1 = UIColor(hex: "#f0f4fe")
    }
    
    enum Strings {
        enum TabBar {
            static func title(for tab: Tabs) -> String {
                switch tab {
                case .chat: return "Chat"
                case .emotions: return "Emotions"
                case .notes: return "Notes"
                case .whistle: return "Whistle"
                }
            }
        }
        
        enum Onboarding {
            static let title1 = "Cat and human"
            static let subtitle1 = "Simulation of human and cat speech and vice versa"
            static let title2 = "Speech simulation"
            static let subtitle2 = "Express any emotion to your cat"
            static let title3 = "Have fun!"
            static let subtitle3 = "Make friends with your pets"
        }
        
        enum Whistle {
            static let textDirection = "First decide which training teams. Do you want to use whistle and how will you transmit these commands to your cat. For example, you may want your cat to sit down when it hears one short whistle, or come up when it hears three short whistles. It's best to start by pairing the whistle with one command at a time to avoid confusion."
            static let textDirection1 = "Then pair the whistle with a verbal command your cat already knows, such as 'sit.' It's best to start in areas with few distractions and keep your workouts short. Each time you order the cat to sit, press the whistle to make a quick sound. Praise the cat when it sits down and repeat. Continue giving a quick verbal command followed by a whistle."
            static let textDirection2 = "The next step is to blow the whistle just before giving the verbal command. With enough practice, your cat will begin to associate whistling with the behavior you want her to do and won't need verbal commands. We recommend training in a variety of environments with different levels of distraction to help your cat learn the whistle command."
        }
    }
    
    enum Images {
        
        enum TabBar {
            static func icon(for tab: Tabs) -> UIImage? {
                switch tab {
                case .chat: return UIImage(named: "chat")
                case .emotions: return UIImage(named: "emotions")
                case .notes: return UIImage(named: "notes")
                case .whistle: return UIImage(named: "whistle")
                }
            }
        }
        enum Notes {
            static let picCat = UIImage(named: "catMeew")
        }
        
        enum Emotions {
            static let volumeUp = UIImage(named: "VolumeUp")
        }
        
        enum Onboarding {
            static let pawCat1 = UIImage(named: "paw1")
            static let pawCat2 = UIImage(named: "paw2")
            static let pawCat3 = UIImage(named: "paw3")
            static let catPic1 = UIImage(named: "catPic1")
            static let catPic2 = UIImage(named: "catPic2")
            static let catPic3 = UIImage(named: "catPic3")
        }
        
        enum Chat {
            static let catImg = UIImage(named: "catImage")
            static let meImg = UIImage(named: "meImage")
            static let pauseImg = UIImage(named: "stopPlay")
            static let micro = UIImage(named: "micro")
            static let pauseImg130 = UIImage(named: "pause130")
            static let micro130 = UIImage(named: "play130")
            static let reboot = UIImage(named: "reboot")
        }
    }
    
    enum Fonts {
            static func helvelticaRegular(with size: CGFloat) -> UIFont {
                UIFont(name: "AVArela", size: size) ?? UIFont()
            }
        }
}
