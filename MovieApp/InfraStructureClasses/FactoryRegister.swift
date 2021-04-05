

import Foundation

public struct FactoryRegistrar {
    public static var shared = FactoryRegistrar()
    public var factoryBuilder = FactoryBuilder()
}

