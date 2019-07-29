//
//  BindViewModelType.swift
//  RxTemplate
//
//  Created by Seungjin on 26/07/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa

public protocol BindViewModelType: class {
  associatedtype Command
  associatedtype Action
  associatedtype State
  
  var command: PublishSubject<Command> { get }
  var stateSubject: PublishSubject<State> { get }
  var state: Driver<State> { get set }
  
  func toAction(from command: Command) -> Observable<Action>
  func toState(from action: Action) -> Observable<State>
}

extension BindViewModelType {
  
  func bind() {
  
    state = Observable<State>.merge(self.stateSubject.asObserver(),
                                    self.command
                                      .flatMapLatest { self.toAction(from: $0) }
                                      .flatMapLatest { self.toState(from: $0) }
      ).asDriver { error in
        return Driver.empty()
    }
  }
  
}
