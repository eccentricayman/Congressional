//
//  website.swift
//  Congressional
//
//  Created by Ayman Ahmed on 4/8/17.
//  Copyright © 2017 Ayman Ahmed. All rights reserved.
//

import Foundation
import Kanna

func getHTML(_ myURLString: String) {
    guard let myURL = URL(string: myURLString)
    else {
        print("ERROR")
        //my own error message
        return "___ERROR___"
    }

    do {
        let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
        return myHTMLString
    }
    catch let error {
        print("Error: \(error)")
    }
}
