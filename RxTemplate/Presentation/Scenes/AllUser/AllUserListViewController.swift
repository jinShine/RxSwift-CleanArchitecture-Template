//
//  AllUserListViewController.swift
//  RxTemplate
//
//  Created by Seungjin on 26/07/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources
import Kingfisher

final class AllUserListViewController: BaseViewController, BindViewType {

  //MARK: - Constant
  struct Constant {
    static let rowHeight: CGFloat = 80
  }
  
  
  //MARK: - UI Properties
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var indicator: UIActivityIndicatorView!
  let refreshControl = UIRefreshControl()
  
  
  //MARK: - Properties
  typealias ViewModel = AllUserListViewModel
  var disposeBag = DisposeBag()
  var dataSource: RxTableViewSectionedReloadDataSource<SectionOfUserModel>?
  
  
  
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
  
  //OUTPUT
  func command(viewModel: AllUserListViewModel) {
    
    let obViewDidLoad = rx.viewDidLoad.map {
      ViewModel.Command.viewDidLoad
    }
    
    let obRequestUserList = rx.viewWillAppear.map { _ in
      ViewModel.Command.requestUserList
    }
    
    let obDidPagination = tableView.rx.willDisplayCell
      .map { ViewModel.Command.didPagination(cell: $0.cell, indexPath: $0.indexPath) }
//
    
    let obDidPullRefresh = refreshControl.rx.controlEvent(.valueChanged)
      .map { ViewModel.Command.didPullRefresh }
    
    
    Observable<ViewModel.Command>
      .merge([
        obViewDidLoad,
        obRequestUserList,
        obDidPagination,
        obDidPullRefresh])
      .bind(to: viewModel.command)
      .disposed(by: self.disposeBag)
    
  }
  
  
  //INPUT
  func state(viewModel: AllUserListViewModel) {

    self.dataSource = RxTableViewSectionedReloadDataSource<SectionOfUserModel>(
      configureCell: { (datasource, tableView, indexPath, item) -> UITableViewCell in
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: AllUserListCell.reuseIdentifier, for: indexPath) as? AllUserListCell {
          cell.viewModel = AllUserListCellViewModel(model: item)
          return cell
        }
        return UITableViewCell()
    })
    
    viewModel.state
      .drive(onNext: { [weak self] state in
        guard let self = self else { return }
        
        switch state {
        case .viewDidLoadState:
          self.setupTableView()
          
        case .requestUserListState:
          viewModel.allUserList
            .bind(to: self.tableView.rx.items(dataSource: self.dataSource!))
            .disposed(by: self.disposeBag)

        case .didPaginationState: return
          
        case .showRefreshingState(let isRefreshing):
          if !isRefreshing {
            self.indicator.stopAnimating()
            self.indicator.hidesWhenStopped = !isRefreshing
            self.tableView.refreshControl?.endRefreshing()
          } else {
            self.indicator.startAnimating()
          }
          
        case .didPullRefreshState: return
          
        }
      })
      .disposed(by: self.disposeBag)
  }
  
}


//MARK: - Method Handler
extension AllUserListViewController {
  
  private func setupTableView() {
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.estimatedRowHeight = Constant.rowHeight
    self.tableView.refreshControl = self.refreshControl
    //self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
  }
  
}
