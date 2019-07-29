//
//  CommonReactive.swift
//  FoodFlyUserApp
//
//  Created by Seungjin on 25/07/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UIImageView {
    public var isHighlight: Binder<Bool> {
        return Binder(self.base) { view, highlight in
            view.isHighlighted = highlight
        }
    }
}

extension Reactive where Base: UIControl {
    public var tap: ControlEvent<Void> {
        return controlEvent(.touchUpInside)
    }
}

extension Reactive where Base: UICollectionViewFlowLayout {
    public var footerSize: Binder<CGSize> {
        return Binder(self.base) { view, size in
            view.footerReferenceSize = size
        }
    }
}

extension Reactive where Base: UIButton {
    public var selectedTitle: Binder<(title: String, selectedText: String)> {
        return Binder(self.base) { view, value in
            view.setTitle(value.title, for: .normal)
            view.isSelected = (value.title != value.selectedText)
            
        }
    }
}

extension Reactive where Base: UIViewController {
    
    func popToRootVC(animated: Bool = true) -> Binder<Void> {
        return Binder(self.base) { (view, _) in
            view.navigationController?.popToRootViewController(animated: animated)
        }
    }
    
    func popToVC(animated: Bool = true) -> Binder<UIViewController> {
        return Binder(self.base) { (view, vc)  in
            view.navigationController?.popToViewController(vc, animated: animated)
        }
    }
    
    func popVC(animated: Bool = true) -> Binder<Void> {
        return Binder(self.base) { (view, _)  in
            view.navigationController?.popViewController(animated: animated)
        }
    }
    
//    func pushVC(animated: Bool = true) -> Binder<ProvideObject> {
//        return Binder(self.base) { (view, object) in
//            view.navigationController?.pushViewController(object.viewController, animated: animated)
//        }
//    }
  
    func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) -> Binder<Void> {
        return Binder(self.base) { (view, _)  in
            view.dismiss(animated: animated, completion: completion)
        }
    }
    
//    func present(_ animated: Bool = true, completion: (() -> Void)? = nil) -> Binder<ProvideObject> {
//        return Binder(self.base) { (view, object) in
//            view.present(object.viewController, animated: animated, completion: completion)
//        }
//    }
}

extension ObservableType {
  
  func catchErrorJustEmpty() -> Observable<E> {
    return catchError { _ in
      return Observable.empty()
    }
  }
  
  func asDriverOnErrorJustEmpty() -> Driver<E> {
    return asDriver { error in
      return Driver.empty()
    }
  }
  
  func mapToVoid() -> Observable<Void> {
    return map { _ in }
  }
}
