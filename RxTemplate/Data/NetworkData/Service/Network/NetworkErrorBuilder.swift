//
//  NetworkErrorBuilder.swift
//  RxTemplate
//
//  Created by Seungjin on 25/07/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift

struct NetworkErrorBuilder {

  static func networkError(from error: Error) -> NetworkError {
    let title = "error".localize
    let description = error.localizedDescription
    return NetworkError(title: title, description: description, error: nil)
  }
  
  static func networkError(from message: String?) -> NetworkError {
    let title = "error".localize
    let description = message ?? "error_general".localize
    return NetworkError(title: title, description: description, error: nil)
  }
  
  static func networkDataResponse(form message: String? = nil) -> NetworkDataResponse {
    let error = networkError(from: message)
    let response = NetworkDataResponse(jsonData: nil,
                                       result: .failure,
                                       error: error)

    return response
    
  }
}
