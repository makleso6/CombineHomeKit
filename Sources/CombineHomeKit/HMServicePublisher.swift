import Foundation
import HomeKit
import Combine

public final class HMServicePublisher {
    
    let service: HMService
    
    public init(service: HMService) {
        self.service = service
    }
    
    public var accessory: AnyPublisher<HMAccessory, Never> {
        return Result.success(service)
            .publisher
            .compactMap({ $0.accessory })
            .eraseToAnyPublisher()
    }
    
    public var serviceType: AnyPublisher<String, Never> {
        return Just(service.serviceType).eraseToAnyPublisher()
    }
    
    public var localizedDescription: AnyPublisher<String, Never> {
        return Just(service.localizedDescription).eraseToAnyPublisher()
    }
    
    public var name: AnyPublisher<String, Never> {
        return Just(service.name).eraseToAnyPublisher()
    }
    
    public var associatedServiceType: AnyPublisher<String?, Never> {
        return Just(service.associatedServiceType).eraseToAnyPublisher()
    }
    
    public var characteristics: AnyPublisher<[HMCharacteristic], Never> {
        return Just(service.characteristics).eraseToAnyPublisher()
    }
    
    public var uniqueIdentifier: AnyPublisher<UUID, Never> {
        return Just(service.uniqueIdentifier).eraseToAnyPublisher()
    }
    
    public var isUserInteractive: AnyPublisher<Bool, Never> {
        return Just(service.isUserInteractive).eraseToAnyPublisher()
    }
    
    public var isPrimaryService: AnyPublisher<Bool, Never> {
        return Just(service.isPrimaryService).eraseToAnyPublisher()
    }
    
    
    public var linkedServices: AnyPublisher<[HMService], Never> {
        return Result.success(service)
            .publisher
            .compactMap({ $0.linkedServices })
            .eraseToAnyPublisher()
    }
    
    public func updateName(_ name: String) -> AnyPublisher<Void, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.service.updateName(name, completionHandler: { (error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            })
        })
        .eraseToAnyPublisher()
    }
    
    public func updateAssociatedServiceType(_ serviceType: String?) -> AnyPublisher<Void, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.service.updateAssociatedServiceType(serviceType, completionHandler: { (error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            })
        })
        .eraseToAnyPublisher()
    }
}
