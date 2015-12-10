//
//  GutenbergLabel.swift
//  Pods
//
//  Created by Aleš Kocur on 10/12/15.
//
//

class GutenbergLabel: UILabel {
    
    override var text: String? {
        didSet {
            if let text = text {
                self.attributedText = Gutenberg.transformTextWithEmojiCodes(text)
            }
        }
    }
    
}
