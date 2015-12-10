//
//  GutenbergLabel.swift
//  Pods
//
//  Created by Aleš Kocur on 10/12/15.
//
//

public class GutenbergLabel: UILabel {
    
    public override var text: String? {
        didSet {
            if let text = text {
                self.attributedText = Gutenberg.transformTextWithEmojiCodes(text)
            }
        }
    }
    
}
