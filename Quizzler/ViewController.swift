//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
    
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextQuestion()
        
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        
        if sender.tag == 1 {
            pickedAnswer = true
        } else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
        questionNumber += 1  // this line is equivalent to questionNumber = questionNumber + 1
        nextQuestion()
       
    }
    
    
    func updateUI() {
        
        scoreLabel.text = "score: \(score)"
        progressLabel.text = "\(questionNumber + 1) / 13"
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(allQuestions.list.count)) * CGFloat(questionNumber + 1)
      
    }

    func nextQuestion() {
        
        if questionNumber < 12 {
            
             questionLabel.text = allQuestions.list[questionNumber].questionText
            
        } else if questionNumber >= 12 {
            
            let alert = UIAlertController(title: "Awesome", message: "You've finish all the questions, Do you want to start over?", preferredStyle: .alert)
        
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
          alert.addAction(restartAction)
            self.present(alert,animated: true,completion: nil)
            
        }
        updateUI()

    }
    
    func checkAnswer() {
        
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if correctAnswer == pickedAnswer {
            ProgressHUD.showSuccess("You got it!")
            score = score + 1
        }
        
        else {
            ProgressHUD.showError("Wrong!")
        }
        
    }
    
    
    func startOver() {
        questionNumber = 0
        score = 0
        updateUI()
        nextQuestion()
       
    }
    

    
}
