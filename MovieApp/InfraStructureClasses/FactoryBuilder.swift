

import Foundation

open class FactoryBuilder {
    // lazy init
    public lazy var accountFactory: AccountFactory = makeAccountFactory()
    
    // factory object creation
    open func makeAccountFactory() -> AccountFactory {
        return AccountFactory()
    }
    
}
