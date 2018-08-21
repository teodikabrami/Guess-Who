//
//  LevelsViewController.swift
//  T&A
//
//  Created by Teodik Abrami on 7/9/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class LevelsViewController: UIViewController {

    var subLevel: SubLevels!
    
    @IBOutlet var levelButtons: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        checkOpenLevels()
        updateUI()
    }
    
    func checkOpenLevels() {
        for i in 0...4 {
            if LevelsEnabled.enabling[i] {
                levelButtons[i].isEnabled = true
            } else {
                levelButtons[i].isEnabled = false
            }
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "levelstosublevels", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let SubLevelVC = segue.destination as? SubLevelViewController
        guard let sender = sender as? UIButton else { return }
        switch sender {
        case levelButtons[0]:
            let initializedLevel = SubLevels.init(levelsPics: ["1","2","3","4","5","6","7","8","9"], levelsNumber: [0,1,2,3,4,5,6,7,8], lock: [true,true,false,false,false,false,false,false,false])
            SubLevelVC?.subLevel = initializedLevel
        case levelButtons[1]:
            let initializedLevel = SubLevels.init(levelsPics: ["1","2","3","4","5","6","7","8","9"], levelsNumber: [11,22,33,44,55,66,77,88,99], lock: [false,false,false,false,false,false,false,false,false])
            SubLevelVC?.subLevel = initializedLevel
        case levelButtons[2]:
            let initializedLevel = SubLevels.init(levelsPics: ["1","2","3","4","5","6","7","8","9"], levelsNumber: [11,22,33,44,55,66,77,88,99], lock: [false,false,false,false,false,false,false,false,false])
            SubLevelVC?.subLevel = initializedLevel
        case levelButtons[3]:
            let initializedLevel = SubLevels.init(levelsPics: ["1","2","3","4","5","6","7","8","9"], levelsNumber: [11,22,33,44,55,66,77,88,99], lock: [false,false,false,false,false,false,false,false,false])
            SubLevelVC?.subLevel = initializedLevel
        case levelButtons[4]:
            let initializedLevel = SubLevels.init(levelsPics: ["1","2","3","4","5","6","7","8","9"], levelsNumber: [11,22,33,44,55,66,77,88,99], lock: [false,false,false,false,false,false,false,false,false])
            SubLevelVC?.subLevel = initializedLevel
        default:
            break
        }

      
    }
    
    
    func updateUI() {
        self.navigationController?.navigationBar.barTintColor = UIColor.init(patternImage: UIImage(named: "NavigationBar")!)
    }


}
