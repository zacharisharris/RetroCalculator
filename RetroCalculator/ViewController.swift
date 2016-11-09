//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Harris Zacharis on 8/11/16.
//  Copyright © 2016 Harris Zacharis. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound : AVAudioPlayer!
    
    enum Operation : String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        }

    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    var currentOperation = Operation.Empty
    var runningNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    
    }
    @IBAction func numberPressed(sender:UIButton) {
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
        playSound()
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation: Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation: Operation.Multiply)
    }
    
    @IBAction func onDSubtractPressed(sender: AnyObject) {
        processOperation(operation: Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(operation: Operation.Add)
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
    func processOperation(operation: Operation){
        playSound()
        if currentOperation != Operation.Empty {
            
            //A user selected an operator, but then selected another operator without entering a number.
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
}
            currentOperation = operation
        } else {
            //This is the first time an operator has been pressed.
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
}
}
