//
//  ViewController.swift
//  Quizzler
//
//  Completed by Aditya Pokharel on 03/01/2018
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var correctAnswer : Bool = false
    var currentQuestion = 0
    var score = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateScore()
        updateProgress()
        updateUI()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        }
        else {
            pickedAnswer = false
        }
        
        checkAnswer()
    }
    
    
    func updateUI() {
        let firstQuestion = allQuestions.list[currentQuestion]
        questionLabel.text = firstQuestion.questionText
    }
    
    func updateScore() {
        scoreLabel.text = "Score: \(score)"
    }
    
    func updateProgress() {
        progressLabel.text = "\(currentQuestion + 1) / \(allQuestions.list.count)"
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(allQuestions.list.count)) * CGFloat(currentQuestion + 1)
    }
    

    func nextQuestion() {
        
    }
    
    
    func checkAnswer() {
        let answer = allQuestions.list[currentQuestion].answer
        if answer == pickedAnswer {
            ProgressHUD.showSuccess("Correct!")
            score += 1
        }
        else{
            ProgressHUD.showError("Wrong!")
        }
        if currentQuestion < allQuestions.list.count - 1 {
            currentQuestion += 1
            updateUI()
            updateScore()
            updateProgress()
        }
        else {
            updateScore()
            let alert = UIAlertController(title: "Awesome!", message: "Score : \(score)/\(allQuestions.list.count). Restart quiz?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { UIAlertAction in
                self.startOver()
            })
            
            alert.addAction(restartAction)
            
            present(alert, animated: true, completion: nil)
        }
        print(currentQuestion)
    }
    
    
    func startOver() {
        currentQuestion = 0
        score = 0
        updateUI()
        updateProgress()
        updateScore()
    }
    

    
}
