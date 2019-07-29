//
//  AllUserListViewController.swift
//  RxTemplate
//
//  Created by Seungjin on 26/07/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa

final class AllUserListViewController: BaseViewController, BindViewType {

  
  //MARK: - UI Properties
  @IBOutlet weak var tableView: UITableView!
  
  
  //MARK: - Properties
  typealias ViewModel = AllUserListViewModel
  var disposeBag = DisposeBag()
  var userModels: [UserModel] = []
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  init(viewModel: ViewModel) {
    defer {
      self.viewModel = viewModel
    }
    super.init()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
}

//MARK: - Bind
extension AllUserListViewController {
  
  func command(viewModel: AllUserListViewModel) {
    
    let obViewDidLoad = rx.viewDidLoad.map {
      ViewModel.Command.viewDidLoad
    }
    
    let obUserList = rx.viewWillAppear.map { _ in
      ViewModel.Command.getUserList
    }
    
    
    
    Observable<ViewModel.Command>
      .merge([
        obViewDidLoad,
        obUserList])
      .bind(to: viewModel.command)
      .disposed(by: self.disposeBag)
    
  }
  
  
  func state(viewModel: AllUserListViewModel) {
    
    viewModel.state
      .drive(onNext: { [weak self] state in
        guard let self = self else { return }
        
        switch state {
        case .viewDidLoadState:
          self.tableView.delegate = self
          self.tableView.dataSource = self
          
        case .getUserListState(let userModels):
          print(userModels)
          self.userModels = userModels
          self.tableView.reloadData()
        }
        
      })
      .disposed(by: self.disposeBag)
  }
  
}

extension AllUserListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return userModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? AllUserListCell else { return UITableViewCell() }
    cell.textLabel?.text = "1"
    return cell
  }
}

extension AllUserListViewController: UITableViewDelegate {
  
}
