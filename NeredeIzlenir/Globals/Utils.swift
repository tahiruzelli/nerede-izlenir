//
//  ArrayToString.swift
//  NeredeIzlenir
//
//  Created by Tahir Uzelli on 24.06.2022.
//

import Foundation

func arrayToString(array : [Any])->String{
    var newString = ""
    for element in array{
        let newElement = element as? String ?? ""
        
        newString  = newString + newElement + ","
    }
    newString = String(newString.dropLast())
    return newString
}

func formatSliderValue(value : Float)->String{
    let stringValue : String = String(value)
    var returnunValue : String = ""
    returnunValue = String(stringValue.split(separator: ".")[0])
    returnunValue = returnunValue + "."
    let rightValue : String = String(stringValue.split(separator: ".")[1])
    returnunValue = returnunValue + "\(Array(rightValue)[0])"

    return returnunValue
}
