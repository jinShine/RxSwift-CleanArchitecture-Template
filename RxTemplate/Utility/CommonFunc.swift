//
//  CommonFunc.swift
//  FoodFlyUserApp
//
//  Created by Seungjin on 25/07/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

func Log(_ log: Any) {
    #if DEBUG
    print(log)
    #endif
}

func DebugLog(_ log: Any) {
    #if DEBUG
    print(log)
    #endif
}

func isIphoneXScreen() -> Bool {
    guard #available(iOS 11.0, *) else { return false }
    return UIApplication.shared.windows[0].safeAreaInsets != UIEdgeInsets.zero
}

func openURL(url: URL) {
    if #available(iOS 10.0, *) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

func hideNavigationBarDividerLine(bar: UINavigationBar?) {
    bar?.shadowImage = UIImage()
    bar?.setBackgroundImage(UIImage(), for: .default)
}
