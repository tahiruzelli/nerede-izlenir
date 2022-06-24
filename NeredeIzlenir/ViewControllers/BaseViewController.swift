//
//  BaseViewController.swift
//  NeredeIzlenir
//
//  Created by Tahir Uzelli on 24.06.2022.
//

import UIKit

class BaseViewController: UIViewController {
    
    var movies : [Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movies = loadJson(fileName: "MovieData")
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        print("Test")
        GlobalHelper.pushVC(self, identifier: "TabBarViewController", storyBoardName: "Main")
    }
    
    func loadJson(fileName: String) -> [Movie]? {
       let decoder = JSONDecoder()
       guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let movies = try? decoder.decode([Movie].self, from: data)
       else {
            return nil
       }

       return movies
    }
}
