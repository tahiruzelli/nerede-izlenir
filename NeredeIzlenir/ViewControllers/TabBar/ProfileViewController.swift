//
//  ProfileViewController.swift
//  NeredeIzlenir
//
//  Created by Tahir Uzelli on 30.06.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func previusWatchAction(_ sender: Any) {
        selectedWatchListType = .previusWatch
    }
    @IBAction func watchListAction(_ sender: Any) {
        selectedWatchListType = .watchList
    }
}
