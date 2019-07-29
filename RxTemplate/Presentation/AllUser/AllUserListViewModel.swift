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
  
  //MARK: - Constant
  struct Constant {
    static let pagePerCount = 30
  }
  
  enum Command {
    case viewDidLoad
    case getUserList
    case pagination(cell: UITableViewCell, indexPath: IndexPath)
  }
  
  enum Action {
    case viewDidLoadAction
    case getUserListAction
    case paginationAction(cell: UITableViewCell, indexPath: IndexPath)
  }
  
  enum State {
    case viewDidLoadState
    case getUserListState
    case paginationState
  }
  
  var command = PublishSubject<Command>()
  var state = Driver<State>.empty()
  var stateSubject = PublishSubject<State>()
  var allUserList = BehaviorRelay<[SectionOfUserModel]>(value: [])
  
  private var list: [SectionOfUserModel] = []
  private var pagePerCount = Constant.pagePerCount
  private let allUserUseCase: AllUserUseCase
  
  init(allUserUseCase: AllUserUseCase) {
    self.allUserUseCase = allUserUseCase
    self.bind()
  }
  
  

  func toAction(from command: Command) -> Observable<Action> {
    switch command {
    case .viewDidLoad:
      return Observable<Action>.just(.viewDidLoadAction)
    case .getUserList:
      return Observable<Action>.just(.getUserListAction)
    case .pagination(let cell, let indexPath):
      return Observable<Action>.just(.paginationAction(cell: cell, indexPath: indexPath))
    }
  }
  
  func toState(from action: Action) -> Observable<State> {
    switch action {
    case .viewDidLoadAction:
      return Observable<State>.just(.viewDidLoadState)
      
    case .getUserListAction:
      return allUserUseCase.allUser(since: 0)
        .observeOn(ConcurrentDispatchQueueScheduler(qos: .default))
        .map { usermodels -> [SectionOfUserModel] in
          return [SectionOfUserModel(header: "", items: usermodels)]
        }
        .flatMap { [weak self] userListSection in
          self?.list = userListSection
          self?.allUserList.accept(userListSection)
          return Single<State>.just(.getUserListState).retry(2)
        }.asObservable()
      
    case .paginationAction(_, let indexPath):
      guard indexPath.row + 1 == self.pagePerCount else {
        return Observable<State>.just(.paginationState)
      }
      print(pagePerCount)
      pagePerCount += Constant.pagePerCount
      return allUserUseCase.allUser(since: pagePerCount)
        .observeOn(ConcurrentDispatchQueueScheduler(qos: .default))
        .map { [weak self] userModel -> [SectionOfUserModel] in
          userModel.forEach { self?.list[0].items.append($0) }
          return [SectionOfUserModel(header: "", items: self?.list[0].items ?? [])]}
        .map { [weak self] in self?.allUserList.accept($0) }
        .flatMap { _ in
          return Single<State>.just(.paginationState).retry(2) }
        .asObservable()
    }
  }
  
}
