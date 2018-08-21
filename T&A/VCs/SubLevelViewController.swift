//
//  SubLevelViewController.swift
//  T&A
//
//  Created by Teodik Abrami on 7/9/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class SubLevelViewController: UIViewController {

    var subLevel: SubLevels!
    var levelNumber: Int!
    
    @IBOutlet var buttonArray: [UIButton]!
    @IBOutlet var subLevelButton: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeLevel()
        
        
    }
    
    func initializeLevel() {
        for (index,button) in buttonArray.enumerated() {
            
            button.setBackgroundImage(UIImage(named: subLevel.levelsPics[index]) , for: .normal)
            // button.setImage(UIImage(named: subLevel.levelsPics[index] ), for: .normal)
            button.setTitle("", for: .normal)
            
            if subLevel.lock[index] {
                buttonArray[index].isEnabled = true
            } else {
                buttonArray[index].isEnabled = false
            }
        }
    }
    
    @IBAction func subLevelButtonPressed(_ sender: UIButton) {
        
        for (index,button) in subLevelButton.enumerated() {
            if sender == button {
                levelNumber = subLevel.levelsNumber[index]
            }
            
        }
        performSegue(withIdentifier: "sublevel", sender: sender)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gameVC = segue.destination as! GameViewController
        gameVC.levelNumber = levelNumber
        
        
    }
 

    @IBAction func unwind(_ segue: UIStoryboardSegue)
    {
        
    }
}
