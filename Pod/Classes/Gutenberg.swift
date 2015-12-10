//
//  Gutenberg.swift
//  Pods
//
//  Created by Aleš Kocur on 10/12/15.
//
//

public struct Emoji {
    let code: String
    let image: UIImage
}

struct EmojiAttachment {
    let emoji: Emoji
    let textualRepresentation: NSAttributedString
}

public class Gutenberg {
    
    static let sharedInstance = Gutenberg()
    
    private var emojis: [EmojiAttachment] = []
    
    // MARK: - Public API
    
    class func transformTextWithEmojiCodes(text: String) -> NSAttributedString {
        return self.sharedInstance._transformTextWithEmojiCodes(text)
    }
    
    class func registerEmoji(emoji: Emoji) {
        self.sharedInstance._registerEmoji(emoji)
    }
    
    // MARK: - Private methods
    
    /**
     Transforms text with emoji codes into attrributed string with images
     
     Example: hello *sad* -> hello 😔
    */
    private func _transformTextWithEmojiCodes(text: String) -> NSAttributedString {
        
        var occurences: [(range: NSRange, replacement: NSAttributedString)] = []
        
        // Find all occurences in given text
        for emojiAttch in self.emojis {
            let range = NSString(string: text).rangeOfString(emojiAttch.emoji.code)
            
            if range.location != NSNotFound {
                occurences.append((range, emojiAttch.textualRepresentation))
            }
        }
        
        // Sort the occurences from the last to the first
        let sortedRanges = occurences.sort { (occ1, occ2) -> Bool in
            return occ1.range.location > occ2.range.location
        }
        
        // Debug print
        sortedRanges.forEach { occ in
            print(occ.range)
        }
        
        var attr = NSMutableAttributedString(string: text)
        
        return NSAttributedString()
    }
    
    /**
     Registers emoji so it can be recognized in text
    */
    private func _registerEmoji(emoji: Emoji) {
        
        let attachment = NSTextAttachment()
        attachment.image = emoji.image
        let attr = NSAttributedString(attachment: attachment)
        
        self.emojis.append(EmojiAttachment(emoji: emoji, textualRepresentation: attr))
    }
    
}