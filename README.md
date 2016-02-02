# Gutenberg

[![Version](https://img.shields.io/cocoapods/v/Gutenberg.svg?style=flat)](http://cocoapods.org/pods/Gutenberg)
[![License](https://img.shields.io/cocoapods/l/Gutenberg.svg?style=flat)](http://cocoapods.org/pods/Gutenberg)
[![Platform](https://img.shields.io/cocoapods/p/Gutenberg.svg?style=flat)](http://cocoapods.org/pods/Gutenberg)

<img src="https://raw.githubusercontent.com/thefuntasty/Gutenberg/master/screenshot.png" width="500" />

Gutenberg is tiny library that can generate NSAttributedString from given string and replace registered characters with images (emoji).

## Usage

Import Gutenberg

```swift
import Gutenberg
```

Create as many emoji as you want 

```swift
let emoji1 = Emoji(code: "*angry*", image: UIImage(named: "angry")!)
let emoji2 = Emoji(code: "*grin*", image: UIImage(named: "grin")!)
```

Set default height and offset based on your preferred font so the emojis are aligned nicely (optional)

```swift
Gutenberg.setDefaultHeight(self.textLabel.font.lineHeight)
Gutenberg.setDefaultYOffset(self.textLabel.font.descender)
```

And register them

```swift
Gutenberg.registerEmoji(emoji1, emoji2)
```

Then create label 
```swift
@IBOutlet weak var textLabel: GutenbergLabel!
```
and set the text

```swift
self.textLabel.text = "Hey! *grin* Where are you? *angry*"
```

And that's all. If you don't want to use our GuttenbergLabel (it's just UILabel subclass), there is also an extension for UILabel with method `gtb_text:`.

```swift
self.textLabel.gtb_text = "Hey! *grin* Where are you? *angry*"
```

It's just cosmetics :-)

## Requirements

There are no special requirements. Gutenberg takes advantage of the NSTextAttachment class to replace the occurences of registered strings with them.

## Installation

Gutenberg is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Gutenberg"
```

## Author

Aleš Kocur, ales@thefuntasty.com

## License

Gutenberg is available under the MIT license. See the LICENSE file for more info.
