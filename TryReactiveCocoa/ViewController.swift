//
//  ViewController.swift
//  TryReactiveCocoa
//
//  Created by Lee Geunil on 2016/07/02.
//  Copyright © 2016年 Lee Geunil. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textfield: UITextField!
    
    let (updateTextSignal, updateTextObserver) = SignalProducer<String, NoError>.buffer(0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTextSignal
            .map { (text) -> String in
                return text.uppercaseString
        }
            .startWithNext { [weak self] (text) in
            self?.label.text = text
        }
        
        textfield.addTarget(self, action: #selector(updateText(_:)), forControlEvents: .EditingChanged)
        
    }
    
    func updateText(sender: UITextField) {
        print(sender.text)
        updateTextObserver.sendNext(sender.text!)
    }
}

