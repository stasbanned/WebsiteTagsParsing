//
//  ViewController.swift
//  WebsiteTagsParsing
//
//  Created by Станислав Тищенко on 11.05.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var s: String = ""
    @IBOutlet weak var urlText: UITextField!
    @IBOutlet weak var parseText: UITextView!
    @IBAction func parseButton(_ sender: Any) {
        let a = Parse()
        parseText.text = a.parse(url: urlText.text! )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class Parse {
    var text: String = ""
    var tagName: String = ""
    var flag: Bool = false
    var text1: String = ""
    var arrayOfTags: [String] = []
    func parse(url: String) -> String {
        guard let myURL = URL(string: url) else {
            print("Error: \(url) doesn't seem to be a valid URL")
            return "Error: \(url) doesn't seem to be a valid URL"
        }
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            //print("HTML : \(myHTMLString)")
            text = myHTMLString
        } catch let error {
            print("Error: \(error)")
        }
        for i in Array(text) {
            if i == "<" {
                tagName = ""
                flag = true
            }
            if flag == true && i != ">" && i != " " && i != "<" {
                tagName += String(i)
            }
            if i == ">" || i == " " && flag == true {
                flag = false
                if tagName != "" && !tagName.contains("/"){
                    arrayOfTags.append(tagName)
                }
                tagName = ""
            }
        }
        print(arrayOfTags)
        var count = 0
        var countForDuplicates = -1
        for i in arrayOfTags {
            if text.contains(String(i)) {
                count = 0
                countForDuplicates = -1
                for j in arrayOfTags {
                    if j == i {
                        count += 1
                    }
                }
                //print(arrayOfTags)
                if !text1.contains("\(i): \(count) times.\n") {
                    text1 += "\(i): \(count) times.\n"
                }
    //            for k in arrayOfTags {
    //                countForDuplicates += 1
    //                if k == i {
    //                    arrayOfTags.remove(at: countForDuplicates)
    //                    countForDuplicates -= 1
    //                }
    //            }
                }
        }
        print(text1)
        
        
        return text1
    }
}
