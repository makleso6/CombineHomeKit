import Foundation
import HomeKit
import Combine

extension HMService {
    
    /// Returns ```HMService``` wrapper.
    /// Note: ```HMService``` instance does not keep strong reference to ```HMServicePublisher``` instance.
    ///
    public var publisher: HMServicePublisher {
        return HMServicePublisher(service: self)
    }
}

