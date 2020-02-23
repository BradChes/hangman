//
//  ViewController.swift
//  hangman
//
//  Created by Bradley Chesworth on 23/02/2020.
//  Copyright © 2020 Brad Chesworth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let enter = UIBarButtonItem(title: "Enter", style: .plain, target: self, action: #selector(enterGuess))
        
        toolbarItems = [spacer, enter]
        
        navigationController?.isToolbarHidden = false
    }

    @objc func enterGuess() {
        
    }
}

