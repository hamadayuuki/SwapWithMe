//
//  File.swift
//
//
//  Created by 濵田　悠樹 on 2024/10/20.
//

import Foundation

protocol UserDefaultsClientProtocol {
    // Get
    var boolForKey: (String) -> Bool { get }
    var dataForKey: (String) -> Data? { get }
    var doubleForKey: (String) -> Double { get }
    var integerForKey: (String) -> Int { get }

    // Set
    var setBool: (Bool, String) async -> Void { get }
    var setData: (Data?, String) async -> Void { get }
    var setDouble: (Double, String) async -> Void { get }
    var setInteger: (Int, String) async -> Void { get }

    // Delete
    var delete: (String) -> Void { get }
}

struct UserDefaultsClient: UserDefaultsClientProtocol {
    
    var boolForKey: (String) -> Bool = { key in
        UserDefaults.standard.bool(forKey: key)
    }

    var dataForKey: (String) -> Data? = { key in
        UserDefaults.standard.data(forKey: key)
    }

    var doubleForKey: (String) -> Double = { key in
        UserDefaults.standard.double(forKey: key)
    }

    var integerForKey: (String) -> Int = { key in
        UserDefaults.standard.integer(forKey: key)
    }

    var setBool: (Bool, String) async -> Void = { value, key in
        await withCheckedContinuation { continuation in
            UserDefaults.standard.set(value, forKey: key)
            continuation.resume()
        }
    }

    var setData: (Data?, String) async -> Void = { value, key in
        await withCheckedContinuation { continuation in
            UserDefaults.standard.set(value, forKey: key)
            continuation.resume()
        }
    }

    var setDouble: (Double, String) async -> Void = { value, key in
        await withCheckedContinuation { continuation in
            UserDefaults.standard.set(value, forKey: key)
            continuation.resume()
        }
    }

    var setInteger: (Int, String) async -> Void = { value, key in
        await withCheckedContinuation { continuation in
            UserDefaults.standard.set(value, forKey: key)
            continuation.resume()
        }
    }

    var delete: (String) -> Void = { key in
        UserDefaults.standard.removeObject(forKey: key)
    }

}
