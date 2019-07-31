//
//  CommonExtension.swift
//  FoodFlyUserApp
//
//  Created by Seungjin on 25/07/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation
import UIKit
import MessageUI


//MARK: - UIStroyBoard

extension UIStoryboard {
	public class func create<T: UIViewController> (_: T.Type,
												   name: String = "Main",
												   bundle: Bundle? = nil,
												   identifier: String? = nil ) -> T {
		let storyboard = self.init(name: name, bundle: bundle)
		
		let withIndentifier = identifier ?? T.description().components(separatedBy: ".").last!
		return (storyboard.instantiateViewController(withIdentifier: withIndentifier) as? T)!
	}
}


//MARK: - UIAlertController

extension UIAlertController {
	static func make(title: String? = nil,
					 message: String? = nil,
           style: UIAlertController.Style,
					 ok: String? = nil,
					 okClosure: ((UIAlertAction) -> Void)? = nil,
					 cancel: String? = nil,
					 cancelClosure: ((UIAlertAction) -> Void)? = nil,
					 sheet: UIAlertAction...) -> UIAlertController {
		let alert = UIAlertController(title: title, message: message, preferredStyle: style)
		
		if ok != nil {
			alert.addAction(UIAlertAction(title: ok, style: .default, handler: okClosure))
		}
		
		if cancel != nil {
			alert.addAction(UIAlertAction(title: cancel, style: .cancel, handler: cancelClosure))
		}
		
		for value in sheet {
			alert.addAction(value)
		}
		return alert
	}
	
	func alertShow(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil ) {
		viewController.present(self, animated: animated, completion: completion)
	}
}


//MARK: - 스트링 로컬라이제이션 적용
extension String {
  var localize: String {
    return NSLocalizedString(self, comment: self)
  }
}
