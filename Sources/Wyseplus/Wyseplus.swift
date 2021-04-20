import Foundation
import UIKit
import WebKit

public class MediumWebView: WKWebView {
    
    public init() {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.preferences.javaScriptEnabled = true
        super.init(frame: .zero, configuration: webConfiguration)
        self.scrollView.isScrollEnabled = false
        self.isMultipleTouchEnabled = false
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    public func loadRe() {
      print("Test",getRequest())
    }
    
    lazy var networking: Networking = {
        let networking = Networking(baseURL: "http://52.53.168.217:8080")
        return networking
    }()
    
    public func getRequest() -> [String]
    {
        networking.post("/oauth/token?grant_type=client_credentials", parameters: ["client_id" : "phanitest"]) { result in
         
            print("Result is ", result)
        }
        return ["San"]
    }
}
