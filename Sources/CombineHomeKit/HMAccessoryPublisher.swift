import Foundation
import HomeKit
import Combine

public final class HMAccessoryPublisher {
    
    let accessory: HMAccessory
    
    init(accessory: HMAccessory) {
        self.accessory = accessory
    }

    public var name: AnyPublisher<String, Never> {
        return Just(accessory.name).eraseToAnyPublisher()
    }

    public var uniqueIdentifier: AnyPublisher<UUID, Never> {
        return Just(accessory.uniqueIdentifier).eraseToAnyPublisher()
    }

    public var isReachable: AnyPublisher<Bool, Never> {
        return Just(accessory.isReachable).eraseToAnyPublisher()
    }

    public var isBridged: AnyPublisher<Bool, Never> {
        return Just(accessory.isBridged).eraseToAnyPublisher()
    }

    public var uniqueIdentifiersForBridgedAccessories: AnyPublisher<[UUID], Never> {
        return Result.success(accessory)
            .publisher
            .compactMap({ $0.uniqueIdentifiersForBridgedAccessories })
            .eraseToAnyPublisher()
    }

    public var category: AnyPublisher<HMAccessoryCategory, Never> {
        return Just(accessory.category).eraseToAnyPublisher()
    }

    public var room: AnyPublisher<HMRoom, Never> {
        return Result.success(accessory)
            .publisher
            .compactMap({ $0.room })
            .eraseToAnyPublisher()
    }

    public var services: AnyPublisher<[HMService], Never> {
        return Just(accessory.services).eraseToAnyPublisher()
    }

    public var profiles: AnyPublisher<[HMAccessoryProfile], Never> {
        return Just(accessory.profiles).eraseToAnyPublisher()
    }

    public var isBlocked: AnyPublisher<Bool, Never> {
        return Just(accessory.isBlocked).eraseToAnyPublisher()
    }

    public var model: AnyPublisher<String, Never> {
        return Result.success(accessory)
        .publisher
        .compactMap({ $0.model })
        .eraseToAnyPublisher()
    }

    public var manufacturer: AnyPublisher<String, Never> {
        return Result.success(accessory)
        .publisher
        .compactMap({ $0.manufacturer })
        .eraseToAnyPublisher()
    }

    public var firmwareVersion: AnyPublisher<String, Never> {
        return Result.success(accessory)
        .publisher
        .compactMap({ $0.firmwareVersion })
        .eraseToAnyPublisher()
    }

    public var supportsIdentify: AnyPublisher<Bool, Never> {
        return Just(accessory.supportsIdentify).eraseToAnyPublisher()
    }
    
    public func updateName(_ name: String) -> AnyPublisher<Void, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.accessory.updateName(name, completionHandler: { (error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            })
        })
        .eraseToAnyPublisher()
    }

    public func identify() -> AnyPublisher<Void, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.accessory.identify(completionHandler: { (error) in
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
