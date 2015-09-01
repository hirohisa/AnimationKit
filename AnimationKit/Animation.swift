//
//  Animation.swift
//  AnimationKit
//
//  Created by Hirohisa Kawasaki on 8/22/15.
//  Copyright (c) 2015 Hirohisa Kawasaki. All rights reserved.
//

import Foundation

public typealias Closure = () -> ()
public typealias SubscribeClosure = (completed: Bool, next: AnimationTask?) -> ()

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
    var duration: NSTimeInterval {
        if let closure = closures.sorted({$0.duration < $1.duration}).last {
            return closure.duration
        }
        return 0
    }

    public init(duration: NSTimeInterval, closure: Closure) {
        union(duration: duration, closure: closure)
    }

    public func union(#duration: NSTimeInterval, closure: Closure) {
        closures.append(AnimationClosure(duration: duration, closure: closure))
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
            completion()
        }
    }
}

public class Animation {

    public var tasks: [AnimationTask] = []
    public let label: String
    public var duration: NSTimeInterval {
        return tasks.reduce(0, combine: { $0 + $1.duration })
    }

    public init(_ label: String) {
        self.label = label
    }

    public func start() {
        Animation.singleton[label] = self
        next()
    }

    public func union(#duration: NSTimeInterval, closure: Closure) {
        if let task = tasks.last {
            task.union(duration: duration, closure: closure)
            return
        }

        fatalError("Animation dosen't have tasks, use `append` or `-->` at first")
    }

    public func append(#duration: NSTimeInterval, closure: Closure) {
        tasks.append(AnimationTask(duration: duration, closure: closure))
    }

    var _subscribe: SubscribeClosure?
    public func subscribe(subscribe: SubscribeClosure) {
        _subscribe = subscribe
    }

    func next() {
        if let task = tasks.first {
            _subscribe?(completed: false, next: task)
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
        _subscribe?(completed: true, next: nil)
        Animation.singleton[label] = nil
    }
}

extension Animation {
    static var singleton = [String: Animation]()
}

// MARK: - Operator

infix operator --> { associativity left precedence 140 }

public func --> (left: Animation, right: (duration: NSTimeInterval, closure: () -> ())) -> Animation {
    left.append(right)
    return left
}

infix operator ||| { associativity left precedence 140 }

public func ||| (left: Animation, right: (duration: NSTimeInterval, closure: () -> ())) -> Animation {
    left.union(right)
    return left
}
