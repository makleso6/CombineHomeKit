import Foundation
import HomeKit

extension HMHome {
    
    /// Returns ```HMHome``` wrapper.
    /// Note: ```HMHome``` instance does not keep strong reference to ```HMHomePublisher``` instance.
    ///
    public var publisher: HMHomePublisher {
        return HMHomePublisher(home: self)
    }
}
