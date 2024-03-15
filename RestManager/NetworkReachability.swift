
import Foundation
import Alamofire

class NetworkReachability {
    // check for network connectivity using Alamofire
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
}
