//
//  File.swift
//
//
//  Created by 濵田　悠樹 on 2024/10/20.
//

import Foundation

public protocol UserDefaultsClientProtocol {
    // Get
    var stringForKey: (String) -> String? { get }
    var boolForKey: (String) -> Bool { get }
    var dataForKey: (String) -> Data? { get }
    var doubleForKey: (String) -> Double { get }
    var integerForKey: (String) -> Int { get }

    // Set
    var setString: (String, String) async -> Void { get }
    var setBool: (Bool, String) async -> Void { get }
    var setData: (Data?, String) async -> Void { get }
    var setDouble: (Double, String) async -> Void { get }
    var setInteger: (Int, String) async -> Void { get }

    // Delete
    var delete: (String) -> Void { get }
}

public struct UserDefaultsClient: UserDefaultsClientProtocol {
    public init() {}

    // MARK: - Get

    public var stringForKey: (String) -> String? = { key in
        UserDefaults.standard.string(forKey: key)
    }
    public var boolForKey: (String) -> Bool = { key in
        UserDefaults.standard.bool(forKey: key)
    }
    public var dataForKey: (String) -> Data? = { key in
        UserDefaults.standard.data(forKey: key)
    }
    public var doubleForKey: (String) -> Double = { key in
        UserDefaults.standard.double(forKey: key)
    }
    public var integerForKey: (String) -> Int = { key in
        UserDefaults.standard.integer(forKey: key)
    }

    // MARK: - Set

    public var setString: (String, String) async -> Void = { value, key in
        await withCheckedContinuation { continuation in
            UserDefaults.standard.set(value, forKey: key)
            continuation.resume()
        }
    }
    public var setBool: (Bool, String) async -> Void = { value, key in
        await withCheckedContinuation { continuation in
            UserDefaults.standard.set(value, forKey: key)
            continuation.resume()
        }
    }
    public var setData: (Data?, String) async -> Void = { value, key in
        await withCheckedContinuation { continuation in
            UserDefaults.standard.set(value, forKey: key)
            continuation.resume()
        }
    }
    public var setDouble: (Double, String) async -> Void = { value, key in
        await withCheckedContinuation { continuation in
            UserDefaults.standard.set(value, forKey: key)
            continuation.resume()
        }
    }
    public var setInteger: (Int, String) async -> Void = { value, key in
        await withCheckedContinuation { continuation in
            UserDefaults.standard.set(value, forKey: key)
            continuation.resume()
        }
    }

    // MARK: - Delete

    public var delete: (String) -> Void = { key in
        UserDefaults.standard.removeObject(forKey: key)
    }

}
