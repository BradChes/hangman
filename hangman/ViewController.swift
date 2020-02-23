//
//  ViewController.swift
//  hangman
//
//  Created by Bradley Chesworth on 23/02/2020.
//  Copyright © 2020 Brad Chesworth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var allWords = [String]()
    private var guessingWord: String?
    @IBOutlet private weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let enter = UIBarButtonItem(title: "Enter", style: .plain, target: self, action: #selector(enterGuess))
        
        toolbarItems = [spacer, enter]
        
        navigationController?.isToolbarHidden = false
        
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
        guessingWord = allWords.randomElement()
        answerLabel.text = guessingWord?.uppercased()
    }

    @objc private func enterGuess() {
        
    }
}

