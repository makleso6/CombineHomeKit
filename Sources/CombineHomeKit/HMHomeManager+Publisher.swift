import Foundation
import HomeKit
import Combine

extension HMHomeManager {
    
    /// Returns ```HMHomeManager``` wrapper.
    /// Note: ```HMHomeManager``` instance does not keep strong reference to ```HMHomeManagerPublisher``` instance.
    ///
    public var publisher: HMHomeManagerPublisher {
        return HMHomeManagerPublisher(homeManager: self)
    }
}
