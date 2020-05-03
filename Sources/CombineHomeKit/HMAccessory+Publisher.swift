import Foundation
import HomeKit
import Combine

extension HMAccessory {
    
    /// Returns ```HMAccessory``` wrapper.
    /// Note: ```HMAccessory``` instance does not keep strong reference to ```HMAccessoryPublisher``` instance.
    ///
    public var publisher: HMAccessoryPublisher {
        return HMAccessoryPublisher(accessory: self)
    }
}
