import Foundation
import HomeKit
import Combine

public final class HMHomeManagerDelegatePublisher: NSObject {
        
    private var didUpdatePrimaryHomeSubject: PassthroughSubject<HMHome, Never> = .init()
    
    private var didUpdateHomesSubject: PassthroughSubject<[HMHome], Never> = .init()
    
}

extension HMHomeManagerDelegatePublisher {
    
    public var didUpdatePrimary: AnyPublisher<HMHome, Never> {
        return didUpdatePrimaryHomeSubject.eraseToAnyPublisher()
    }
    
    public var didUpdateHomes: AnyPublisher<[HMHome], Never> {
        return didUpdateHomesSubject.eraseToAnyPublisher()
    }
    
}


extension HMHomeManagerDelegatePublisher: HMHomeManagerDelegate {

    public func homeManagerDidUpdatePrimaryHome(_ manager: HMHomeManager) {
        guard let primaryHome = manager.primaryHome else { return }
        didUpdatePrimaryHomeSubject.send(primaryHome)
    }
    
    public func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        didUpdateHomesSubject.send(manager.homes)
    }
}
