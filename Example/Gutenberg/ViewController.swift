//
//  ViewController.swift
//  Gutenberg
//
//  Created by Aleš Kocur on 12/10/2015.
//  Copyright (c) 2015 Aleš Kocur. All rights reserved.
//

import UIKit
import Gutenberg

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: GutenbergLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let emoji1 = Emoji(code: "*muah*", image: UIImage(named: "small_smile_17")!)
        let emoji2 = Emoji(code: "*D'oh*", image: UIImage(named: "small_smile_18")!)
        
        Gutenberg.registerEmoji(emoji1)
        Gutenberg.registerEmoji(emoji2)
        
        let testText = "Hello *D'oh* lol *muah* trala *muah*"
        
        textLabel.text = testText
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

