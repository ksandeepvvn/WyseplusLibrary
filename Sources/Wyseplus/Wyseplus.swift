import Foundation
import UIKit
import WebKit

public class NetworkingCalls: NSObject {
    lazy var networking: Networking = {
        let networking = Networking(baseURL: "http://52.53.168.217:8080")
        return networking
    }()
       public func getAccessToken(onCompletion : @escaping (String) -> ()) {
        networking.setAuthorizationHeader(username: "phanitest", password: "testrandom123")
            networking.post("/oauth/token?grant_type=client_credentials", parameters: ["client_id" : "phanitest"]) { result in
                switch result
                            {
                            case .success( _):
                                onCompletion("Success")
                            case .failure(_):
                                onCompletion("Failure")
                }
            }
        }
    
    
    public func postEventTrigger(onCompletion : @escaping (String) -> ()) {
        networking.setAuthorizationHeader(token: "RhutzeRzr4mgla6UmvU7Xl2u7eg")
        networking.setAuthorizationHeader(headerKey: "tenantName", headerValue: "phanitest")
        networking.post("/track", parameters: [[
              "name": "Sandeep",
              "Organization": "Omniwyse"
            ],
            [
              "name": "Phani",
              "Organization": "NRKPJS"
            ]
          ]) { result in
             switch result
                         {
                         case .success( _):
                             onCompletion("Success")
                         case .failure(_):
                             onCompletion("Failure")
             }
         }
     }
}
