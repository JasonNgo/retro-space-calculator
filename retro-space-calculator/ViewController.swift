//
//  ViewController.swift
//  retro-space-calculator
//
//  Created by Jason Ngo on 2016-10-16.
//  Copyright © 2016 Jason Ngo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var displayLbl: UILabel!
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var leftVal = ""
    var rightVal = ""
    var result = ""
    
    var runningNumber = ""
    var currentOperation = Operation.Empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let audioPath = Bundle.main.path(forResource: "btn", ofType: "wav")
        let audioURL = URL(fileURLWithPath: audioPath!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: audioURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        displayLbl.text = "0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
        
        runningNumber += "\(sender.tag)"
        displayLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }

    func processOperation(operation: Operation) {
        btnSound.play()
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                rightVal = runningNumber
                runningNumber = ""
                
                switch currentOperation {
                case Operation.Multiply:
                    result = "\(Double(leftVal)! * Double(rightVal)!)"
                case Operation.Divide:
                    result = "\(Double(leftVal)! / Double(rightVal)!)"
                case Operation.Add:
                    result = "\(Double(leftVal)! + Double(rightVal)!)"
                case Operation.Subtract:
                    result = "\(Double(leftVal)! - Double(rightVal)!)"
                default:
                    print()
                }
                
                leftVal = result
                displayLbl.text = leftVal
            }
            
            currentOperation = operation
        } else {
            leftVal = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
}

