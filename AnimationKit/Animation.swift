//
//  Animation.swift
//  AnimationKit
//
//  Created by Hirohisa Kawasaki on 8/22/15.
//  Copyright (c) 2015 Hirohisa Kawasaki. All rights reserved.
//

import Foundation

public typealias Closure = () -> ()

class AnimationClosure: NSObject {

    let duration: NSTimeInterval
    let closure: Closure
    init(duration: NSTimeInterval, closure: Closure) {
        self.duration = duration
        self.closure = closure
    }

}

public class AnimationTask {

    var closures: [AnimationClosure] = []
    var completion: () -> () = {}
    public init(duration: NSTimeInterval, closure: Closure) {
        self.append(duration: duration, closure: closure)
    }

    public func append(#duration: NSTimeInterval, closure: Closure) {
        self.closures.append(AnimationClosure(duration: duration, closure: closure))
    }

    public func start(completion: () -> ()) {
        self.completion = completion
        for c in closures {
            UIView.animateWithDuration(c.duration, animations: c.closure, completion: { _ in self._completion(c) })
        }
    }

    func _completion(closure: AnimationClosure) {
        if let index = find(closures, closure) {
            closures.removeAtIndex(index)
        }
        if closures.isEmpty {
            self.completion()
        }
    }
}

public class Animation {

    public var tasks: [AnimationTask] = []
    public let label: String
    public init(_ label: String) {
        self.label = label
    }

    public func start() {
        Animation.singleton[label] = self
        next()
    }

    func next() {
        if let task = tasks.first {
            task.start { [unowned self] in self.next() }
            tasks.removeAtIndex(0)
            return
        }

        finish()
    }

//    deinit {
//        println(__FUNCTION__)
//    }

    func finish() {
        Animation.singleton[label] = nil
    }
}

extension Animation {
    static var singleton = [String: Animation]()
}

infix operator --> { associativity left precedence 140 }

public func --> (left: Animation, right: (duration: NSTimeInterval, closure: () -> ())) -> Animation {
    left.tasks.append(AnimationTask(duration: right.duration, closure: right.closure))
    return left
}

infix operator ||| { associativity left precedence 140 }

public func ||| (left: Animation, right: (duration: NSTimeInterval, closure: () -> ())) -> Animation {
    if let task = left.tasks.last {
        task.append(right)
    }
    return left
}
