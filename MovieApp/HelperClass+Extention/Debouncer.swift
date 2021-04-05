//
//  Debouncer.swift
//  MovieApp
//
//  Created by Shashank on 05/04/21.
//

import Foundation

class Debouncer {
    private let delay: TimeInterval
    private var timer: Timer?

    var handler: () -> Void

    init(delay: TimeInterval, handler: @escaping () -> Void) {
        self.delay = delay
        self.handler = handler
    }

    func call() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false, block: { [weak self] _ in
            self?.handler()
        })
    }

    func invalidate() {
        timer?.invalidate()
        timer = nil
    }
}
