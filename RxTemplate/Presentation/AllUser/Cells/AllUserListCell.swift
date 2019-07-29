//
//  AllUserListCell.swift
//  RxTemplate
//
//  Created by Seungjin on 26/07/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa

final class AllUserListCell: UITableViewCell {
  
  @IBOutlet weak var id: UILabel!
  @IBOutlet weak var nickName: UILabel!
  @IBOutlet weak var profileImage: UIImageView!
  
  
  var viewModel: AllUserListCellViewModel! {
    didSet {
      id.text = "\(viewModel.id ?? 0)"
      nickName.text = viewModel.name
      if let profile = viewModel.profileImage,
        let url = URL(string: profile) {
          profileImage.kf.setImage(with: url)
      }
    }
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  

}

