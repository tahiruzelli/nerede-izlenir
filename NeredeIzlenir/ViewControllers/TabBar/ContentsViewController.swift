//
//  ContentsViewController.swift
//  NeredeIzlenir
//
//  Created by Tahir Uzelli on 21.06.2022.
//

import UIKit
import MultiStepSlider

class ContentsViewController: BaseViewController {
    @IBOutlet weak var sortButtonView: UIImageView!
    @IBOutlet weak var filterButtonView: UIImageView!
    
    @IBOutlet weak var contentCountLabel: UILabel!
    
    @IBOutlet weak var contentsCollectionView: UICollectionView!
    @IBOutlet weak var platformsCollectionView: UICollectionView!
    @IBOutlet weak var allButtonView: UIButton!
    
    @IBOutlet weak var seriesButtonView: UIButton!
    @IBOutlet weak var movieButtonView: UIButton!
    //popup outlets
    @IBOutlet weak var filterCloseButtonView: UIImageView!
    @IBOutlet weak var sortPopUpBackgroundView: UIView!
    @IBOutlet weak var filterBackgroundView: UIView!
    @IBOutlet weak var tmdbSlider: UISlider!
    @IBOutlet weak var rottenSlider: UISlider!
    @IBOutlet weak var metaSlider: UISlider!
    @IBOutlet weak var imdbSlider: UISlider!
    @IBOutlet weak var yearSliderView: UIView!
    
    @IBOutlet weak var upperYearLabel: UILabel!
    @IBOutlet weak var lowerYearLabel: UILabel!
    @IBOutlet weak var rottenLabel: UILabel!
    @IBOutlet weak var metaLabel: UILabel!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var tmdbLabel: UILabel!
    
    // sort pop up outlets
    
    @IBOutlet weak var sortPopularityLabel: UILabel!
    @IBOutlet weak var sortYearLabel: UILabel!
    @IBOutlet weak var sortNameLabel: UILabel!
    @IBOutlet weak var sortImdbLabel: UILabel!
    
    @IBOutlet weak var sortImdbIcon: UIImageView!
    @IBOutlet weak var sortYearIcon: UIImageView!
    @IBOutlet weak var sortNameIcon: UIImageView!
    @IBOutlet weak var sortPopularIcon: UIImageView!
    
    let yearSlider = MultiStepRangeSlider()
    
    var selectedPlatforms : SelectedPlatforms = SelectedPlatforms()
    
    var filteredMovies : [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        filteredMovies = movies ?? []
        contentCountLabel.text = String(filteredMovies.count) + " adet içerik listelendi"
        
        contentsCollectionView.delegate = self
        contentsCollectionView.dataSource = self
        
        platformsCollectionView.delegate = self
        platformsCollectionView.dataSource = self
    
    }
    
    func initView(){
        allButtonView.backgroundColor = .darkGray
        let intervals = [Interval(min: 1900, max: 2022, stepValue: 1),
        Interval(min: 1900, max: 2022, stepValue: 1),
        Interval(min: 1900, max: 2022, stepValue: 1)]
        let preSelectedRange = RangeValue(lower: 1900, upper: 2022)
        yearSlider.configureSlider(intervals: intervals, preSelectedRange: preSelectedRange)
        yearSlider.frame = CGRect(x: 50, y: 0, width: yearSliderView.frame.width - 90, height: 30)
        yearSliderView.addSubview(yearSlider)
        yearSlider.trackLayerHeight = 3
        yearSlider.thumbTintColor = .white
        yearSlider.thumbSize = CGSize(width: 25, height: 25)
        yearSlider.trackHighlightTintColor = UIColor(named: "ColorOrange")!
        
        sortPopUpBackgroundView.backgroundColor = .black.withAlphaComponent(0.7)
        filterBackgroundView.backgroundColor = .black.withAlphaComponent(0.7)
        var tap = UITapGestureRecognizer(target: self, action: #selector(onFilterButtonPressed))
        filterButtonView.isUserInteractionEnabled = true
        filterButtonView.addGestureRecognizer(tap)
        tap = UITapGestureRecognizer(target: self, action: #selector(onSortButtonPressed))
        sortButtonView.isUserInteractionEnabled = true
        sortButtonView.addGestureRecognizer(tap)
        tap = UITapGestureRecognizer(target: self, action: #selector(onSortButtonPressed))
        sortPopUpBackgroundView.isUserInteractionEnabled = true
        sortPopUpBackgroundView.addGestureRecognizer(tap)
        tap = UITapGestureRecognizer(target: self, action: #selector(onCancelButtonPressed))
        filterCloseButtonView.isUserInteractionEnabled = true
        filterCloseButtonView.addGestureRecognizer(tap)
        
        yearSlider.addTarget(self, action: #selector(yearSliderChanged), for: .allEvents)
        
    }
    
    func getFilteredMovies(){
        let filteredArray = movies?.filter {
            (selectedPlatforms.netflix && $0.streamingInfo?.netflix?.tr.link != nil) ||
            (selectedPlatforms.appleTv && $0.streamingInfo?.appleTv?.tr.link != nil) ||
            (selectedPlatforms.puhuTv && $0.streamingInfo?.puhuTv?.tr.link != nil) ||
            (selectedPlatforms.prime && $0.streamingInfo?.prime?.tr.link != nil) ||
            (selectedPlatforms.mubi && $0.streamingInfo?.mubi?.tr.link != nil) ||
            (selectedPlatforms.googlePlay && $0.streamingInfo?.googlePlay?.tr.link != nil) ||
            (selectedPlatforms.blutv && $0.streamingInfo?.blutv?.tr.link != nil)
        }
        filteredMovies = filteredArray ?? []
        if SelectedPlatforms.isAllFalse(object: selectedPlatforms){
            filteredMovies = movies ?? []
        }
        contentCountLabel.text = String(filteredMovies.count) + " adet içerik listelendi"
    }
    
    func makeAllSortButtonsNormal(){
        sortNameIcon.tintColor = .white
        sortNameLabel.textColor = .white
        sortPopularIcon.tintColor = .white
        sortPopularityLabel.textColor = .white
        sortYearIcon.tintColor = .white
        sortYearLabel.textColor = .white
        sortImdbIcon.tintColor = .white
        sortImdbLabel.textColor = .white
    }
    
    @objc func yearSliderChanged(){
        upperYearLabel.text = String(Int(yearSlider.continuousCurrentValue.upper))
        lowerYearLabel.text = String(Int(yearSlider.continuousCurrentValue.lower))
    }
    
    @objc func onFilterButtonPressed(){
        filterBackgroundView.isHidden = !filterBackgroundView.isHidden
    }
    
    @objc func onSortButtonPressed(){
        sortPopUpBackgroundView.isHidden = !sortPopUpBackgroundView.isHidden
    }
    
    @objc func onCancelButtonPressed(){
        filterBackgroundView.isHidden = !filterBackgroundView.isHidden
    }
    
    @IBAction func fliterDoneAction(_ sender: Any) {
        let minYear : Int = Int(yearSlider.discreteCurrentValue.lower)
        let maxYear : Int = Int(yearSlider.discreteCurrentValue.upper)
        let minImdb : Double = Double(formatSliderValue(value: imdbSlider.value))!
        let minTmdb : Double = Double(formatSliderValue(value: tmdbSlider.value))!
        let minMeta : Double = Double(formatSliderValue(value: metaSlider.value))!
        let minRotten : Double = Double(formatSliderValue(value: rottenSlider.value))!
        
        filteredMovies = movies!.filter { ($0.yearNumber ?? 0 >=  minYear) && ($0.yearNumber ?? 0 <=  maxYear) && ($0.imdb?.rate ?? 0 >= minImdb)  && ($0.tmdb?.rate ?? 0 >= minTmdb) && ($0.metascore?.rate ?? 0 >= minMeta) && ($0.rotten?.rate ?? 0 >= minRotten)
        }
        contentCountLabel.text = String(filteredMovies.count) + " adet içerik listelendi"
        contentsCollectionView.reloadData()
        filterBackgroundView.isHidden = !filterBackgroundView.isHidden
            
    }
    @IBAction func cleanFilterAction(_ sender: Any) {
        filteredMovies = movies ?? []
        contentCountLabel.text = String(filteredMovies.count) + " adet içerik listelendi"
        contentsCollectionView.reloadData()
        filterBackgroundView.isHidden = !filterBackgroundView.isHidden
        imdbSlider.value = 0
        metaSlider.value = 0
        rottenSlider.value = 0
        tmdbSlider.value = 0
        imdbLabel.text = "\(formatSliderValue(value:imdbSlider.value))" + "/10"
        metaLabel.text = "\(formatSliderValue(value:metaSlider.value)))" + "/100"
        tmdbLabel.text = "\(formatSliderValue(value:tmdbSlider.value)))" + "/100"
        rottenLabel.text = "\(formatSliderValue(value:rottenSlider.value)))" + "/100"
        let intervals = [Interval(min: 1900, max: 2022, stepValue: 1),
        Interval(min: 1900, max: 2022, stepValue: 1),
        Interval(min: 1900, max: 2022, stepValue: 1)]
        let preSelectedRange = RangeValue(lower: 1900, upper: 2022)
        yearSlider.configureSlider(intervals: intervals, preSelectedRange: preSelectedRange)
    }
    
    @IBAction func nameSortAction(_ sender: Any) {
        filteredMovies = filteredMovies.sorted(by: {$0.title?.original ?? "" > $1.title?.original ?? ""})
        contentsCollectionView.reloadData()
        makeAllSortButtonsNormal()
        sortNameIcon.tintColor = .lightGray
        sortNameLabel.textColor = .lightGray
        sortPopUpBackgroundView.isHidden = !sortPopUpBackgroundView.isHidden
    }
    @IBAction func yearSortAction(_ sender: Any) {
        filteredMovies = filteredMovies.sorted(by: {$0.yearNumber ?? 0 > $1.yearNumber ?? 0})
        contentsCollectionView.reloadData()
        makeAllSortButtonsNormal()
        sortYearIcon.tintColor = .lightGray
        sortYearLabel.textColor = .lightGray
        sortPopUpBackgroundView.isHidden = !sortPopUpBackgroundView.isHidden
    }
    @IBAction func imdbSortAction(_ sender: Any) {
        filteredMovies = filteredMovies.sorted(by: {$0.imdb?.rate ?? 0 > $1.imdb?.rate ?? 0})
        contentsCollectionView.reloadData()
        makeAllSortButtonsNormal()
        sortImdbIcon.tintColor = .lightGray
        sortImdbLabel.textColor = .lightGray
        sortPopUpBackgroundView.isHidden = !sortPopUpBackgroundView.isHidden
    }
    
    @IBAction func popularitySortAction(_ sender: Any) {
        //TODO sort as first type of json
        filteredMovies = filteredMovies.sorted(by: {$0.imdb?.rate ?? 0 > $1.imdb?.rate ?? 0})
        contentsCollectionView.reloadData()
        makeAllSortButtonsNormal()
        sortPopularIcon.tintColor = .lightGray
        sortPopularityLabel.textColor = .lightGray
        sortPopUpBackgroundView.isHidden = !sortPopUpBackgroundView.isHidden
    }
    
    @IBAction func imdbSliderAction(_ sender: Any) {
        imdbLabel.text = "\(formatSliderValue(value:imdbSlider.value))" + "/10"
    }
    @IBAction func metaSliderAction(_ sender: Any) {
        metaLabel.text = "\(formatSliderValue(value:metaSlider.value))" + "/100"
    }
    @IBAction func tmdbSliderActio(_ sender: Any) {
        tmdbLabel.text = "\(formatSliderValue(value:tmdbSlider.value))" + "/100"
    }
    @IBAction func rottenSliderAction(_ sender: Any) {
        rottenLabel.text = "\(formatSliderValue(value:rottenSlider.value))" + "/100"
    }

    
    @IBAction func movieButtonAction(_ sender: Any) {
        movieButtonView.backgroundColor = .darkGray
        seriesButtonView.backgroundColor = .clear
        allButtonView.backgroundColor = .clear
        filteredMovies = movies ?? []
        filteredMovies = filteredMovies.filter { $0.contentType == "movie"}
        contentCountLabel.text = String(filteredMovies.count) + " adet içerik listelendi"
        contentsCollectionView.reloadData()
    }
    @IBAction func seriesButtonAction(_ sender: Any) {
        movieButtonView.backgroundColor = .clear
        seriesButtonView.backgroundColor = .darkGray
        allButtonView.backgroundColor = .clear
        filteredMovies = movies ?? []
        filteredMovies = filteredMovies.filter { $0.contentType == "series"}
        contentCountLabel.text = String(filteredMovies.count) + " adet içerik listelendi"
        contentsCollectionView.reloadData()
    }
    
    @IBAction func allButtonAction(_ sender: Any) {
        movieButtonView.backgroundColor = .clear
        seriesButtonView.backgroundColor = .clear
        allButtonView.backgroundColor = .darkGray
        filteredMovies = movies ?? []
        filteredMovies = filteredMovies.filter { $0.contentType == "series" || $0.contentType == "movie"}
        contentCountLabel.text = String(filteredMovies.count) + " adet içerik listelendi"
        contentsCollectionView.reloadData()
    }
    
}

extension ContentsViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.contentsCollectionView{
            return filteredMovies.count
        }
        else if collectionView == self.platformsCollectionView {
            return platformImages.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.contentsCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as! ContentCollectionViewCell
            cell.titleLabel.text = filteredMovies[indexPath.row].title?.original
            cell.movie = filteredMovies[indexPath.row]
              return cell
        }
        else if collectionView == self.platformsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlatformCollectionViewCell", for: indexPath) as! PlatformCollectionViewCell
            cell.platformImage.image = UIImage(named: platformImages[indexPath.row])
            if SelectedPlatforms.isAllFalse(object: selectedPlatforms){
                cell.platformImage.alpha = 1
            }
            else{
                switch platformImages[indexPath.row] {
                case "apple":
                    if !selectedPlatforms.appleTv {cell.platformImage.alpha = 0.5}
                    else{cell.platformImage.alpha = 1}
                case "blutv":
                    if !selectedPlatforms.blutv{cell.platformImage.alpha = 0.5}
                    else {cell.platformImage.alpha = 1}
                case "google":
                    if !selectedPlatforms.googlePlay {cell.platformImage.alpha = 0.5}
                    else{cell.platformImage.alpha = 1}
                case "mubi":
                    if !selectedPlatforms.mubi {cell.platformImage.alpha = 0.5}
                    else{cell.platformImage.alpha = 1}
                case "netflix":
                    if !selectedPlatforms.netflix {cell.platformImage.alpha = 0.5}
                    else{cell.platformImage.alpha = 1}
                case "prime":
                    if !selectedPlatforms.prime {cell.platformImage.alpha = 0.5}
                    else{cell.platformImage.alpha = 1}
                case "puhutv":
                    if !selectedPlatforms.puhuTv {cell.platformImage.alpha = 0.5}
                    else{cell.platformImage.alpha = 1}
                default:
                    print("error")
                }
            }
            return cell
        }
        else {
            //ERROR
            let cell = UICollectionViewCell()
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.platformsCollectionView {
            switch indexPath.row {
            case 0:
                selectedPlatforms.appleTv = !selectedPlatforms.appleTv
            case 1:
                selectedPlatforms.blutv = !selectedPlatforms.blutv
            case 2:
                selectedPlatforms.googlePlay = !selectedPlatforms.googlePlay
            case 3:
                selectedPlatforms.mubi = !selectedPlatforms.mubi
            case 4:
                selectedPlatforms.netflix = !selectedPlatforms.netflix
            case 5:
                selectedPlatforms.prime = !selectedPlatforms.prime
            case 6:
                selectedPlatforms.puhuTv = !selectedPlatforms.puhuTv
            default:
                print("error")
            }
            
            getFilteredMovies()
            
            self.platformsCollectionView.reloadData()
            self.contentsCollectionView.reloadData()
            
        }
    }
    
}
