//
//  GameViewController.swift
//  Guess Who!!!
//
//  Created by Teodik Abrami on 6/18/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {

   
    @IBOutlet weak var firstRowStack: UIStackView!
    @IBOutlet weak var secondRowStack: UIStackView!
    @IBOutlet var hintButtons: [UIButton]!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var mustLetter: [UIButton]!
    @IBOutlet var answer: [UIButton]!
    
    var booleni = [Bool](repeating: false, count: 10) {
        willSet {
            //answer[0].set
        }
    }

    @IBOutlet weak var containerView: UIView!
    
    var player: AVAudioPlayer?
    var combination = ""
    var game: Game!
    var levelNumber: Int = 0
    
    var arrayOfButtonsPosition: [(answerButton: UIButton,letterButton: UIButton)]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newLevel()
        levelCompleted()
    }
    
    func levelCompleted() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.frame
        if game.levelcomplete {
           // var levelIsEnabled = LevelsEnabled.loadedLevelsEnabled()!
           // levelIsEnabled.enabling[levelNumber + 3] = true
           // LevelsEnabled.saveLevelsEnabled(levelsEnabled: levelIsEnabled)
            view.addSubview(blurEffectView)
            view.addSubview(containerView)
            containerView.isHidden = false
        } else {
           // firstRowStack.transform = CGAffineTransform(translationX: 0, y: -1000)
           // secondRowStack.transform = CGAffineTransform(translationX: 0, y: -1000)
           // animate()
        }
    }
    
    func animate() {
 
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: [.curveEaseInOut], animations: {
                self.firstRowStack.transform = CGAffineTransform.identity
        }, completion: { (true) in
            UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: [.curveEaseInOut], animations: {
                self.secondRowStack.transform = CGAffineTransform.identity
            }, completion: nil)
            
        })
        
    }

    @IBAction func mustLetterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        sender.alpha = 0
        answereButtonPressed(sender)
    }
    func hiddenbuttons() {
        guard game.numberOfLetter != 16 else { return }
        for i in game.numberOfLetter...answer.count - 1 {
            answer[i].isHidden = true
        }
    }
 
    
    func newLevel() {
        
        game = Game.init(levelcomplete: Levels.listOfWords[levelNumber].levelcomplete, imageName: Levels.listOfWords[levelNumber].imageName,
                         numberOfLetter: Levels.listOfWords[levelNumber].numberOfLetters,
                         fullName: Levels.listOfWords[levelNumber].fullName,
                         numberOfHints: Levels.listOfWords[levelNumber].numberOfHints,
                         guessedCombination: "", firstHint: Levels.listOfWords[levelNumber].firsthint, secondHint: Levels.listOfWords[levelNumber].secondHint, thirdHint: Levels.listOfWords[levelNumber].thirdHint, forthHint: Levels.listOfWords[levelNumber].forthhint)
            
            updateUI()
        
        
    }
    
    func updateUI() {
        let imageName = UIImage(named: game.imageName)
        imageView.image = imageName
    // resetAllButtons()
        hiddenbuttons()
        putLetters()
    }
    
    func answereButtonPressed (_ sender: UIButton) {
    
        for i in 0...answer.count - 1 {
            if(answer[i].titleLabel?.text == "__") {
                answer[i].setTitle(sender.titleLabel?.text , for: .normal) ////!!!!!!!!!!!!!!!!!!!!!!
                arrayOfButtonsPosition.append((answerButton: sender, letterButton: answer[i]))
                game.guessedCombination += (sender.titleLabel?.text)!
                break
            }
        }
        
        combination = ""
        for i in 0...answer.count - 1{
            if answer[i].titleLabel?.text != "__" { //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                combination += (answer[i].titleLabel?.text)!
            }
            
        }
        
        if combination == game.fullName {
            game.levelcomplete = true
            levelCompleted()
        }
        
    }
    
    

    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        guard sender.titleLabel?.text != "__" else { return }
        for i in 0...arrayOfButtonsPosition.count - 1
        {
            if(arrayOfButtonsPosition[i].letterButton == sender) {
                let button = arrayOfButtonsPosition[i].answerButton
                button.isEnabled = true
                button.alpha = 1
                arrayOfButtonsPosition[i].letterButton.setTitle("__", for: .normal)
                arrayOfButtonsPosition.remove(at: i)
                return
                
            }
        }
    }
    
/*    func resetAllButtons() {
        for i in 0...mustLetter.count - 1 {
            mustLetter[i].isEnabled = true
            mustLetter[i].alpha = 1
            
            
        }
        for i in 0...answer.count - 1 {
            answer[i].isEnabled = true
            answer[i].alpha = 1
            answer[i].setTitle("__", for: .normal)
        }
    }
 */
    
    func putLetters() {
        var nameArray = game.makeArray()
        for i in 0...game.numberOfLetter {
            guard nameArray.count != 0 else { break }
            let randomindex = Int(arc4random_uniform(UInt32(nameArray.count)))
            let letter = nameArray[randomindex]
            mustLetter[i].setTitle(letter, for: .normal)
            mustLetter[i].layer.borderWidth = 1
            mustLetter[i].layer.cornerRadius = 5
            nameArray.remove(at: randomindex)

        }
        
         let letters = ["A","B","C","D","E","F","G", "H","I","G","K", "L", "M", "N", "O", "P","Q","R","S","T","U","V","W","X","Y","Z"]
        
        for i in 0...mustLetter.count - 1
        {
            if(mustLetter[i].titleLabel?.text == "-")
            {
                let randomindex = Int(arc4random_uniform(UInt32(mustLetter.count)))
                mustLetter[i].setTitle(letters[randomindex], for: .normal)
                mustLetter[i].layer.borderWidth = 1
                mustLetter[i].layer.cornerRadius = 5
                
            }
        }
    }
    
    @IBAction func firstHintButtonPressed(_ sender: UIButton) {
        guard let image = UIImage(named: Levels.listOfWords[levelNumber].imageName + "-1") else { return }
        imageView.image = image
    }
    @IBAction func secondHintButtonPressed(_ sender: UIButton) {
        guard let image = UIImage(named: Levels.listOfWords[levelNumber].imageName + "-2") else { return }
        imageView.image = image
    }

    @IBAction func thirdHintButtonPressed(_ sender: UIButton) {
        guard let image = UIImage(named: Levels.listOfWords[levelNumber].imageName + "-3") else { return }
        imageView.image = image
    }
    
    @IBAction func forthHintButtonPressed(_ sender: UIButton) {
        guard let ButtonAudioUrl = Bundle.main.path(forResource: Levels.listOfWords[levelNumber].imageName + "mp3", ofType: "mp3") else{print("url not found");return}
        let url = URL(fileURLWithPath: ButtonAudioUrl)
        sender.isEnabled = false
        do{
            try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try! AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url , fileTypeHint: AVFileType.mp3.rawValue)
            player?.play()
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
   
    
}
