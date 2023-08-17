//
//  AppDelegate.swift
//  chatCat
//
//  Created by admin1 on 1.08.23.
//

import UIKit
import Firebase
import AppsFlyerLib
import GoogleMobileAds

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        AppsFlyerLib.shared().appsFlyerDevKey = "YOUR_DEV_KEY"
        AppsFlyerLib.shared().appleAppID = "YOUR_APP_ID"
        AppsFlyerLib.shared().delegate = self
        AppsFlyerLib.shared().isDebug = true // Опционально для отладки
        
        GADMobileAds.sharedInstance().start()
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ GADSimulatorID ]
        
        return true
    }
}

extension AppDelegate: AppsFlyerLibDelegate {
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        // Этот метод вызывается при успешном получении данных о конверсии
        
        // Выводим в консоль полученные данные
        print("Conversion data success: \(conversionInfo)")
        
        // Здесь вы можете анализировать conversionInfo и выполнять нужные действия
        // в зависимости от полученных данных.
        
        // Пример: извлечь значение определенного ключа
        if let mediaSource = conversionInfo["media_source"] as? String {
            print("Media Source: \(mediaSource)")
        }
    }
    
    func onConversionDataFail(_ error: Error) {
        // Этот метод вызывается при неудачном получении данных о конверсии
        
        // Выводим в консоль информацию об ошибке
        print("Conversion data failed with error: \(error.localizedDescription)")
        
        // Здесь вы можете обработать ошибку, например, предпринять какие-либо действия
        // для повторной попытки получения данных или уведомить пользовате
    }
}

