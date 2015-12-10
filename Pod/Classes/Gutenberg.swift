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
    
    public init(code: String, image: UIImage) {
        self.code = code
        self.image = image
    }
}

struct EmojiAttachment {
    let emoji: Emoji
    let textualRepresentation: NSAttributedString
}

public class Gutenberg {
    
    static let sharedInstance = Gutenberg()
    
    private var emojis: [EmojiAttachment] = []
    
    // MARK: - Public API
    
    public class func transformTextWithEmojiCodes(text: String) -> NSAttributedString {
        return self.sharedInstance._transformTextWithEmojiCodes(text)
    }
    
    public class func registerEmoji(emoji: Emoji) {
        self.sharedInstance._registerEmoji(emoji)
    }
    
    // MARK: - Private methods
    
    /**
     Transforms text with emoji codes into attrributed string with images
     
     Example: hello *sad* -> hello 😔
    */
    private func _transformTextWithEmojiCodes(text: String) -> NSAttributedString {
        
        var occurences: [(range: NSRange, replacement: NSAttributedString)] = []
        let nstext = NSString(string: text)
        
        // Find all occurences in given text
        for emojiAttch in self.emojis {
            
            var nextRange: NSRange? = nstext.rangeOfString(text)
            
            repeat {
                
                let range = nstext.rangeOfString(emojiAttch.emoji.code, options: NSStringCompareOptions(), range: nextRange!)
                
                if range.location != NSNotFound {
                    occurences.append((range, emojiAttch.textualRepresentation))
                    
                    let startLocation = range.location + range.length
                    let len = nstext.length - startLocation
                    nextRange = NSMakeRange(startLocation, len)
                } else {
                    nextRange = nil
                }
                
            } while nextRange != nil
        }
        
        // Sort the occurences from the last to the first
        let sortedRanges = occurences.sort { (occ1, occ2) -> Bool in
            return occ1.range.location > occ2.range.location
        }
        
        let attr = NSMutableAttributedString(string: text)
        
        sortedRanges.forEach { occ in
            attr.replaceCharactersInRange(occ.range, withAttributedString: occ.replacement)
        }
        
        return attr
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