import Foundation
import UIKit
import WebKit

public class NetworkingCalls: NSObject {
    var defaults = UserDefaults.standard
    lazy var networking: Networking = {
        let networking = Networking(baseURL: Constants.BASE_URL)
        return networking
    }()
       public func getAccessToken(onCompletion : @escaping (String) -> ()) {
        networking.setAuthorizationHeader(username: "phanitest", password: "testrandom123")
        networking.post(Constants.OAUTH_URL, parameters: [Constants.ClIENTID : "phanitest"]) { result in
                switch result
                            {
                            case .success( _):
                                self.defaults.set("ABC", forKey: Constants.ACCESS_TOKEN)
                                onCompletion(Constants.SUCCESS_RESPONSE)
                            case .failure(_):
                                self.defaults.set("ABC", forKey: Constants.ACCESS_TOKEN)
                                onCompletion(Constants.FAILURE_RESPONSE)
                }
            }
        }
    
    public func getAccessToken() -> String
    {
        if let access_Token = self.defaults.value(forKey: Constants.ACCESS_TOKEN) as? String{
            return access_Token
        }
        return ""
    }
    
    public func postEventTrigger(params: [[String : String]]?,onCompletion : @escaping (String) -> ()) {
        networking.setAuthorizationHeader(token: "RhutzeRzr4mgla6UmvU7Xl2u7eg")
//        networking.setAuthorizationHeader(headerKey: Constants.TENANT_NAME, headerValue: "phanitest")
        networking.headerFields = [Constants.TENANT_NAME: "phanitest"]
        networking.post(Constants.TRACK_EVENT, parameters: params) { result in
             switch result
                         {
                         case .success( _):
                             onCompletion(Constants.SUCCESS_RESPONSE)
                         case .failure(_):
                             onCompletion(Constants.FAILURE_RESPONSE)
             }
         }
     }
}
