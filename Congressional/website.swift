//
//  website.swift
//  Congressional
//
//  Created by Ayman Ahmed on 4/8/17.
//  Copyright © 2017 Ayman Ahmed. All rights reserved.
//

import Foundation
import Kanna

//usage:
//getBill("hr-200")
//sres = senate resolution
//hres = house resolution
//hr = house bill
//s = senate bill
//hconres = house concurrent resolution
//hjres = house joint resolution
//sjres = senate joint resolution
func getBill(_ data : String) -> [String : String]? {
    let html = getHTML(data)
    let title = getTitle(html)
    let topic = getTopic(html)
    let summary = getSummary(html)
    let progress = getProgress(html)
    
    let retDict = [
        "title" : title,
        "topic" : topic,
        "summary" : summary,
        "progress" : progress
    ]
    return retDict;
}

func getHTML(_ data : String) -> String {
    var splitData = data.components(separatedBy: "-")
    let type : String = splitData[0];
    let number : String = splitData[1];
    
    var myURLString : String = ""
    if (type == "sres") {
        myURLString = "https://www.congress.gov/bill/115th-congress/senate-resolution/" + number
    }
    else if (type == "hres") {
        myURLString = "https://www.congress.gov/bill/115th-congress/house-resolution/" + number
    }
    else if (type == "hr") {
        myURLString = "https://www.congress.gov/bill/115th-congress/house-bill/" + number
    }
    else if (type == "s") {
        myURLString = "https://www.congress.gov/bill/115th-congress/senate-bill/" + number
    }
    else if (type == "hconres") {
        myURLString = "https://www.congress.gov/bill/115th-congress/house-concurrent-resolution/" + number
    }
    else if (type == "hjres") {
        myURLString = "https://www.congress.gov/bill/115th-congress/house-joint-resolution/" + number
    }
    else if (type == "sjres") {
        myURLString = "https://www.congress.gov/bill/115th-congress/senate-joint-resolution/" + number
    }
    
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
        return "___ERROR___"
    }
}

//gets title, pass html doc
func getTitle(_ htmlString : String) -> String {
    let html = Kanna.HTML(html: htmlString, encoding: String.Encoding.utf8)
    return (html?.xpath("//*[@id='content']/div[1]/h1")[0].text)!
}

func getTopic(_ htmlString : String) -> String {
    let html = Kanna.HTML(html: htmlString, encoding: String.Encoding.utf8)
    return (html?.xpath("//*[@id='content']/div[1]/div[4]/div[2]/div[4]/ul/li[1]")[0].text)!
}

func getSummary(_ htmlString : String) -> String {
    let html = Kanna.HTML(html: htmlString, encoding: String.Encoding.utf8)
    let fullSummary : String = (html?.xpath("//*[@id='bill-summary']/p")[0].text)!
    
    //cutoff 150 chars
    let index = fullSummary.index(fullSummary.startIndex, offsetBy: 150)
    let summary = fullSummary.substring(to: index) + "..."
    
    return summary
}

func getProgress(_ htmlString : String) -> String {
    let html = Kanna.HTML(html: htmlString, encoding: String.Encoding.utf8)
    let currentprogress : String = (html?.xpath("//*[@id='content']/div[1]/div[4]/div[1]/div[1]/ol/li[@class='selected']")[0].text)!
    
    if (currentprogress == "Introduced") {
        return "I"
    }
    else if (currentprogress == "Passed House") {
        return "HR"
    }
    else if (currentprogress == "Passed Senate") {
        return "S"
    }
    else if (currentprogress == "To President") {
        return "P"
    }
    //if empty string assume is law
    else if (currentprogress == "Became Law") {
        return ""
    }
    //doesnt reach here
    return "___ERROR___"
}
