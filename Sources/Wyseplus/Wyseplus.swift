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
        let request = NSMutableURLRequest(url: NSURL(string: Constants.TRACK_EVENT)! as URL)
        request.setValue("Bearer \("PFqGRrSTcXUPOGTZFhXY7Jd-V0k")", forHTTPHeaderField: "Authorization")
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
                   print(response)
               }
               if let data = data {
                   do {
                       let json = try JSONSerialization.jsonObject(with: data, options: [])
                       print(json)
                   } catch {
                       print(error)
                   }
               }
           }.resume()
        
     }
}
