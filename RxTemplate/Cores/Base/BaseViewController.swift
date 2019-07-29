//
//  BaseViewController.swift
//  RxTemplate
//
//  Created by Seungjin on 26/07/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
  
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  deinit {
    print("DEINIT: \(String(describing: self))")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
}
