import Foundation
import HomeKit
import Combine

public final class HMCharacteristicPublisher {
    
    let characteristic: HMCharacteristic
    
    public init(characteristic: HMCharacteristic) {
        self.characteristic = characteristic
    }

    public var characteristicType: AnyPublisher<String, Never> {
        return Just(characteristic.characteristicType).eraseToAnyPublisher()
    }

    public var localizedDescription: AnyPublisher<String, Never> {
        return Just(characteristic.localizedDescription).eraseToAnyPublisher()
    }

    public var service: AnyPublisher<HMService, Never> {
        return Result.success(characteristic)
        .publisher
        .compactMap({ $0.service })
        .eraseToAnyPublisher()
    }

    public var properties: AnyPublisher<[String], Never> {
        return Just(characteristic.properties).eraseToAnyPublisher()
    }

    public var metadata: AnyPublisher<HMCharacteristicMetadata, Never> {
        return Result.success(characteristic)
            .publisher
            .compactMap({ $0.metadata })
            .eraseToAnyPublisher()
    }

    public var value: AnyPublisher<Any, Never> {
        return Result.success(characteristic)
            .publisher
            .compactMap({ $0.value })
            .eraseToAnyPublisher()
    }

    public var isNotificationEnabled: AnyPublisher<Bool, Never> {
        return Just(characteristic.isNotificationEnabled).eraseToAnyPublisher()
    }

    public var uniqueIdentifier: AnyPublisher<UUID, Never> {
        return Just(characteristic.uniqueIdentifier).eraseToAnyPublisher()
    }

    public func writeValue(_ value: Any?) -> AnyPublisher<Void, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.characteristic.writeValue(value, completionHandler: { (error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            })
        })
        .eraseToAnyPublisher()
    }

    public func readValue() -> AnyPublisher<Void, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.characteristic.readValue(completionHandler: { (error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            })
        })
        .eraseToAnyPublisher()
    }
        
    public func enableNotification(_ enable: Bool) -> AnyPublisher<Void, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.characteristic.enableNotification(enable, completionHandler: { (error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            })
        })
        .eraseToAnyPublisher()
    }

    public func updateAuthorizationData(_ data: Data?) -> AnyPublisher<Void, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.characteristic.updateAuthorizationData(data, completionHandler: { (error) in
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
