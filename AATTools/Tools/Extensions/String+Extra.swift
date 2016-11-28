//
//  String+Extra.swift
//  AATTools
//
//  Created by Albert Arroyo on 18/11/16.
//  Copyright © 2016 AlbertArroyo. All rights reserved.
//

/**
 * This Extension has different MARK sections
 * Add/Modify accordingly to mantain 'some order' :)
 * If you add/modify some method/property, please add a Test. @see StringTest.swift
 */

import UIKit

public extension String {
    // MARK: Computed properties
    
    /// Convenience property, Int for the number of characters of self
    public var length: Int {
        return self.characters.count
    }
    
    /// Convenience property, Array of the individual substrings composing self
    public var chars: [String] {
        return Array(self.characters).map({String($0)})
    }
    
    /// Convenience property, Set<String> of the unique characters in self
    public var charSet: Set<String> {
        return Set(self.characters.map{String($0)})
    }
    
    /// Convenience property, String with first character of self
    public var firstCharacter: String? {
        return self.chars.first
    }
    
    /// Convenience property, String with last character of self
    public var lastCharacter: String? {
        return self.chars.last
    }
    
    /// Convenience property, Bool to know if the string is empty (has characters)
    public var isEmpty: Bool {
        return self.chars.isEmpty
    }
    
    /// Convenience property, Bool to know if the field is empty (has characters)
    public var isEmptyField: Bool {
        if self.isEmpty {
            return true
        }
        return self.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty
    }
    
    /// Computed property that returns a new string made by replacing
    /// all HTML character entity references with the corresponding character
    var stringByDecodingHTMLEntities: String {
        let  x = decodeHTMLEntities()
        return x.decodedString
    }
    
    /// Convenience property, String with base64 representation
    public var base64: String {
        let plainData = (self as NSString).data(using: String.Encoding.utf8.rawValue)
        let base64String = plainData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return base64String
    }
    
    /// Convenience property, count of words
    public var countofWords: Int {
        let regex = try? NSRegularExpression(pattern: "\\w+", options: NSRegularExpression.Options())
        return regex?.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions(), range: NSRange(location: 0, length: self.length)) ?? 0
    }
    
    /// Convenience property, count of paragraphs
    public var countofParagraphs: Int {
        let regex = try? NSRegularExpression(pattern: "\\n", options: NSRegularExpression.Options())
        let str = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return (regex?.numberOfMatches(in: str, options: NSRegularExpression.MatchingOptions(), range: NSRange(location:0, length: str.length)) ?? -1) + 1
    }
    
    /// Convenience property, extracts URLS from self and return [URL]
    public var extractURLs: [URL] {
        var urls: [URL] = []
        let detector: NSDataDetector?
        do {
            detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        } catch _ as NSError {
            detector = nil
        }
        
        let text = self
        
        if let detector = detector {
            detector.enumerateMatches(in: text, options: [], range: NSRange(location: 0, length: text.characters.count), using: {
                (result: NSTextCheckingResult?, flags: NSRegularExpression.MatchingFlags, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
                if let result = result, let url = result.url {
                    urls.append(url)
                }
            })
        }
        
        return urls
    }
    
    /// Convenience property, converts html to NSAttributedString
    var html2AttStr: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch let error as NSError {
            print(error.code)
            return nil
        }
    }
    
    /// Convenience property, returns localized string
    public var localized: String? {
        return self.localized()
    }
    
    /// Convenience property, returns pathExtension from string url
    public var pathExtension: String? {
        return NSURL(fileURLWithPath: self).pathExtension
    }
    
    /// Convenience property, returns lastPathComponent from string url
    public var lastPathComponent: String? {
        return NSURL(fileURLWithPath: self).lastPathComponent
    }
    
    /// Convenience property, converts self to NSString
    public var toNSString: NSString { get { return self as NSString } }
}

// MARK: String manipulation / util methods
public extension String {
    /// Method to remove the first character of self
    /// - Returns: string with first character removed
    public func removedFirstChar() -> String {
        return self.substring(from: self.index(after: self.startIndex))
    }
    
    /// Method to remove the last character of self
    /// - Returns: string with last character removed
    public func removedLastChar() -> String {
        return self.substring(to: self.index(before: self.endIndex))
    }
    
    /// Method to remove whitespaces from the start and end of self
    /// - Returns: string with no whitespaces
    public func trimmed() -> String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /// Method to reverse self
    /// - Returns: string reversed
    public func reversed() -> String {
        return String(self.characters.reversed())
    }
    
    /// Method to replace `t` parameter with string `s` parameter
    /// - Parameters:
    ///     - target: The target to replace
    ///     - withString: The string to replace
    /// - Returns: string replaced
    func replaced(target t: String, withString s: String) -> String {
        return self.replacingOccurrences(of: t, with: s, options: .literal, range: nil)
    }
    
    /// Method to split string using a separator string `s` parameter
    /// - Parameters:
    ///     - separator: The separator string
    /// - Returns: [String]
    public func splitted(separator s: String) -> [String] {
        return self.components(separatedBy: s).filter {
            !$0.trimmed().isEmpty
        }
    }
    
    /// Method to split string using a separator set `characters` parameter with delimiters
    /// - Parameters:
    ///     - separator: The separator CharacterSet
    /// - Returns: [String]
    public func splitted(separator characters: CharacterSet) -> [String] {
        return self.components(separatedBy: characters).filter {
            !$0.trimmed().isEmpty
        }
    }
    
    /// Method to count number of instances of the `substring` parameter inside self
    /// - Parameters:
    ///     - substring: The substring to count
    /// - Returns: Int with number of ocurrences
    public func count(substring s: String) -> Int {
        return components(separatedBy: s).count - 1
    }
    
    /// Method to uppercase the first letter
    /// - Returns: string with first letter capitalized
    func uppercasedFirstLetter() -> String {
        guard characters.count > 0 else { return self }
        var result = self
        result.replaceSubrange(startIndex...startIndex, with: String(self[startIndex]).uppercased())
        return result
    }
    
    /// Method to uppercases first 'count' characters of String
    /// - Parameters:
    ///     - firstNumberCharacters: the first count characters
    /// - Returns: String modified
    public func uppercasedPrefix(firstNumberCharacters count: Int) -> String {
        guard characters.count > 0 && count > 0 else { return self }
        var result = self
        result.replaceSubrange(startIndex..<self.index(startIndex, offsetBy: min(count, length)),
                               with: String(self[startIndex..<self.index(startIndex, offsetBy: min(count, length))]).uppercased())
        return result
    }
    
    /// Method to uppercases last 'count' characters of self
    /// - Parameters:
    ///     - lastNumberCharacters: the last count characters
    /// - Returns: String modified
    public func uppercasedSuffix(lastNumberCharacters count: Int) -> String {
        guard characters.count > 0 && count > 0 else { return self }
        var result = self
        result.replaceSubrange(characters.index(endIndex, offsetBy: -min(count, length))..<endIndex,
                               with: String(self[characters.index(endIndex, offsetBy: -min(count, length))..<endIndex]).uppercased())
        return result
    }
    
    /// Method to uppercases string in range 'range'
    /// - Parameters:
    ///     - range: CountableRange<Int> to uppercase
    /// - Returns: String modified
    public func uppercased(range r: CountableRange<Int>) -> String {
        let from = max(r.lowerBound, 0), to = min(r.upperBound, length)
        guard characters.count > 0 && (0..<length).contains(from) else { return self }
        var result = self
        result.replaceSubrange(characters.index(startIndex, offsetBy: from)..<characters.index(startIndex, offsetBy: to),
                               with: String(self[characters.index(startIndex, offsetBy: from)..<characters.index(startIndex, offsetBy: to)]).uppercased())
        return result
    }
    
    /// Method to lowercase the first letter
    /// - Returns: string with first letter lowercased
    public func lowercasedFirstLetter() -> String {
        guard characters.count > 0 else { return self }
        var result = self
        result.replaceSubrange(startIndex...startIndex, with: String(self[startIndex]).lowercased())
        return result
    }
    
    /// Method to lowercase first 'count' characters of String
    /// - Parameters:
    ///     - firstNumberCharacters: the first count characters
    /// - Returns: String modified
    public func lowercasedPrefix(firstNumberCharacters count: Int) -> String {
        guard characters.count > 0 && count > 0 else { return self }
        var result = self
        result.replaceSubrange(startIndex..<self.index(startIndex, offsetBy: min(count, length)),
                               with: String(self[startIndex..<self.index(startIndex, offsetBy: min(count, length))]).lowercased())
        return result
    }
    
    /// Method to lowercase last 'count' characters of self
    /// - Parameters:
    ///     - lastNumberCharacters: the last count characters
    /// - Returns: String modified
    public func lowercasedSuffix(lastNumberCharacters count: Int) -> String {
        guard characters.count > 0 && count > 0 else { return self }
        var result = self
        result.replaceSubrange(characters.index(endIndex, offsetBy: -min(count, length))..<endIndex,
                               with: String(self[characters.index(endIndex, offsetBy: -min(count, length))..<endIndex]).lowercased())
        return result
    }
    
    /// Method to lowercase string in range 'range'
    /// - Parameters:
    ///     - range: CountableRange<Int> to lowercase
    /// - Returns: String modified
    public func lowercased(range r: CountableRange<Int>) -> String {
        let from = max(r.lowerBound, 0), to = min(r.upperBound, length)
        guard characters.count > 0 && (0..<length).contains(from) else { return self }
        var result = self
        result.replaceSubrange(characters.index(startIndex, offsetBy: from)..<characters.index(startIndex, offsetBy: to),
                               with: String(self[characters.index(startIndex, offsetBy: from)..<characters.index(startIndex, offsetBy: to)]).lowercased())
        return result
    }
    
    /// Method to get the first index of the occurency of the character in self
    /// - Parameters:
    ///     - character: Character to search
    /// - Returns: Int? with the position
    public func getIndexOf(character char: Character) -> Int? {
        for (index, c) in characters.enumerated() {
            if c == char {
                return index
            }
        }
        return nil
    }
    
    /// Method to get the height of rendered self
    /// - Parameters:
    ///     - maxWidth: CGFloat
    ///     - font: UIFont
    ///     - lineBreakMode: NSLineBreakMode
    /// - Returns: CGFloat
    func height(maxWidth width: CGFloat, font: UIFont, lineBreakMode: NSLineBreakMode?) -> CGFloat {
        var attrib: [String: AnyObject] = [NSFontAttributeName: font]
        if lineBreakMode != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = lineBreakMode!
            attrib.updateValue(paragraphStyle, forKey: NSParagraphStyleAttributeName)
        }
        let size = CGSize(width: width, height: CGFloat(DBL_MAX))
        return ceil((self as NSString).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes:attrib, context: nil).height)
    }
    
    /// Method to copy string to pasteboard
    public func addToPasteboard() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = self
    }
}

// MARK: String manipulation (mutating methods)
// TODO: add some mutating functions
public extension String {
    
}

// MARK: Wrapper for Index (String access)
public extension String {
    /// Wrapper for index with startIndex offsetBy `from` parameter
    /// - Parameters:
    ///     - from: Int
    /// - Returns: Index
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    /// Wrapper substring `from` parameter
    /// - Parameters:
    ///     - from: Int
    /// - Returns: String
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    /// Wrapper substring `to` parameter
    /// - Parameters:
    ///     - to: Int
    /// - Returns: String
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    /// Wrapper substring with range
    /// - Parameters:
    ///     - with: Range<Int>
    /// - Returns: String
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}

// MARK: Subscript
public extension String {
    /// Method to cut string from `integerIndex` parameter to the end
    /// - Parameters:
    ///     - integerIndex: Int
    /// - Returns: Character
    public subscript(integerIndex: Int) -> Character {
        let index = characters.index(startIndex, offsetBy: integerIndex)
        return self[index]
    }
    
    /// Method to cut string from `integerRange` parameter
    /// - Parameters:
    ///     - integerRange: Range<Int>
    /// - Returns: String
    public subscript(integerRange: Range<Int>) -> String {
        let start = characters.index(startIndex, offsetBy: integerRange.lowerBound)
        let end = characters.index(startIndex, offsetBy: integerRange.upperBound)
        return self[start..<end]
    }
    
    /// Method to cut string from `integerClosedRange` parameter
    /// - Parameters:
    ///     - integerClosedRange: ClosedRange<Int>
    /// - Returns: String
    public subscript(integerClosedRange: ClosedRange<Int>) -> String {
        return self[integerClosedRange.lowerBound..<(integerClosedRange.upperBound + 1)]
    }
}

// MARK: Localization Methods
public extension String {
    /// Method to localize self. 
    /// Adding a bundle parameter with default value provide the possibility to test the method
    /// mocking the correct bundle
    /// - Parameters:
    ///     - bundle: Bundle, by default Bundle.main
    /// - Returns: Localized string
    public func localized(bundle localizationBundle : Bundle = Bundle.main) -> String {
        return NSLocalizedString(self, bundle: localizationBundle, comment: "")
    }
}

// MARK: URL Methods
public extension String {
    /// Method to encode the self string url
    /// - Returns: URL? with encoded URL
    public func encodeURL() -> URL? {
        if let originURL = URL(string: self) {
            return originURL
        } else {
            if let url = URL(string: self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!) {
                return url
            } else {
                return nil
            }
        }
    }
    
    /// Method to percent escapes values to be added to a URL query as specified in RFC 3986
    /// This percent-escapes all characters besides the alphanumeric character set and "-", ".", "_", and "~".
    /// http://www.ietf.org/rfc/rfc3986.txt
    /// - Returns: String? with percent-escaped string
    func addedPercentToEncodedForUrl() -> String? {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
}

// MARK: Range / NSRange
public extension String {
    /// Method to return NSRange from `range` parameter
    /// - Parameters:
    ///     - from: Range<String.Index>
    /// - Returns: NSRange
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                       length: utf16.distance(from: from, to: to))
    }
    
    /// Method to return Range from `nsRange` parameter
    /// - Parameters:
    ///     - from: NSRange
    /// - Returns: Range?
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
}

// MARK: String satisfying certain conditions
public extension String {
    /// Method to know if self is an email
    /// - Returns: Bool with condition
    public func isEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    /// Method to know if self is numeric
    /// - Returns: Bool with condition
    public func isNumber() -> Bool {
        let range = self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted)
        return (range == nil)
    }
    
    /// Method to know if self contains given sensitive `s` parameter
    /// - Parameters:
    ///     - string: String to search
    /// - Returns: Bool with condition
    public func containsSensitive(string s: String) -> Bool {
        return self.range(of: s) != nil
    }
    
    /// Method to know if self contains given not sensitive `s` parameter
    /// - Parameters:
    ///     - string: String to search
    /// - Returns: Bool with condition
    public func containsNotSensitive(string s: String) -> Bool {
        return self.lowercased().range(of: s) != nil
    }
    
    /// Method to find matches of regular expression in string
    /// - Parameters:
    ///     - regex: String with regex
    /// - Returns: [String] with matches
    public func matchesForRegexInText(regex reg: String!) -> [String] {
        let regex = try? NSRegularExpression(pattern: reg, options: [])
        let results = regex?.matches(in: self, options: [], range: NSRange(location: 0, length: self.length)) ?? []
        return results.map { self.substring(with: self.range(from: $0.range)!) }
    }
}

// MARK: Tracting Numbers / Conversions / Utils for Banking Apps
public extension String {
    /// More efficient not to create a number formatter every time if not modify properties
    static let numberFormatterInstance = NumberFormatter()
    
    /// Method to format a string to double
    /// - Returns: Double?
    public func toDouble() -> Double? {
        if let num = String.numberFormatterInstance.number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }
    
    /// Method to format a string to int
    /// - Returns: Int?
    public func toInt() -> Int? {
        if let num = String.numberFormatterInstance.number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }
    
    /// Method to format a string to float
    /// - Returns: Float?
    public func toFloat() -> Float? {
        if let num = String.numberFormatterInstance.number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }
    
    /// Method to format a string to bool
    /// - Returns: Bool?
    public func toBool() -> Bool? {
        let trimmedString = trimmed().lowercased()
        if trimmedString == "true" || trimmedString == "false" {
            return (trimmedString as NSString).boolValue
        }
        return nil
    }
    
    /// Method to format a string to double with given `d` parameter
    /// - Parameters:
    ///     - decimals: Int
    /// - Returns: String?
    public func formatNumber(decimals d: Int) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = d
        guard let nDouble = self.toDouble() else {
            return nil
        }
        return numberFormatter.string(from: NSNumber(value: nDouble))
    }
    
    /// Method to remove white spaces
    /// - Returns: String
    public func removedWitheSpaces() -> String {
        return self.replaced(target: " ", withString: "")
    }
    
    /// Method to format a string to an account number
    /// Verifications are not in this scope
    /// - Returns: String formatted
    func formattedAccountNumber() -> String {
        if self.length > 19 {
            let r1 : Range<Int> = 0..<4
            let part1 = self.substring(with: r1)
            let r2 : Range<Int> = 4..<8
            let part2 = self.substring(with: r2)
            let r3 : Range<Int> = 8..<10
            let part3 = self.substring(with: r3)
            let r4 : Range<Int> = 10..<20
            let part4 = self.substring(with: r4)
            
            return "\(part1)-\(part2)-\(part3)-\(part4)"
        }
        return self
    }
    
    /// Method to format a string to an iban number
    /// Verifications are not in this scope
    /// - Returns: String formatted
    func formattedIbanNumber() -> String {
        if self.length > 23 {
            let r1 : Range<Int> = 0..<4
            let part1 = self.substring(with: r1)
            let r2 : Range<Int> = 4..<8
            let part2 = self.substring(with: r2)
            let r3 : Range<Int> = 8..<12
            let part3 = self.substring(with: r3)
            let r4 : Range<Int> = 12..<16
            let part4 = self.substring(with: r4)
            let r5 : Range<Int> = 16..<20
            let part5 = self.substring(with: r5)
            let r6 : Range<Int> = 20..<24
            let part6 = self.substring(with: r6)
            
            return "\(part1) \(part2) \(part3) \(part4) \(part5) \(part6)"
        }
        return self
    }
    
    /// Method to remove trailing zeros to a given fraction digits `d` parameter
    /// Verifications are not in this scope
    /// - Parameters:
    ///     - decimals: Int
    /// - Returns: String formatted
    func removedTrailingZeros(decimals d: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = d
        numberFormatter.minimumFractionDigits = 0
        guard let strRemovedTrailing = numberFormatter.string(from: NSNumber(value: self.toDouble()!)) else {
            return self
        }
        if self.hasPrefix("0") {
            return "0\(strRemovedTrailing)"
        }
        return strRemovedTrailing
    }
}

// MARK: NSAttributedString
public extension String {
    /// Method to bold self
    /// - Returns: NSAttributedString
    public func bold() -> NSAttributedString {
        let boldString = NSMutableAttributedString(string: self, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
        return boldString
    }

    /// Method to underline self
    /// - Returns: NSAttributedString
    public func underline() -> NSAttributedString {
        let underlineString = NSAttributedString(string: self, attributes: [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])
        return underlineString
    }

    /// Method to italic self
    /// - Returns: NSAttributedString
    public func italic() -> NSAttributedString {
        let italicString = NSMutableAttributedString(string: self, attributes: [NSFontAttributeName: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
        return italicString
    }
    
    /// Method to color self
    /// - Parameters:
    ///     - _ : UIColor
    /// - Returns: NSAttributedString
    public func color(_ color: UIColor) -> NSAttributedString {
        let colorString = NSMutableAttributedString(string: self, attributes: [NSForegroundColorAttributeName: color])
        return colorString
    }
    
    /// Method to color substring of self
    /// - Parameters:
    ///     - substring : String to apply the color in self
    ///     - color : UIColor
    /// - Returns: NSAttributedString
    public func color(substring s: String, color: UIColor) -> NSMutableAttributedString {
        var start = 0
        var ranges: [NSRange] = []
        while true {
            let range = (self as NSString).range(of: s, options: NSString.CompareOptions.literal, range: NSRange(location: start, length: (self as NSString).length - start))
            if range.location == NSNotFound {
                break
            } else {
                ranges.append(range)
                start = range.location + range.length
            }
        }
        let attrText = NSMutableAttributedString(string: self)
        for range in ranges {
            attrText.addAttribute(NSForegroundColorAttributeName, value: color, range: range)
        }
        return attrText
    }
}

// MARK: Emoji
public extension String {
    /// Method to check if String contains Emoji
    /// - Returns: Bool
    public func containsEmoji() -> Bool {
        for i in 0...length {
            let c: unichar = (self as NSString).character(at: i)
            if (0xD800 <= c && c <= 0xDBFF) || (0xDC00 <= c && c <= 0xDFFF) {
                return true
            }
        }
        return false
    }
}

// MARK: HTML

//Source : https://gist.github.com/mwaterfall/25b4a6a06dc3309d9555
private let characterEntities : [String: Character] = [
    
    // XML predefined entities:
    "&quot;"     : "\"",
    "&amp;"      : "&",
    "&apos;"     : "'",
    "&lt;"       : "<",
    "&gt;"       : ">",
    
    // HTML character entity references:
    "&nbsp;"     : "\u{00A0}",
    "&iexcl;"    : "\u{00A1}",
    "&cent;"     : "\u{00A2}",
    "&pound;"    : "\u{00A3}",
    "&curren;"   : "\u{00A4}",
    "&yen;"      : "\u{00A5}",
    "&brvbar;"   : "\u{00A6}",
    "&sect;"     : "\u{00A7}",
    "&uml;"      : "\u{00A8}",
    "&copy;"     : "\u{00A9}",
    "&ordf;"     : "\u{00AA}",
    "&laquo;"    : "\u{00AB}",
    "&not;"      : "\u{00AC}",
    "&shy;"      : "\u{00AD}",
    "&reg;"      : "\u{00AE}",
    "&macr;"     : "\u{00AF}",
    "&deg;"      : "\u{00B0}",
    "&plusmn;"   : "\u{00B1}",
    "&sup2;"     : "\u{00B2}",
    "&sup3;"     : "\u{00B3}",
    "&acute;"    : "\u{00B4}",
    "&micro;"    : "\u{00B5}",
    "&para;"     : "\u{00B6}",
    "&middot;"   : "\u{00B7}",
    "&cedil;"    : "\u{00B8}",
    "&sup1;"     : "\u{00B9}",
    "&ordm;"     : "\u{00BA}",
    "&raquo;"    : "\u{00BB}",
    "&frac14;"   : "\u{00BC}",
    "&frac12;"   : "\u{00BD}",
    "&frac34;"   : "\u{00BE}",
    "&iquest;"   : "\u{00BF}",
    "&Agrave;"   : "\u{00C0}",
    "&Aacute;"   : "\u{00C1}",
    "&Acirc;"    : "\u{00C2}",
    "&Atilde;"   : "\u{00C3}",
    "&Auml;"     : "\u{00C4}",
    "&Aring;"    : "\u{00C5}",
    "&AElig;"    : "\u{00C6}",
    "&Ccedil;"   : "\u{00C7}",
    "&Egrave;"   : "\u{00C8}",
    "&Eacute;"   : "\u{00C9}",
    "&Ecirc;"    : "\u{00CA}",
    "&Euml;"     : "\u{00CB}",
    "&Igrave;"   : "\u{00CC}",
    "&Iacute;"   : "\u{00CD}",
    "&Icirc;"    : "\u{00CE}",
    "&Iuml;"     : "\u{00CF}",
    "&ETH;"      : "\u{00D0}",
    "&Ntilde;"   : "\u{00D1}",
    "&Ograve;"   : "\u{00D2}",
    "&Oacute;"   : "\u{00D3}",
    "&Ocirc;"    : "\u{00D4}",
    "&Otilde;"   : "\u{00D5}",
    "&Ouml;"     : "\u{00D6}",
    "&times;"    : "\u{00D7}",
    "&Oslash;"   : "\u{00D8}",
    "&Ugrave;"   : "\u{00D9}",
    "&Uacute;"   : "\u{00DA}",
    "&Ucirc;"    : "\u{00DB}",
    "&Uuml;"     : "\u{00DC}",
    "&Yacute;"   : "\u{00DD}",
    "&THORN;"    : "\u{00DE}",
    "&szlig;"    : "\u{00DF}",
    "&agrave;"   : "\u{00E0}",
    "&aacute;"   : "\u{00E1}",
    "&acirc;"    : "\u{00E2}",
    "&atilde;"   : "\u{00E3}",
    "&auml;"     : "\u{00E4}",
    "&aring;"    : "\u{00E5}",
    "&aelig;"    : "\u{00E6}",
    "&ccedil;"   : "\u{00E7}",
    "&egrave;"   : "\u{00E8}",
    "&eacute;"   : "\u{00E9}",
    "&ecirc;"    : "\u{00EA}",
    "&euml;"     : "\u{00EB}",
    "&igrave;"   : "\u{00EC}",
    "&iacute;"   : "\u{00ED}",
    "&icirc;"    : "\u{00EE}",
    "&iuml;"     : "\u{00EF}",
    "&eth;"      : "\u{00F0}",
    "&ntilde;"   : "\u{00F1}",
    "&ograve;"   : "\u{00F2}",
    "&oacute;"   : "\u{00F3}",
    "&ocirc;"    : "\u{00F4}",
    "&otilde;"   : "\u{00F5}",
    "&ouml;"     : "\u{00F6}",
    "&divide;"   : "\u{00F7}",
    "&oslash;"   : "\u{00F8}",
    "&ugrave;"   : "\u{00F9}",
    "&uacute;"   : "\u{00FA}",
    "&ucirc;"    : "\u{00FB}",
    "&uuml;"     : "\u{00FC}",
    "&yacute;"   : "\u{00FD}",
    "&thorn;"    : "\u{00FE}",
    "&yuml;"     : "\u{00FF}",
    "&OElig;"    : "\u{0152}",
    "&oelig;"    : "\u{0153}",
    "&Scaron;"   : "\u{0160}",
    "&scaron;"   : "\u{0161}",
    "&Yuml;"     : "\u{0178}",
    "&fnof;"     : "\u{0192}",
    "&circ;"     : "\u{02C6}",
    "&tilde;"    : "\u{02DC}",
    "&Alpha;"    : "\u{0391}",
    "&Beta;"     : "\u{0392}",
    "&Gamma;"    : "\u{0393}",
    "&Delta;"    : "\u{0394}",
    "&Epsilon;"  : "\u{0395}",
    "&Zeta;"     : "\u{0396}",
    "&Eta;"      : "\u{0397}",
    "&Theta;"    : "\u{0398}",
    "&Iota;"     : "\u{0399}",
    "&Kappa;"    : "\u{039A}",
    "&Lambda;"   : "\u{039B}",
    "&Mu;"       : "\u{039C}",
    "&Nu;"       : "\u{039D}",
    "&Xi;"       : "\u{039E}",
    "&Omicron;"  : "\u{039F}",
    "&Pi;"       : "\u{03A0}",
    "&Rho;"      : "\u{03A1}",
    "&Sigma;"    : "\u{03A3}",
    "&Tau;"      : "\u{03A4}",
    "&Upsilon;"  : "\u{03A5}",
    "&Phi;"      : "\u{03A6}",
    "&Chi;"      : "\u{03A7}",
    "&Psi;"      : "\u{03A8}",
    "&Omega;"    : "\u{03A9}",
    "&alpha;"    : "\u{03B1}",
    "&beta;"     : "\u{03B2}",
    "&gamma;"    : "\u{03B3}",
    "&delta;"    : "\u{03B4}",
    "&epsilon;"  : "\u{03B5}",
    "&zeta;"     : "\u{03B6}",
    "&eta;"      : "\u{03B7}",
    "&theta;"    : "\u{03B8}",
    "&iota;"     : "\u{03B9}",
    "&kappa;"    : "\u{03BA}",
    "&lambda;"   : "\u{03BB}",
    "&mu;"       : "\u{03BC}",
    "&nu;"       : "\u{03BD}",
    "&xi;"       : "\u{03BE}",
    "&omicron;"  : "\u{03BF}",
    "&pi;"       : "\u{03C0}",
    "&rho;"      : "\u{03C1}",
    "&sigmaf;"   : "\u{03C2}",
    "&sigma;"    : "\u{03C3}",
    "&tau;"      : "\u{03C4}",
    "&upsilon;"  : "\u{03C5}",
    "&phi;"      : "\u{03C6}",
    "&chi;"      : "\u{03C7}",
    "&psi;"      : "\u{03C8}",
    "&omega;"    : "\u{03C9}",
    "&thetasym;" : "\u{03D1}",
    "&upsih;"    : "\u{03D2}",
    "&piv;"      : "\u{03D6}",
    "&ensp;"     : "\u{2002}",
    "&emsp;"     : "\u{2003}",
    "&thinsp;"   : "\u{2009}",
    "&zwnj;"     : "\u{200C}",
    "&zwj;"      : "\u{200D}",
    "&lrm;"      : "\u{200E}",
    "&rlm;"      : "\u{200F}",
    "&ndash;"    : "\u{2013}",
    "&mdash;"    : "\u{2014}",
    "&lsquo;"    : "\u{2018}",
    "&rsquo;"    : "\u{2019}",
    "&sbquo;"    : "\u{201A}",
    "&ldquo;"    : "\u{201C}",
    "&rdquo;"    : "\u{201D}",
    "&bdquo;"    : "\u{201E}",
    "&dagger;"   : "\u{2020}",
    "&Dagger;"   : "\u{2021}",
    "&bull;"     : "\u{2022}",
    "&hellip;"   : "\u{2026}",
    "&permil;"   : "\u{2030}",
    "&prime;"    : "\u{2032}",
    "&Prime;"    : "\u{2033}",
    "&lsaquo;"   : "\u{2039}",
    "&rsaquo;"   : "\u{203A}",
    "&oline;"    : "\u{203E}",
    "&frasl;"    : "\u{2044}",
    "&euro;"     : "\u{20AC}",
    "&image;"    : "\u{2111}",
    "&weierp;"   : "\u{2118}",
    "&real;"     : "\u{211C}",
    "&trade;"    : "\u{2122}",
    "&alefsym;"  : "\u{2135}",
    "&larr;"     : "\u{2190}",
    "&uarr;"     : "\u{2191}",
    "&rarr;"     : "\u{2192}",
    "&darr;"     : "\u{2193}",
    "&harr;"     : "\u{2194}",
    "&crarr;"    : "\u{21B5}",
    "&lArr;"     : "\u{21D0}",
    "&uArr;"     : "\u{21D1}",
    "&rArr;"     : "\u{21D2}",
    "&dArr;"     : "\u{21D3}",
    "&hArr;"     : "\u{21D4}",
    "&forall;"   : "\u{2200}",
    "&part;"     : "\u{2202}",
    "&exist;"    : "\u{2203}",
    "&empty;"    : "\u{2205}",
    "&nabla;"    : "\u{2207}",
    "&isin;"     : "\u{2208}",
    "&notin;"    : "\u{2209}",
    "&ni;"       : "\u{220B}",
    "&prod;"     : "\u{220F}",
    "&sum;"      : "\u{2211}",
    "&minus;"    : "\u{2212}",
    "&lowast;"   : "\u{2217}",
    "&radic;"    : "\u{221A}",
    "&prop;"     : "\u{221D}",
    "&infin;"    : "\u{221E}",
    "&ang;"      : "\u{2220}",
    "&and;"      : "\u{2227}",
    "&or;"       : "\u{2228}",
    "&cap;"      : "\u{2229}",
    "&cup;"      : "\u{222A}",
    "&int;"      : "\u{222B}",
    "&there4;"   : "\u{2234}",
    "&sim;"      : "\u{223C}",
    "&cong;"     : "\u{2245}",
    "&asymp;"    : "\u{2248}",
    "&ne;"       : "\u{2260}",
    "&equiv;"    : "\u{2261}",
    "&le;"       : "\u{2264}",
    "&ge;"       : "\u{2265}",
    "&sub;"      : "\u{2282}",
    "&sup;"      : "\u{2283}",
    "&nsub;"     : "\u{2284}",
    "&sube;"     : "\u{2286}",
    "&supe;"     : "\u{2287}",
    "&oplus;"    : "\u{2295}",
    "&otimes;"   : "\u{2297}",
    "&perp;"     : "\u{22A5}",
    "&sdot;"     : "\u{22C5}",
    "&lceil;"    : "\u{2308}",
    "&rceil;"    : "\u{2309}",
    "&lfloor;"   : "\u{230A}",
    "&rfloor;"   : "\u{230B}",
    "&lang;"     : "\u{2329}",
    "&rang;"     : "\u{232A}",
    "&loz;"      : "\u{25CA}",
    "&spades;"   : "\u{2660}",
    "&clubs;"    : "\u{2663}",
    "&hearts;"   : "\u{2665}",
    "&diams;"    : "\u{2666}",
    
]

public extension String {
    /// Method that returns a tuple containing the string made by replacing in the
    /// `String` all HTML character entity references with the corresponding
    /// character. Also returned is an array of offset information describing
    /// the location and length offsets for each replacement. This allows
    /// for the correct adjust any attributes that may be associated with
    /// with substrings within the `String`
    func decodeHTMLEntities() -> (decodedString: String, replacementOffsets: [Range<String.Index>]) {
        
        // ===== Utility functions =====
        
        // Record the index offsets of each replacement
        // This allows anyone to correctly adjust any attributes that may be
        // associated with substrings within the string
        var replacementOffsets: [Range<String.Index>] = []
        
        // Convert the number in the string to the corresponding
        // Unicode character, e.g.
        //    decodeNumeric("64", 10)   --> "@"
        //    decodeNumeric("20ac", 16) --> "€"
        func decodeNumeric(string : String, base : Int32) -> Character? {
            let code = UInt32(strtoul(string, nil, base))
            return Character(UnicodeScalar(code)!)
        }
        
        // Decode the HTML character entity to the corresponding
        // Unicode character, return `nil` for invalid input.
        //     decode("&#64;")    --> "@"
        //     decode("&#x20ac;") --> "€"
        //     decode("&lt;")     --> "<"
        //     decode("&foo;")    --> nil
        func decode(entity : String) -> Character? {
            if entity.hasPrefix("&#x") || entity.hasPrefix("&#X"){
                
                return decodeNumeric(string: entity.substring(from: entity.index(entity.startIndex, offsetBy: 3)), base: 16)
            } else if entity.hasPrefix("&#") {
                return decodeNumeric(string: entity.substring(from: entity.index(entity.startIndex, offsetBy: 2)), base: 10)
            } else {
                return characterEntities[entity]
            }
        }
        
        // ===== Method starts here =====
        
        var result = ""
        var position = startIndex
        
        // Find the next '&' and copy the characters preceding it to `result`:
        while let ampRange = self.range(of:"&", range: position ..< endIndex) {
            result += self[position ..< ampRange.lowerBound]
            position = ampRange.lowerBound
            
            // Find the next ';' and copy everything from '&' to ';' into `entity`
            if let semiRange = self.range(of:";", range: position ..< endIndex) {
                let entity = self[position ..< semiRange.upperBound]
                if let decoded = decode(entity: entity) {
                    
                    // Replace by decoded character:
                    result.append(decoded)
                    
                    replacementOffsets.append(Range(position ..< semiRange.upperBound))
                    
                } else {
                    
                    // Invalid entity, copy verbatim:
                    result += entity
                    
                }
                position = semiRange.upperBound
            } else {
                // No matching ';'.
                break
            }
        }
        
        // Copy remaining characters to `result`:
        result += self[position ..< endIndex]
        
        // Return results
        return (decodedString: result, replacementOffsets: replacementOffsets)
    }
}
