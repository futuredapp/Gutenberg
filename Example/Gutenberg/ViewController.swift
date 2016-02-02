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
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let emoji1 = Emoji(code: "*angry*", image: UIImage(named: "angry")!)
        let emoji2 = Emoji(code: "*grin*", image: UIImage(named: "grin")!)
        
        
        Gutenberg.setDefaultHeight(textLabel.font.lineHeight)
        Gutenberg.setDefaultYOffset(textLabel.font.descender)
        Gutenberg.registerEmoji(emoji1, emoji2)
        
        let testText = "Hey! *grin* Where are you? *angry*"
        
        textLabel.text = testText
        textField.text = testText
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func showInLabel(sender: AnyObject) {
        self.textLabel.text = textField.text
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

