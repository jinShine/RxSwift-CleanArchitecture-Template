//
//  BindViewType.swift
//  RxTemplate
//
//  Created by Seungjin on 26/07/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift

public protocol BindViewType: class {
  associatedtype ViewModel
  
  var disposeBag: DisposeBag { get set }
  var viewModel: ViewModel? { get set }
  
  func state(viewModel: ViewModel)
  func command(viewModel: ViewModel)
  func binding(viewModel: ViewModel?)
}

// MARK: - disposeBag
private var disposeBagKey: String = "disposeBag"
extension BindViewType {
  
  public var disposeBag: DisposeBag {
    get {
      if let value = objc_getAssociatedObject(self,
                                              &disposeBagKey) as? DisposeBag {
        return value
      }
      
      let disposeBag = DisposeBag()
      
      objc_setAssociatedObject(self,
                               &disposeBagKey,
                               disposeBag,
                               objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      return disposeBag
    }
    
    set {
      objc_setAssociatedObject(self,
                               &disposeBagKey,
                               newValue,
                               objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
}

// MARK: - viewModel
private var viewModelKey: String = "viewModel"
extension BindViewType {
  
  public var viewModel: ViewModel? {
    get {
      if let value = objc_getAssociatedObject(self,
                                              &viewModelKey) as? ViewModel {
        return value
      }
      
      return nil
    }
    
    set {
      objc_setAssociatedObject(self,
                               &viewModelKey,
                               newValue,
                               objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      
      let viewController = self as? UIViewController
      viewController?.rx.methodInvoked(#selector(UIViewController.loadView))
        .asObservable()
        .map { _ in newValue }
        .subscribe(onNext: { [weak self] in
          guard let self = self else { return }
          self.binding(viewModel: $0)
        })
        .disposed(by: self.disposeBag)
    }
  }
  
  public func binding(viewModel: ViewModel?) {
    if let viewModel = viewModel {
      state(viewModel: viewModel)
      command(viewModel: viewModel)
    }
  }
}
