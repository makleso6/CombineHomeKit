import Foundation
import HomeKit
import Combine

extension HMCharacteristic {
    
    /// Returns ```HMCharacteristic``` wrapper.
    /// Note: ```HMCharacteristic``` instance does not keep strong reference to ```HMCharacteristicPublisher``` instance.
    ///
    public var publisher: HMCharacteristicPublisher {
        return HMCharacteristicPublisher(characteristic: self)
    }
}

