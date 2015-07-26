//
//  ViewController.swift
//  BullsEye
//
//  Created by YangTao on 15/7/9.
//  Copyright (c) 2015年 MicroWise. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//  notes: a local variable only exists for the duration of the method that it is defined in, while an instance variable exists as long as the view controller (the object that owns it) exists. The same thing is true for constants.
    
    //type inference instead of var currentValue: Int = 0
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        updateLabels()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert() {
//        old algorithms
//        var difference: Int
//        if currentValue > targetValue {
//            difference = currentValue - targetValue
//        } else if targetValue > currentValue {
//            difference = targetValue - currentValue
//        } else {
//            difference = 0
//        }
        
//        alternative algorithm
//        var difference = currentValue - targetValue
//        if difference < 0 {
//            difference = -difference
//        }
        
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        var title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
              points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        
        score += points
        
        let message = "You scored \(points)"
        let alert = UIAlertController(title: title,
                                    message: message,
                             preferredStyle: .Alert)
        //Normally you don’t need to use self to send messages to the view controller, even though it is allowed. The exception: inside closures you do have to use self to refer to the view controller.
        let action = UIAlertAction(title: "Ok", style: .Default, handler: { action in
                                                                            self.startNewRound()
                                                                            self.updateLabels()
                                                                           })
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(slider: UISlider) {
        currentValue = lroundf(slider.value)
        print("The value of the slider is now: \(slider.value)")
    }
    
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
    }
    
    func startNewGame() {
        round = 0
        score = 0
        startNewRound()
    }
    
    func startNewRound() {
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        round += 1
    }

    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
}

