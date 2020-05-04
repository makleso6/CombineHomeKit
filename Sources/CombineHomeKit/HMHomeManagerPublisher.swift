import Foundation
import HomeKit
import Combine

public final class HMHomeManagerPublisher {
    
    private let homeManager: HMHomeManager
    
    public init(homeManager: HMHomeManager) {
        self.homeManager = homeManager
    }
    
    public var authorizationStatus: AnyPublisher<HMHomeManagerAuthorizationStatus, Never> {
        return Just(homeManager.authorizationStatus).eraseToAnyPublisher()
    }

    public var primaryHome: AnyPublisher<HMHome?, Never> {
        return Just(homeManager.primaryHome).eraseToAnyPublisher()
    }

    public var homes: AnyPublisher<[HMHome], Never> {
        return Just(homeManager.homes).eraseToAnyPublisher()
    }

    public func updatePrimaryHome(_ home: HMHome) -> AnyPublisher<Void, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.homeManager.updatePrimaryHome(home, completionHandler: { (error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            })
        })
        .eraseToAnyPublisher()
    }

    public func addHome(withName homeName: String) -> AnyPublisher<HMHome, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.homeManager.addHome(withName: homeName, completionHandler: { (home, error) in
                if let error = error {
                    promise(.failure(error))
                } else if let home = home {
                    promise(.success(home))
                }
            })
        })
        .eraseToAnyPublisher()
    }

    public func removeHome(_ home: HMHome) -> AnyPublisher<Void, Error> {
        return Future({ [weak self] (promise) in
            guard let self = self else { return }
            self.homeManager.removeHome(home, completionHandler: { (error) in
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
