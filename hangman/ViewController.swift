//
//  ViewController.swift
//  hangman
//
//  Created by Bradley Chesworth on 23/02/2020.
//  Copyright © 2020 Brad Chesworth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var answerLabel: UILabel!
    @IBOutlet private weak var attemptsLabel: UILabel!
    private var allWords = [String]()
    private var guessingWord = ""
    private var promptWord = ""
    private var usedLetters = [String]()
    private var attempts = 0 {
        didSet {
            attemptsLabel.text = "Attempts: \(attempts)/7"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let enter = UIBarButtonItem(title: "Enter", style: .plain, target: self, action: #selector(enterGuess))
        
        toolbarItems = [spacer, enter]
        
        navigationController?.isToolbarHidden = false
        attemptsLabel.text = "Attempts: \(attempts)/7"
        
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
               if let startWords = try? String(contentsOf: startWordsUrl) {
                   allWords = startWords.components(separatedBy: "\n")
               }
       }
        
        if allWords.isEmpty {
               allWords = ["silkworm"]
       }
        
        startGame()
    }
    
    private func startGame() {
        guessingWord = allWords.randomElement()!
        print(guessingWord)
        updatePrompt()
    }
    
    @objc func restartGame(action: UIAlertAction) {
        promptWord = ""
        usedLetters.removeAll()
        attempts = 0
        startGame()
    }
    
    private func updatePrompt() {
        promptWord.removeAll()
        for letter in Array(guessingWord) {
            let strLetter = String(letter)
            if usedLetters.contains(strLetter) {
                promptWord += strLetter
            } else {
                promptWord += "?"
            }
        }
        print(promptWord)
        answerLabel.text = promptWord.uppercased()
    }
    
    @objc private func enterGuess() {
        let ac = UIAlertController(title: "Enter letter guess", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }

        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    private func submit(_ answer: String) {
        let lowercasedAnswer = answer.lowercased()
       
        if isPossible(letter: lowercasedAnswer) {
            if isOriginal(letter: lowercasedAnswer) {
                if isCorrect(letter: lowercasedAnswer) {
                    usedLetters.insert(lowercasedAnswer, at: 0)
                    updatePrompt()
                } else {
                    attempts += 1
                    if attempts == 7 {
                        showRestartMessage()
                    } else {
                        showErrorMessage(errorTitle: "Letter not in word.", errorMessage: "Attempts has been increased.")
                    }
                }
            } else {
                showErrorMessage(errorTitle: "Letter already entered.", errorMessage: "Choose another one.")
            }
        } else {
            showErrorMessage(errorTitle: "Only enter one letter.", errorMessage: "Ain't got time for words.")
        }
    }
    
    private func isPossible(letter: String) -> Bool {
        let tempWord = Array(letter)
        
        if tempWord.count == 1 {
            return true
        } else {
            return false
        }
    }
    
    private func isCorrect(letter: String) -> Bool {
        return Array(guessingWord).contains(Character(letter))
    }
    
    private func isOriginal(letter: String) -> Bool {
        return !usedLetters.contains(letter)
    }

    private func showErrorMessage(errorTitle: String, errorMessage: String) {
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
     
        ac.addAction(UIAlertAction(title: "OK", style: .default))
     
        present(ac, animated: true)
    }
    
    private func showRestartMessage() {
        let ac = UIAlertController(title: "Ran out of attempts!", message: "Please try again.", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: restartGame))
            
        present(ac, animated: true)
    }
}

