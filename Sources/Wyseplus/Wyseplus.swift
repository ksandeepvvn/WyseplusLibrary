import Foundation
import UIKit
import WebKit

public class NetworkingCalls: NSObject {
    var defaults = UserDefaults.standard
    lazy var networking: Networking = {
        let networking = Networking(baseURL: Constants.BASE_URL)
        return networking
    }()
       public func generateAccessToken(onCompletion : @escaping (String) -> ()) {
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
    
    public func getLoginCredentialsAuthValue(username: String, password: String) -> String
    {
        let credentialsString = "\(username):\(password)"
        var authString : String = ""
        if let credentialsData = credentialsString.data(using: .utf8) {
            let base64Credentials = credentialsData.base64EncodedString(options: [])
            authString = "Basic \(base64Credentials)"
            return authString
        }
        return authString
    }
    
    public func getAccessToken() -> String
    {
        if let access_Token = self.defaults.value(forKey: Constants.ACCESS_TOKEN) as? String{
            return access_Token
        }
        return ""
    }
    
    public func postEventTrigger(params: [[String : String]]?,onCompletion : @escaping (String) -> ()) {
        let request = NSMutableURLRequest(url: NSURL(string: Constants.TRACK_EVENT)! as URL)
        request.setValue("Bearer \(getAccessToken())", forHTTPHeaderField: "Authorization")
        request.setValue("phanitest", forHTTPHeaderField: Constants.TENANT_NAME)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params as Any, options: []) else {
               return
           }
           request.httpBody = httpBody
           let session = URLSession.shared
            session.dataTask(with: request as URLRequest) { (data, response, error) in
               if let response = response {
                guard let httpResponse = response as? HTTPURLResponse else {return}
                switch httpResponse.statusCode {
                case 200:
                    onCompletion(Constants.SUCCESS_RESPONSE)
                default:
                    onCompletion(Constants.FAILURE_RESPONSE)
                }
               }
           }.resume()
     }
}
