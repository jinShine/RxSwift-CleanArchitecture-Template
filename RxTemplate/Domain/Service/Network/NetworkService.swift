//
//  NetworkService.swift
//  RxTemplate
//
//  Created by Seungjin on 25/07/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import Moya
import Alamofire

struct NetworkService {
  
  static let shared = NetworkService()
  
  static private let sharedManager: Alamofire.SessionManager = {
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
    configuration.timeoutIntervalForRequest = 20
    configuration.timeoutIntervalForResource = 20
    configuration.requestCachePolicy = NSURLRequest.CachePolicy.useProtocolCachePolicy
    return Alamofire.SessionManager(configuration: configuration)
  }()
  
  private let provider: MoyaProvider<Router> = {
    let provider = MoyaProvider<Router>(endpointClosure: MoyaProvider.defaultEndpointMapping,
                                        requestClosure: MoyaProvider<Router>.defaultRequestMapping,
                                        stubClosure: MoyaProvider.neverStub,
                                        callbackQueue: nil,
                                        manager: sharedManager,
                                        plugins: [],
                                        trackInflights: false)
    return provider
  }()
  
  
  func buildRequest(to router: Router) -> Single<NetworkDataResponse> {
      return self.provider.rx.request(router)
        .flatMap { response -> Single<NetworkDataResponse> in
          return Single.create(subscribe: { single -> Disposable in
            let requestStatusCode = NetworkStatusCode(rawValue: response.response?.statusCode ?? 0)
            guard requestStatusCode != .unauthorized && requestStatusCode != .forbidden else {
              return single(.error(RequestError.invalidRequest)) as! Disposable
            }
            single(.success(NetworkDataResponse(jsonData: response.data,
                                                result: .success,
                                                error: nil)))
            
            return Disposables.create()
          })
        }
  }
  
}
