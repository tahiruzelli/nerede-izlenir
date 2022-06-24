//
//  ShuffleViewController.swift
//  NeredeIzlenir
//
//  Created by Tahir Uzelli on 23.06.2022.
//

import UIKit
import MultiStepSlider
import KDropDownMultipleSelection

class ShuffleViewController: BaseViewController, kDropDownListViewDelegate{
    func dropDownListView(_ dropdownListView: DropDownListView!, didSelectedIndex anIndex: Int) {
        print("kel")
    }
    
    func dropDownListView(_ dropdownListView: DropDownListView!, datalist ArryData: NSMutableArray!) {
        
    print("afwe")
    }
    
    func dropDownListViewDidCancel() {
        print("hasan")
    }
    
    
    @IBOutlet weak var platformsCollectionView: UICollectionView!
    
    @IBOutlet weak var yearSliderView: UIView!
    @IBOutlet weak var imdbSliderView: UIView!
    @IBOutlet weak var tmdbSliderView: UIView!
    @IBOutlet weak var dropDownView: UIView!
    
    let yearSlider = MultiStepRangeSlider()
    let imdbSlider = MultiStepRangeSlider()
    let tmdbSlider = MultiStepRangeSlider()
    
    var typeDropDown : DropDownListView?

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
        dropDownView.setCornerRadius(radius: 10)
        dropDownView.layer.borderColor = UIColor(named: "ColorOrange")!.cgColor
        dropDownView.layer.borderWidth = 2

        typeDropDown =        DropDownListView(title: "test", options: [],  xy: CGPoint(x: 0, y: 600), size: CGSize(width: view.frame.width, height: 200), isMultiple: true)
        typeDropDown?.backgroundColor = .blue
        typeDropDown!.delegate = self
        
        
        platformsCollectionView.delegate = self
        platformsCollectionView.dataSource = self
        dropDownView.addSubview(typeDropDown!)
        view.addSubview(typeDropDown!)
    }
    
    
    
    func initView(){
        let intervals = [Interval(min: 1900, max: 2022, stepValue: 1900),
        Interval(min: 100000, max: 1000000, stepValue: 100000),
        Interval(min: 1000000, max: 3000000, stepValue: 500000)]
        let preSelectedRange = RangeValue(lower: 80000, upper: 500000)
        yearSlider.configureSlider(intervals: intervals, preSelectedRange: preSelectedRange)
        yearSlider.frame = CGRect(x: 0, y: 0, width: yearSliderView.frame.width, height: 25)
        yearSliderView.addSubview(yearSlider)
        yearSlider.trackLayerHeight = 3
        yearSlider.thumbTintColor = .white
        yearSlider.thumbSize = CGSize(width: 25, height: 25)
        yearSlider.trackHighlightTintColor = UIColor(named: "ColorOrange")!
        

        imdbSlider.configureSlider(intervals: intervals, preSelectedRange: preSelectedRange)
        imdbSlider.frame = CGRect(x: 0, y: 0, width: imdbSliderView.frame.width, height: 25)
        imdbSliderView.addSubview(imdbSlider)
        imdbSlider.trackLayerHeight = 3
        imdbSlider.thumbTintColor = .white
        imdbSlider.thumbSize = CGSize(width: 25, height: 25)
        imdbSlider.trackHighlightTintColor = UIColor(named: "ColorOrange")!
        
    
        tmdbSlider.configureSlider(intervals: intervals, preSelectedRange: preSelectedRange)
        tmdbSlider.frame = CGRect(x: 0, y: 0, width: tmdbSliderView.frame.width, height: 25)
        tmdbSliderView.addSubview(tmdbSlider)
        tmdbSlider.trackLayerHeight = 3
        tmdbSlider.thumbTintColor = .white
        tmdbSlider.thumbSize = CGSize(width: 25, height: 25)
        tmdbSlider.trackHighlightTintColor = UIColor(named: "ColorOrange")!
    }

}

extension ShuffleViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return platformImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlatformCollectionViewCell", for: indexPath) as! PlatformCollectionViewCell
            cell.platformImage.image = UIImage(named: platformImages[indexPath.row])
              return cell
    }
    
}
