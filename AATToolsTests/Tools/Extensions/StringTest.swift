//
//  StringTest.swift
//  AATTools
//
//  Created by Albert Arroyo on 18/11/16.
//  Copyright © 2016 AlbertArroyo. All rights reserved.
//

import XCTest

@testable import AATTools

class StringTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        super.tearDown()
    }
    
    // MARK: Computed properties
    
    func testLength() {
        let sut = "String Test"
        XCTAssertEqual(sut.length, 11, "String Test should have 11 characters")
    }
    
    func testChars() {
        let sut = "Hola"
        let chars : [String] = sut.chars
        XCTAssertEqual(chars[0], "H", "First character should be H")
        XCTAssertEqual(chars.count, 4, "Hola has 4 characters")
        
        let sut2 = "Hola "
        let chars2 : [String] = sut2.chars
        XCTAssertEqual(chars2.count, 5, "sut2 has 5 characters")
        XCTAssertEqual(chars2[4], " ", "Last character should be ' '")
    }
    
    func testCharSet() {
        let sut = "Hola Hola hola"
        let charSet : Set<String> = sut.charSet
        XCTAssertEqual(charSet.count, 6, "Should have 6 different characters: 'H','o','l','a',' ','h'")
        XCTAssertEqual(charSet.contains("H"), true, "Should contains H")
        XCTAssertEqual(charSet.contains("h"), true, "Should contains h")
    }
    
    func testFirstCharacter() {
        let sut = "Hola"
        XCTAssertEqual(sut.firstCharacter, "H", "First character should be H")
    }
    
    func testLastCharacter() {
        let sut = "Hola,"
        XCTAssertEqual(sut.lastCharacter, ",", "Last character should be ,")
    }
    
    func testIsEmpty() {
        let sut = ""
        XCTAssertEqual(sut.isEmpty, true, "sut should be empty")
        
        let sut2 = " "
        XCTAssertEqual(sut2.isEmpty, false, "sut2 should not be empty")
    }
    
    func testIsEmptyField() {
        let sut = "    "
        XCTAssertEqual(sut.isEmptyField, true, "sut should be an empty field")
        
        let sut2 = ""
        XCTAssertEqual(sut2.isEmptyField, true, "sut2 should be an empty field")
    }
    
    func testBase64() {
        let sut = "Hola"
        let sutBase64 = sut.base64
        XCTAssertEqual(sutBase64 == "SG9sYQ==", true, "sutBase64 should be SG9sYQ==")
    }
    
    func testCountOfWords() {
        let sut = "Lorem fistrum llevame al sircoo por la gloria de mi madre hasta luego Lucas"
        XCTAssertEqual(sut.countofWords, 14, "sut should have 14 words")
    }
    
    func testCountOfParagraphs() {
        let sut = "Lorem fistrum jarl torpedo pupita \n qué dise usteer a peich fistro pupita."
        XCTAssertEqual(sut.countofParagraphs, 2, "sut should have 2 paragraphs")
    }
    
    func testExtractUrl() {
        let sut = "http://google.com http fpt:// http://www.albertarroyo.com"
        let urls = sut.extractURLs
        XCTAssertEqual(urls.count, 2, "sut should contain 2 urls")
        XCTAssertEqual(urls[1].absoluteString, "http://www.albertarroyo.com", "sut[1] should contain http://www.albertarroyo.com")
    }
    
    func testHtmlToAttributedString() {
        let sut = "<strong>hola</strong>"
        let sutAttributed = sut.html2AttStr!
        XCTAssertEqual(sutAttributed.isKind(of: NSAttributedString.self), true, "sut html2AttStr should be NSAttributedString")
    }
    
    func testPathExtension() {
        let sut = "http://www.albertarroyo.com/ios/swift/AATTools/docs/swift_output/index.html"
        let sutPathExtension = sut.pathExtension!
        XCTAssertEqual(sutPathExtension, "html", "sutPathExtension should be html")
    }
    
    func testLastPathComponent() {
        let sut = "http://www.albertarroyo.com/ios/swift/AATTools/docs/swift_output/index.html"
        let sutLastPathComponent = sut.lastPathComponent!
        XCTAssertEqual(sutLastPathComponent, "index.html", "sutPathExtension should be index.html")
    }
    
    func testToNSString() {
        let sut = "abca"
        XCTAssertTrue(sut.toNSString.isKind(of: NSString.self))
    }
    
    // MARK: String manipulation / util methods
    
    func testRemoveFirstChar() {
        let sut = "Hola"
        XCTAssertEqual(sut.length, 4, "Hola should have 4 characters")
        
        let sutRemovedFirstChar = sut.removedFirstChar()
        XCTAssertEqual(sutRemovedFirstChar.length, 3, "sutRemovedFirstChar should have 3 characters")
        XCTAssertEqual(sutRemovedFirstChar.firstCharacter, "o", "sutRemovedFirstChar should have o for the first character")
    }
    
    func testRemoveLastChar() {
        let sut = "Hola"
        XCTAssertEqual(sut.length, 4, "Hola should have 4 characters")
        
        let sutRemovedLastChar = sut.removedLastChar()
        XCTAssertEqual(sutRemovedLastChar.length, 3, "sutRemovedLastChar should have 3 characters")
        XCTAssertEqual(sutRemovedLastChar.lastCharacter, "l", "sutRemovedLastChar should have l for the last character")
    }
    
    func testTrimmed() {
        let sut = " Hola "
        XCTAssertEqual(sut.length, 6, "sut should have 6 characters")
        XCTAssertEqual(sut.firstCharacter, " ", "sut should have ' ' for the first character")
        XCTAssertEqual(sut.lastCharacter, " ", "sut should have ' ' for the last character")
        
        let sutTrimmed = sut.trimmed()
        XCTAssertEqual(sutTrimmed.length, 4, "sutTrimmed should have 4 characters")
        XCTAssertEqual(sutTrimmed.firstCharacter, "H", "sutTrimmed should have H for the first character")
        XCTAssertEqual(sutTrimmed.lastCharacter, "a", "sutTrimmed should have a for the last Character")
    }
    
    func testReversed() {
        let sut = "Hola"
        XCTAssertEqual(sut.firstCharacter, "H", "sut should have H for the first character")
        let sutReversed = sut.reversed()
        XCTAssertEqual(sutReversed.firstCharacter, "a", "sutReversed should have a for the first character")
        
        let sut2 = "aaBBaa"
        let sut2Reversed = sut2.reversed()
        XCTAssertEqual((sut2 == sut2Reversed), true, "sut2 and sut2Reversed should be the same")
    }
    
    func testReplace() {
        let sut = "a b c"
        let sutReplaced = sut.replaced(target: " ", withString: "+")
        XCTAssertEqual(sutReplaced == "a+b+c", true, "sutReplaced should be a+b+c")
    }
    
    func testSplit() {
        let sut = "One more thing..."
        let sutSplitted : [String] = sut.splitted(separator: " ")
        XCTAssertEqual(sutSplitted[2], "thing...", "sutSplitted in position 2 should be thing...")
        
        let sut2 = "Hey-Ho-Lets-Go"
        let expectedResult2 = ["Hey","Ho","Lets","Go"]
        XCTAssertEqual(sut2.splitted(separator: "-"), expectedResult2)
        
        let sut3 = "HeyHoLetsGo"
        let expectedResult3 = ["H","H","L","G"]
        XCTAssertEqual(sut3.splitted(separator: .lowercaseLetters), expectedResult3)
    }
    
    func testCountOcurrences() {
        let sut = "Hola hola"
        let expectedResult = 2
        XCTAssertEqual(sut.count(substring: "o"), expectedResult, "sut should contain 2 ocurrences of o")
    }
    
    func testUppercaseFirstLetter() {
        let sut = "hola"
        let sutUppercasedFirstLetter = sut.uppercasedFirstLetter()
        XCTAssertEqual(sut.firstCharacter == "h", true, "sut should have h for the first character")
        XCTAssertEqual(sutUppercasedFirstLetter.firstCharacter == "H", true, "sutUppercasedFirstLetter should have H for the first character")
    }
    
    func testUppercasePrefix() {
        let sut = "es91 2100 0418 4502 0005 1332"
        let sutUppercased = sut.uppercasedPrefix(firstNumberCharacters: 2)
        XCTAssertEqual(sutUppercased, "ES91 2100 0418 4502 0005 1332", "sutUppercased should be ES91 2100 0418 4502 0005 1332")
    }
    
    func testUppercaseSufix() {
        let sut = "1000l"
        let sutUppercased = sut.uppercasedSuffix(lastNumberCharacters: 1)
        XCTAssertEqual(sutUppercased, "1000L", "sutUppercased should be 1000L")
        
        let sut2 = "101mm"
        let sut2Uppercased = sut2.uppercasedSuffix(lastNumberCharacters: 2)
        XCTAssertEqual(sut2Uppercased, "101MM", "sut2Uppercased should be 101MM")
    }
    
    func testUppercaseRange() {
        let sut = "hola lol ."
        let sutUppercassed = sut.uppercased(range: 5..<8)
        XCTAssertEqual(sutUppercassed, "hola LOL .", "sutUppercassed should be hola LOL .")
    }
    
    func testLowercaseFirstLetter() {
        let sut = "Hola"
        let sutLowercasedFirstLetter = sut.lowercasedFirstLetter()
        XCTAssertEqual(sutLowercasedFirstLetter.firstCharacter == "h", true, "sut should have h for the first character")
    }
    
    func testLowercasePrefix() {
        let sut = "ES91 2100 0418 4502 0005 1332"
        let sutLowercased = sut.lowercasedPrefix(firstNumberCharacters: 2)
        XCTAssertEqual(sutLowercased, "es91 2100 0418 4502 0005 1332", "sutLowercased should be es91 2100 0418 4502 0005 1332")
    }
    
    func testLowercaseSufix() {
        let sut = "1000M"
        let sutLowercased = sut.lowercasedSuffix(lastNumberCharacters: 1)
        XCTAssertEqual(sutLowercased, "1000m", "sutLowercased should be 1000m")
        
        let sut2 = "101KG"
        let sut2Lowercased = sut2.lowercasedSuffix(lastNumberCharacters: 2)
        XCTAssertEqual(sut2Lowercased, "101kg", "sut2Lowercased should be 101kg")
    }
    
    func testLowercaseRange() {
        let sut = "hola LOL ."
        let sutLowercassed = sut.lowercased(range: 5..<8)
        XCTAssertEqual(sutLowercassed, "hola lol .", "sutLowercassed should be hola lol .")
    }
    
    func testGetIndexOf(){
        let sut = "HeyHoLetsGo"
        let expectedResult = 5
        XCTAssertEqual(sut.getIndexOf(character: "L"), expectedResult, "index of character L in sut should be expectedResult")
    }
    
    func testHeight() {
        let sut = "Lorem fistrum ese pedazo de al ataquerl caballo blanco caballo negroorl."
        let sut2 = "Por la gloria de mi madre te voy a borrar el cerito por la gloria de mi madre te voy a borrar el cerito ahorarr pupita torpedo fistro. Torpedo pupita sexuarl a wan diodenoo amatomaa la caidita va usté muy cargadoo te voy a borrar el cerito ahorarr. La caidita no puedor ese pedazo de la caidita pupita hasta luego Lucas fistro te va a hasé pupitaa."
        
        let sutWidth = CGFloat(100)
        let sutFont = UIFont.boldSystemFont(ofSize: 14)
        
        let sutHeight = sut.height(maxWidth: sutWidth, font: sutFont, lineBreakMode: NSLineBreakMode.byWordWrapping)
        
        let sutHeight2 = sut2.height(maxWidth: sutWidth, font: sutFont, lineBreakMode: NSLineBreakMode.byWordWrapping)
        
        XCTAssertEqual(sutHeight2 > sutHeight, true, "sutHeight2 should be greater than sutHeight")
    }
    
    // MARK: Wrapper for Index (String access)
    
    func testSubstringFrom() {
        let sut = "Hello, world"
        let from = 7
        let sutSubstringFrom = sut.substring(from: from)
        XCTAssertEqual(sutSubstringFrom == "world", true, "sutSubstringFrom should be world")
    }
    
    func testSubstringTo() {
        let sut = "Hello, world"
        let to = 5
        let sutSubstringTo = sut.substring(to: to)
        XCTAssertEqual(sutSubstringTo == "Hello", true, "sutSubstringTo should be Hello")
    }
    
    func testSubstringWithRange() {
        let sut = "Hello, world"
        let range : Range<Int> = 7..<11
        let sutSubstringRange = sut.substring(with: range)
        XCTAssertEqual(sutSubstringRange == "worl", true, "sutSubstringRange should be worl")
    }
    
    // MARK: Subscript

    func testSubscriptInt() {
        let sut = "0123456789"
        XCTAssertEqual(sut[2], "2", "position 2 of sut should be 2")
    }
    
    func testSubscriptRange() {
        let sut = "0123456789"
        XCTAssertEqual(sut[3..<5], "34", "sut in range 3..<5 should be 34")
    }
    
    func testSubscriptClosedRange() {
        let sut = "0123456789"
        XCTAssertEqual(sut[8...9], "89", "sut in range 8...9 should be 89")
    }
    
    // MARK: Localization Methods
    
    //FYI: To test the different languages you have different options
    // 1. Edit Scheme - Arguments - Add "-AppleLanguages (fr)" / "-AppleLocale fr_FR"
    // 2. You can set the keys in UserDefaults
    // 3. Maybe the best option is to have an App Language, which you can change the currentLocale with your own implementation. 
    // TODO: implement a LanguageLocalisator
    func testLocalized() {
        
        let currentLocale = NSLocale.current.languageCode
        let bundleForTest = Bundle(for: StringTest.self)
        
        let sut = "lng.generic.hello".localized(bundle: bundleForTest)
        
        if currentLocale == "en" {
            XCTAssertEqual((sut == "Hello"), true, "sut localized in en should be Hello")
        } else if currentLocale == "fr" {
            XCTAssertEqual((sut == "Bonjour"), true, "sut localized in fr should be Bonjour")
        } else if currentLocale == "es-ca" {
            XCTAssertEqual((sut == "Hola"), true, "sut localized in es-ca should be Hola")
        } else {
            XCTAssertEqual((sut == "Hello"), true, "sut localized base should be Hello")
        }
    }
    
    // MARK: URL Methods
    
    func testEncodeUrl() {
        let sut = "https://some.website.com/path/to/page?a=1&b=2"
        let url : URL? = sut.encodeURL()
        
        let path = url?.path
        let pathComponents : Array<String>? = url?.pathComponents
        let lastPathComponent = url?.lastPathComponent
        let query = url?.query
        let host = url?.host
        
        XCTAssertEqual(path == "/path/to/page", true , "path should be /path/to/page")
        XCTAssertEqual(pathComponents?.count, 4 , "pathComponents should have 4 elements /, path, to, page")
        XCTAssertEqual(lastPathComponent == "page", true , "lastComponent should be page")
        XCTAssertEqual(query == "a=1&b=2", true , "query should be a=1&b=2")
        XCTAssertEqual(host == "some.website.com", true , "host should be some.website.com")
    }
    
    func testAddPercentEncodingUrl() {
        let sut = "path/to/page"
        let sutEncodedForUrl = sut.addedPercentToEncodedForUrl()
        
        XCTAssertEqual(sutEncodedForUrl == "path%2Fto%2Fpage", true , "sutEncodedForUrl should be path%2Fto%2Fpage")
    }
    
    // MARK: Range / NSRange
    
    func testRange_NSRange() {
        let sut = "a👁b❤️c"
        let r1 = sut.range(of: "❤️")!
        
        // String range to NSRange:
        let n1 = sut.nsRange(from: r1)
        XCTAssertEqual((sut as NSString).substring(with: n1) == "❤️", true, "sut with NSRange should be ❤️")
        
        // NSRange back to String range:
        let r2 = sut.range(from: n1)!
        XCTAssertEqual(sut.substring(with: r2) == "❤️", true, "sut with Range should be ❤️")
    }
    
    // MARK: String satisfying certain conditions
    
    func testIsEmail() {
        let sut = "a@gmail.com"
        XCTAssertEqual(sut.isEmail(), true, "sut should be an email")
        
        let sut2 = "a@a."
        XCTAssertNotEqual(sut2.isEmail(), true, "sut2 should not be an email")
    }
    
    func testIsNumber() {
        let sut = "1234567980"
        XCTAssertEqual(sut.isNumber(), true, "sut should be a number")
        
        let sut2 = "hola"
        XCTAssertNotEqual(sut2.isNumber(), true, "sut2 should not be a number")
    }
    
    func testSearchSensitive() {
        let sut = "Hola hola HOLa"
        let stringToSearch = "HOLa"
        XCTAssertEqual(sut.containsSensitive(string: stringToSearch), true, "stringToSearch should be in sut")
        
        let stringToSearch2 = "HolA"
        XCTAssertNotEqual(sut.containsSensitive(string: stringToSearch2), true, "stringToSearch2 should not be in sut")
    }
    
    func testSearchNotSensitive() {
        let sut = "Hola hOla HOLa"
        let stringToSearch = "hola"
        XCTAssertEqual(sut.containsNotSensitive(string: stringToSearch), true, "stringToSearch should be in sut")
    }
    
    func testMatchRegex() {
        let sut = "H3yH0L3tsG0"
        let expectedResult = ["3","0","3","0"]
        XCTAssertEqual(sut.matchesForRegexInText(regex: "[0-9]"), expectedResult, "sut.matchesForRegexInText should return expectedResult")
    }
    
    // MARK: Tracting Numbers / Conversions / Utils for Banking Apps
    
    func testToDouble() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: Locale.current.identifier)
        
        let sut = "5.42"
        
        if let sutDoubleExpected = formatter.number(from: sut) {
            let sutDouble = sut.toDouble()
            XCTAssertEqual(sutDouble, Double(sutDoubleExpected), "sutDouble should be sutDoubleExpected")
        } else {
            let sut2 = "5,42"
            if let sut2DoubleExpected = formatter.number(from: sut2) {
                let sut2Double = sut2.toDouble()
                XCTAssertEqual(sut2Double, Double(sut2DoubleExpected), "sutDouble should be sutDoubleExpected")
            }
        }
        
    }
    
    func testToInt() {
        let sut = "0123455"
        XCTAssertNotNil(sut.toInt())
    }
    
    func testToFloat() {
        let sut = "0.12"
        XCTAssertNotNil(sut.toFloat())
    }
    
    func testToBool() {
        let sut = "true"
        XCTAssertEqual(sut.toBool(), true, "sut should be true")
        
        let sut2 = " FALSE "
        XCTAssertEqual(sut2.toBool(), false, "sut2 should be true")
    }
    
    func testFormatNumberWithDecimals() {
        let sut = "5.1234567"
        let sutDecimals = 3
        let sutStringDoubleFormatted = sut.formatNumber(decimals: sutDecimals)
        XCTAssertEqual(sutStringDoubleFormatted == "5.123", true, "sutStringDoubleFormatted should be 5.123")
    }
    
    func testFormatAccountNumber() {
        let sut = "2077 0024 00 3102575766"
        let sutWithoutWitheSpaces = sut.removedWitheSpaces()
        let sutAccountNumber = sutWithoutWitheSpaces.formattedAccountNumber()
        XCTAssertEqual(sutAccountNumber == "2077-0024-00-3102575766", true, "sutAccountNumber should be 2077-0024-00-3102575766")
    }
    
    func testFormatIbanNumber() {
        let sut = "ES9121000418450200051332"
        let sutIbanNumber = sut.formattedIbanNumber()
        XCTAssertEqual(sutIbanNumber == "ES91 2100 0418 4502 0005 1332", true, "sutIbanNumber should be ES91 2100 0418 4502 0005 1332")
    }
    
    func testRemoveTrailingZero() {
        let sut = "0.10000000"
        let sutRemovedTrailingZero = sut.removedTrailingZeros(decimals: 2)
        XCTAssertEqual(sutRemovedTrailingZero == "0.1", true, "sutRemovedTrailingZero should be 0.1")
        
        let sut2 = "0.0101000000"
        let sut2RemovedTrailingZero = sut2.removedTrailingZeros(decimals: 4)
        XCTAssertEqual(sut2RemovedTrailingZero == "0.0101", true, "sut2RemovedTrailingZero should be 0.0101")
        
        let sut3 = "12345.678000000"
        let sut3RemovedTrailingZero = sut3.removedTrailingZeros(decimals: 3)
        XCTAssertEqual(sut3RemovedTrailingZero == "12345.678", true, "sut3RemovedTrailingZero should be 12345.678")
    }
    
    // MARK: NSAttributedString
    
    func testBold() {
        let sut = "hola"
        let boldExpected = NSAttributedString(string: sut, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
        XCTAssertEqual(sut.bold(), boldExpected, "sut bold should be boldExpected")
    }
    
    func testUnderline() {
        let sut = "hola"
        let underlineExpected = NSAttributedString(string: sut, attributes: [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])
        XCTAssertEqual(sut.underline(), underlineExpected, "sut underline should be underlineExpected")
    }
    
    func testItalic() {
        let sut = "hola"
        let italicExpected = NSAttributedString(string: sut, attributes: [NSFontAttributeName: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
        XCTAssertEqual(sut.italic(), italicExpected, "sut italic should be italicExpected")
    }
    
    func testColor() {
        let sut = "hola"
        let colorExpected = NSAttributedString(string: sut, attributes: [NSForegroundColorAttributeName: UIColor.green])
        XCTAssertEqual(sut.color(UIColor.green), colorExpected, "sut color should be colorExpected")
    }
    
    func testColorSubstring() {
        let sut = "hello world"
        let sutColor = sut.color(substring: "hello", color: UIColor.green)
        XCTAssertEqual(sutColor.isKind(of: NSAttributedString.self), true, "sutColor should kind of NSAttributedString")
    }
    
    // MARK: String manipulation (mutating methods)
    
    //TODO: add tests
//    func  testInsert() {
//        
//    }
//    
//    func testRemove() {
//        
//    }
//    
//    func testReverse() {
//        
//    }
    
    // MARK: Emoji
    
    func testContainsEmoji() {
        let sut = "Incididunt tempor ad 😃 sint Lorem amet 🍷 Elit ut dolore ad est qui magna 🍻"
        XCTAssertTrue(sut.containsEmoji(), "sut should contain emoji characters")
    }
    
    // MARK: HTML
    
    func testDecodeHtmlEntities() {
        let sut = "&gt; Hola"
        let sutDecodedHtml = sut.stringByDecodingHTMLEntities
        XCTAssertEqual(sutDecodedHtml.firstCharacter == ">", true, "sutDecodedHtml first character should be > ")
    }
}
