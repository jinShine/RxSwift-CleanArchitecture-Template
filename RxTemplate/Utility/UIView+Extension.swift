//
//  UIView+Extension.swift
//  RxTemplate
//
//  Created by Seungjin on 29/07/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

extension UIView {
  
  static var reuseIdentifier: String {
    let nameSpaceClassName = NSStringFromClass(self)
    guard let className = nameSpaceClassName.components(separatedBy: ".").last else {
      return nameSpaceClassName
    }
    return className
  }
  
  
  class func newFromNib() -> UIView? {
    guard let view = Bundle.main.loadNibNamed(self.reuseIdentifier, owner: nil, options: nil)?.first as? UIView else {
      
      return nil
    }
    return view
  }
  
  class func nib() -> UINib {
    return UINib(nibName: self.reuseIdentifier, bundle: nil)
  }
}
