import Foundation
import HomeKit
import Combine

public final class HMHomePublisher {
    
    private let home: HMHome
    
    init(home: HMHome) {
        self.home = home
    }
    
    public func updateName(_ name: String) -> AnyPublisher<Void, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.home.updateName(name, completionHandler: { (error) in
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
extension HMHomePublisher {
    
    public var accessories: AnyPublisher<[HMAccessory], Never> {
        return Just(home.accessories).eraseToAnyPublisher()
    }
    
    public func addAccessory(_ accessory: HMAccessory) -> AnyPublisher<Void, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.home.addAccessory(accessory, completionHandler: { (error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            })
        })
        .eraseToAnyPublisher()
    }

    public func removeAccessory(_ accessory: HMAccessory) -> AnyPublisher<Void, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.home.removeAccessory(accessory, completionHandler: { (error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            })
        })
        .eraseToAnyPublisher()
    }

    public func assignAccessory(_ accessory: HMAccessory, to room: HMRoom) -> AnyPublisher<Void, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.home.assignAccessory(accessory, to: room, completionHandler: { (error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            })
        })
        .eraseToAnyPublisher()
    }
    
    public func servicesWithTypes(_ serviceTypes: [String]) -> AnyPublisher<[HMService], Never> {
        return Result
            .success(home)
            .publisher
            .compactMap({
                $0.servicesWithTypes(serviceTypes)
            })
            .eraseToAnyPublisher()
    }
    
    @available(iOS 13.2, *)
    public var supportsAddingNetworkRouter: AnyPublisher<Bool, Never> {
        return Just(home.supportsAddingNetworkRouter).eraseToAnyPublisher()
    }

    
    public func unblockAccessory(_ accessory: HMAccessory) -> AnyPublisher<Void, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.home.unblockAccessory(accessory, completionHandler: { (error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            })
        })
        .eraseToAnyPublisher()
    }

    public func addAndSetupAccessories() -> AnyPublisher<Void, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.home.addAndSetupAccessories(completionHandler: { (error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            })
        })
        .eraseToAnyPublisher()
    }
    
    public func addAndSetupAccessories(with payload: HMAccessorySetupPayload) -> AnyPublisher<[HMAccessory], Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.home.addAndSetupAccessories(with: payload, completionHandler: { (accessories, error) in
                if let error = error {
                    promise(.failure(error))
                } else if let accessories = accessories {
                    promise(.success(accessories))
                }
            })
        })
        .eraseToAnyPublisher()
    }
    
}

extension HMHomePublisher {

    public var currentUser: AnyPublisher<HMUser, Never> {
        return Just(home.currentUser).eraseToAnyPublisher()
    }

    public func manageUsers() -> AnyPublisher<Void, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.home.manageUsers(completionHandler: { (error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            })
        })
        .eraseToAnyPublisher()
    }
    
    public func homeAccessControl(for user: HMUser) -> AnyPublisher<HMHomeAccessControl, Never> {
        return Just(home.homeAccessControl(for: user)).eraseToAnyPublisher()
    }
}

extension HMHomePublisher {
    
    public var rooms: AnyPublisher<[HMRoom], Never> {
        return Just(home.rooms).eraseToAnyPublisher()
    }
    
    public func addRoom(withName roomName: String) -> AnyPublisher<HMRoom, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.home.addRoom(withName: roomName, completionHandler: { (room, error)  in
                if let error = error {
                    promise(.failure(error))
                } else if let room = room {
                    promise(.success(room))
                }
            })
        })
        .eraseToAnyPublisher()
    }

    public func removeRoom(_ room: HMRoom) -> AnyPublisher<Void, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.home.removeRoom(room, completionHandler: { (error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            })
        })
        .eraseToAnyPublisher()
    }

    public var roomForEntireHome: AnyPublisher<HMRoom, Never> {
        return Just(home.roomForEntireHome()).eraseToAnyPublisher()
    }

}

extension HMHomePublisher {
    
    public var zones: AnyPublisher<[HMZone], Never> {
        return Just(home.zones).eraseToAnyPublisher()
    }

    public func addZone(withName zoneName: String) -> AnyPublisher<HMZone, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.home.addZone(withName: zoneName, completionHandler: { (zone, error)  in
                if let error = error {
                    promise(.failure(error))
                } else if let zone = zone {
                    promise(.success(zone))
                }
            })
        })
        .eraseToAnyPublisher()
    }

    public func removeZone(_ zone: HMZone) -> AnyPublisher<Void, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.home.removeZone(zone, completionHandler: { (error) in
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

extension HMHomePublisher {

    public var serviceGroups: AnyPublisher<[HMServiceGroup], Never> {
        return Just(home.serviceGroups).eraseToAnyPublisher()
    }

    public func addServiceGroup(withName serviceGroupName: String) -> AnyPublisher<HMServiceGroup, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.home.addServiceGroup(withName: serviceGroupName, completionHandler: { (serviceGroup, error)  in
                if let error = error {
                    promise(.failure(error))
                } else if let serviceGroup = serviceGroup {
                    promise(.success(serviceGroup))
                }
            })
        })
        .eraseToAnyPublisher()
    }

    public func removeServiceGroup(_ group: HMServiceGroup) -> AnyPublisher<Void, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.home.removeServiceGroup(group, completionHandler: { (error) in
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

extension HMHomePublisher {
    
    public var actionSets: AnyPublisher<[HMActionSet], Never> {
        return Just(home.actionSets).eraseToAnyPublisher()
    }

    public func addActionSet(withName actionSetName: String) -> AnyPublisher<HMActionSet, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.home.addActionSet(withName: actionSetName, completionHandler: { (actionSet, error)  in
                if let error = error {
                    promise(.failure(error))
                } else if let actionSet = actionSet {
                    promise(.success(actionSet))
                }
            })
        })
        .eraseToAnyPublisher()
    }

    public func removeActionSet(_ actionSet: HMActionSet) -> AnyPublisher<Void, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.home.removeActionSet(actionSet, completionHandler: { (error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            })
        })
        .eraseToAnyPublisher()
    }

    public func executeActionSet(_ actionSet: HMActionSet) -> AnyPublisher<Void, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.home.executeActionSet(actionSet, completionHandler: { (error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            })
        })
        .eraseToAnyPublisher()
    }

    public func builtinActionSet(ofType actionSetType: String) -> AnyPublisher<HMActionSet, Never> {
        return Result
            .success(home)
            .publisher
            .compactMap({
                $0.builtinActionSet(ofType: actionSetType)
            })
            .eraseToAnyPublisher()
    }
}

extension HMHomePublisher {
    
    
    public var triggers: AnyPublisher<[HMTrigger], Never> {
        return Just(home.triggers).eraseToAnyPublisher()
    }

    public func addTrigger(_ trigger: HMTrigger) -> AnyPublisher<Void, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.home.addTrigger(trigger, completionHandler: { (error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            })
        })
        .eraseToAnyPublisher()
    }

    public func removeTrigger(_ trigger: HMTrigger) -> AnyPublisher<Void, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.home.removeTrigger(trigger, completionHandler: { (error) in
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
