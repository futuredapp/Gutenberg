//
//  Gutenberg.swift
//  Pods
//
//  Created by Aleš Kocur on 10/12/15.
//
//

public struct Emoji {
    public let code: String
    public let image: UIImage
    
    public init(code: String, image: UIImage) {
        self.code = code
        self.image = image
    }
}

public enum TranformTextOption {
    case None
    case LastOccurenceOnly
}

struct EmojiAttachment {
    let emoji: Emoji
    let textualRepresentation: NSAttributedString
}

typealias Occurence = (range: NSRange, replacement: NSAttributedString)

public class Gutenberg {
    
    static let sharedInstance = Gutenberg()
    
    private var emojis: [EmojiAttachment] = []
    private var yOffset: CGFloat = 0
    private var defaultHeight: CGFloat?
    
    // MARK: - Public API
    
    public class func transformTextWithEmojiCodes(text: String, option: TranformTextOption = .None) -> NSAttributedString {
        return self.sharedInstance._transformTextWithEmojiCodes(text)
    }
    
    public class func registerEmoji(emoji: Emoji) {
        self.sharedInstance._registerEmoji(emoji)
    }
    
    public class func registerEmoji(emoji: Emoji...) {
        emoji.forEach(registerEmoji)
    }
    
    public class func setDefaultYOffset(offset: CGFloat) {
        self.sharedInstance.yOffset = offset
    }
    
    public class func setDefaultHeight(height: CGFloat?) {
        self.sharedInstance.defaultHeight = height
    }
    
    // MARK: - Private methods
    
    /**
     Transforms text with emoji codes into attrributed string with images
     
     Example: hello *sad* -> hello 😔
    
     @returns NSAttributedString with emoji if occurence found, otherwise nil 
    */
    private func _transformTextWithEmojiCodes(text: String, option: TranformTextOption = .None) -> NSAttributedString {
    
        if text.characters.count == 0 {
            return NSAttributedString(string: "")
        }
        
        let occurences = Gutenberg._occurencesWithOption(option)(text, self.emojis)
        
        if occurences.count == 0 {
            return NSAttributedString(string: text)
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
    
    private class func _occurencesWithOption(option: TranformTextOption = .None) -> (NSString, [EmojiAttachment]) -> [Occurence] {
        
        switch option {
        case .None:
            return Gutenberg._findAllOccurencesInText
        case .LastOccurenceOnly:
            return Gutenberg._findLastOccurenceInText
        }
        
    }
    
    // Find all occurences in given text
    private class func _findAllOccurencesInText(text: NSString, emojis: [EmojiAttachment]) ->  [Occurence] {

        var occurences: [Occurence] = []
        
        for emojiAttch in emojis {
            
            var nextRange: NSRange? = text.rangeOfString(text as String)
            
            repeat {
                
                let range = text.rangeOfString(emojiAttch.emoji.code, options: NSStringCompareOptions(), range: nextRange!)
                
                if range.location != NSNotFound {
                    occurences.append((range, emojiAttch.textualRepresentation))
                    
                    let startLocation = range.location + range.length
                    let len = text.length - startLocation
                    nextRange = NSMakeRange(startLocation, len)
                } else {
                    nextRange = nil
                }
                
            } while nextRange != nil
        }
        
        return occurences
    }
    
    // Find only last occurence in string
    private class func _findLastOccurenceInText(text: NSString, emojis: [EmojiAttachment]) -> [Occurence] {
        for emojiAttch in emojis {
            let range = text.rangeOfString(emojiAttch.emoji.code, options: NSStringCompareOptions.BackwardsSearch)
            if range.location != NSNotFound {
                return [(range, emojiAttch.textualRepresentation)]
            }
        }
        
        return []
    }
    
    /**
     Registers emoji so it can be recognized in text
    */
    private func _registerEmoji(emoji: Emoji) {
        
        let attachment = NSTextAttachment()
        attachment.image = emoji.image
        attachment.bounds = {
            // scale image if needed
            let height = self.defaultHeight ?? emoji.image.size.height
            let scale = height / emoji.image.size.height
            return CGRectMake(0, yOffset, emoji.image.size.width * scale, height)
        }()
        let attr = NSAttributedString(attachment: attachment)
        
        self.emojis.append(EmojiAttachment(emoji: emoji, textualRepresentation: attr))
    }
    
}

public extension UILabel {
    func gtb_text(text: String) {
        self.attributedText = Gutenberg.transformTextWithEmojiCodes(text)
    }
}
