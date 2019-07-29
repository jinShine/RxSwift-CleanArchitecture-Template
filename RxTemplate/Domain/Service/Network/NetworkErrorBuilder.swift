//
//  NetworkErrorBuilder.swift
//  RxTemplate
//
//  Created by Seungjin on 25/07/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift

struct NetworkErrorBuilder {
  
//  static func networkError(from response: JSON?, error: Error?) -> NetworkError? {
//    let errorDescription = errroDescription(from: response)
//    let title = FLLocalizedString("error")
//    var networkError: NetworkError?
//    if error != nil || errorDescription != nil {
//      let description = (errorDescription != nil ? errorDescription : error?.localizedDescription) ?? title
//      networkError = NetworkError(title: title, description: description, error: error)
//    }
//
//    return networkError
//  }
//
//  private static func errroDescription(from response: JSON?) -> String? {
//    var errroDescription: String?
//    if let message = response?["errors"].string {
//      errroDescription = message
//    }
//    else if let message = response?["message"].string {
//      errroDescription = message
//    }
//    else if let message = response?["message"]["description"].string {
//      errroDescription = message
//    }
//
//    return errroDescription
//  }
  
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
