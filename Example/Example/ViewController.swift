//
//  ViewController.swift
//  Example
//
//  Created by Hirohisa Kawasaki on 8/22/15.
//  Copyright (c) 2015 Hirohisa Kawasaki. All rights reserved.
//

import UIKit
import AnimationKit

class ViewController: UIViewController {

    @IBOutlet weak var submitButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func submit() {
        let center = submitButton.center
        let animation = Animation("submit")
            --> (0.3, { self.submitButton.center = CGPoint(x: center.x, y: 100) })
            ||| (0.3, { self.submitButton.alpha = 0 } )
            --> (0.3, { self.submitButton.center = center })
            ||| (0.3, { self.submitButton.alpha = 1 } )
        println(animation.duration)
        animation.start()
    }

}