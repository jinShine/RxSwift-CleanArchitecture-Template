//
//  AllUserListViewModel.swift
//  RxTemplate
//
//  Created by Seungjin on 26/07/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa

final class AllUserListViewModel: BindViewModelType {
  
  enum Command {
    case viewDidLoad
    case getUserList
  }
  
  enum Action {
    case viewDidLoadAction
    case getUserListAction
  }
  
  enum State {
    case viewDidLoadState
    case getUserListState(usemodels: [UserModel])
  }
  
  var command = PublishSubject<Command>()
  var state = Driver<State>.empty()
  var stateSubject = PublishSubject<State>()
  
  let allUserUseCase: AllUserUseCase
  
  init(allUserUseCase: AllUserUseCase) {
    self.allUserUseCase = allUserUseCase
    self.bind()
  }
  
  

  func toAction(from command: Command) -> Observable<Action> {
    switch command {
    case .viewDidLoad:
      print("Test Rotation")
      return Observable<Action>.just(.viewDidLoadAction)
    case .getUserList:
      return Observable<Action>.just(.getUserListAction)
    }
  }
  
  func toState(from action: Action) -> Observable<State> {
    switch action {
    case .viewDidLoadAction:
      return Observable<State>.just(.viewDidLoadState)
    case .getUserListAction:
      return allUserUseCase.allUser(since: 1)
        .flatMap { userModels in
          return Single<State>.just(.getUserListState(usemodels: userModels))
        }.asObservable()
      
    }
  }
  
}
