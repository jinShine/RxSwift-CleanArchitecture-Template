//
//  Router.swift
//  RxTemplate
//
//  Created by Seungjin on 25/07/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Moya

enum Router {
  case allUser(since: Int)
}

enum RouterError: Error {
  case message
}


extension Router: TargetType {

  // GitHub Key
  static let clientID: String = "075f9bae947051708b29"
  static let clientSecret: String = "e5593a561341875f9a5a768bca8d74b398aff81e"
  
  var baseURL: URL {
    #if DEBUG
    return URL(string: "https://api.github.com")!
    #else
    return URL(string: "https://api.github.com")!
    #endif
    
  }
  
  var path: String {
    switch self {
    case .allUser:
      return "/users"
    }
  }
  
  var method: Method {
    switch self {
    case .allUser:
      return .get
    }
  }
  
  var parameters: [String: Any]? {
    switch self {
    case .allUser(let since):
      return [
        "since" : since,
        "client_id" : Router.clientID,
        "client_secret" : Router.clientSecret
      ]
    }
  }
  
  var task: Task {
    switch self {
    case .allUser:
      return .requestParameters(parameters: parameters!, encoding: URLEncoding.default)
    }
  }
  
  var headers: [String : String]? {
    switch self {
    case .allUser:
      return [:]
    }
  }
  
  var sampleData: Data {
    return "data".data(using: String.Encoding.utf8)!
  }
}

//MARK: - Error
extension RouterError: CustomStringConvertible {
  var description: String {
    switch self {
    case .message:
      return "NetworkErrorMessageBody".localize
    }
  }
}

