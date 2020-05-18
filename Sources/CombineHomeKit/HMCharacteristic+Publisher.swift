import Foundation
import HomeKit

extension HMCharacteristic {
    
    /// Returns ```HMCharacteristic``` wrapper.
    /// Note: ```HMCharacteristic``` instance does not keep strong reference to ```HMCharacteristicPublisher``` instance.
    ///
    public var publisher: HMCharacteristicPublisher {
        return HMCharacteristicPublisher(characteristic: self)
    }
}

