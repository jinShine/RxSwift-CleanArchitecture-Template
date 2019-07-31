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
  
  
  //MARK: - Unidirection
  
  enum Command {
    case viewDidLoad
    case requestUserList
    case didPagination(cell: UITableViewCell, indexPath: IndexPath)
    case didPullRefresh
  }
  
  enum Action {
    case viewDidLoadAction
    case requestUserListAction
    case didPaginationAction(cell: UITableViewCell, indexPath: IndexPath)
    case didPullRefreshAction
  }
  
  enum State {
    case viewDidLoadState
    case requestUserListState
    case didPaginationState
    case showRefreshingState(_ isRefreshing: Bool)
    case didPullRefreshState
  }
  
  var command = PublishSubject<Command>()
  var state = Driver<State>.empty()
  var stateSubject = PublishSubject<State>()
  var allUserList = BehaviorRelay<[SectionOfUserModel]>(value: [])
  
  
  
  //MARK: - Properties
  
  private var list: [SectionOfUserModel] = []
  private var pagePerCount = Constant.pagePerCount
  private let allUserUseCase: AllUserUseCase
  
  
  
  //MARK: - Initialize
  init(allUserUseCase: AllUserUseCase) {
    self.allUserUseCase = allUserUseCase
    self.bind()
  }
  
  
  //MARK: - Unidirection Action
  
  func toAction(from command: Command) -> Observable<Action> {
    switch command {
    case .viewDidLoad:
      return Observable<Action>.just(.viewDidLoadAction)
    case .requestUserList:
      return Observable<Action>.just(.requestUserListAction)
    case .didPagination(let cell, let indexPath):
      return Observable<Action>.just(.didPaginationAction(cell: cell, indexPath: indexPath))
    case .didPullRefresh:
      return Observable<Action>.just(.didPullRefreshAction)
    }
  }
  
  func toState(from action: Action) -> Observable<State> {
    switch action {
    case .viewDidLoadAction:
      return Observable<State>.just(.viewDidLoadState)
      
    case .requestUserListAction:
      return fetchUserList()
      
    case .didPaginationAction(_, let indexPath):
      guard indexPath.row + 1 == self.pagePerCount else {
        return Observable<State>.just(.didPaginationState)
      }
      
      pagePerCount += Constant.pagePerCount
      
      return allUserUseCase.allUser(since: pagePerCount)
        .do { self.showRefreshing(true) }
        .observeOn(ConcurrentDispatchQueueScheduler(qos: .default))
        .map { [weak self] userModel -> [SectionOfUserModel] in
          userModel.forEach { self?.list[0].items.append($0) }
          return [SectionOfUserModel(header: "", items: self?.list[0].items ?? [])]}
        .map { [weak self] in self?.allUserList.accept($0) }
        .flatMap { [weak self] _ in
          return Single<State>.just(.didPaginationState)
            .retry(2)
            .do { self?.showRefreshing(false) }
        }.asObservable()
      
    case .didPullRefreshAction:
      return fetchUserList()
      
    }
  }
  
}

//MARK: - Method Handler
extension AllUserListViewModel {
  
  private func showRefreshing(_ isRefreshing: Bool) {
    self.stateSubject
      .onNext(.showRefreshingState(isRefreshing))
  }
  
  private func fetchUserList() -> Observable<State> {
    return allUserUseCase.allUser(since: 0)
      .do { self.showRefreshing(true) }
      .observeOn(ConcurrentDispatchQueueScheduler(qos: .default))
      .map { usermodels -> [SectionOfUserModel] in
        return [SectionOfUserModel(header: "", items: usermodels)]
      }
      .flatMap { [weak self] userListSection in
        self?.list = userListSection
        self?.allUserList.accept(userListSection)
        return Single<State>.just(.requestUserListState)
          .retry(2)
          .do { self?.showRefreshing(false) }
      }.asObservable()
  }
  
}
