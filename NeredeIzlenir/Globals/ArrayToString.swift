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
    return newString
}
