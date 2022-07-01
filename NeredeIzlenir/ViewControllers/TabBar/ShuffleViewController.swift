//
//  ShuffleViewController.swift
//  NeredeIzlenir
//
//  Created by Tahir Uzelli on 23.06.2022.
//

import UIKit
import MultiStepSlider

class ShuffleViewController: BaseViewController{

    @IBOutlet weak var dropdownBackgroundView: UIView!

    @IBOutlet weak var genresTableView: UITableView!
    @IBOutlet weak var platformsCollectionView: UICollectionView!
    
    @IBOutlet weak var tmdbSlider: UISlider!
    @IBOutlet weak var imdbSlider: UISlider!
    
    @IBOutlet weak var yearSliderView: UIView!
    @IBOutlet weak var imdbSliderView: UIView!
    @IBOutlet weak var tmdbSliderView: UIView!
    @IBOutlet weak var dropDownView: UIView!
    
    
    @IBOutlet weak var lowerYearLabel: UILabel!
    @IBOutlet weak var upperYearLabel: UILabel!
    @IBOutlet weak var tmdbLabel: UILabel!
    @IBOutlet weak var imdbLabel: UILabel!
    
    let yearSlider = MultiStepRangeSlider()
    
    var selectedPlatforms : SelectedPlatforms = SelectedPlatforms()
    var previusMovies : [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
        genresTableView.allowsMultipleSelection = true
        genresTableView.allowsMultipleSelectionDuringEditing = true
        
        platformsCollectionView.delegate = self
        platformsCollectionView.dataSource = self
        genresTableView.dataSource = self
        genresTableView.delegate = self
        
        yearSlider.addTarget(self, action: #selector(yearSliderChanged), for: .allEvents)
    }
    
    @objc func yearSliderChanged(){
        upperYearLabel.text = String(Int(yearSlider.continuousCurrentValue.upper))
        lowerYearLabel.text = String(Int(yearSlider.continuousCurrentValue.lower))
        previusMovies = []
    }
    
    func getRandomMovie()->Movie?{
        let minYear : Int = Int(yearSlider.discreteCurrentValue.lower)
        let maxYear : Int = Int(yearSlider.discreteCurrentValue.upper)
        let minImdb : Double = Double(formatSliderValue(value: imdbSlider.value))!
        let minTmdb = Double(formatSliderValue(value: tmdbSlider.value))!
        
        var filteredMovies : [Movie] = movies ?? []
        
        for item in previusMovies {
            if let index = filteredMovies.firstIndex(where: {$0 === item}){
                filteredMovies.remove(at: index)
            }
        }
        
        if SelectedPlatforms.isAllFalse(object: selectedPlatforms){
            //filter as only year and rates
            filteredMovies = filteredMovies.filter { ($0.yearNumber ?? 0 >=  minYear) && ($0.yearNumber ?? 0 <=  maxYear) && ($0.imdb?.rate ?? 0 >= minImdb)  && ($0.tmdb?.rate ?? 0 >= minTmdb)
            }
        }
        else{
            //filter as platforms and other filters
            filteredMovies = filteredMovies.filter {
                ((selectedPlatforms.netflix && $0.streamingInfo?.netflix?.tr.link != nil) ||
                (selectedPlatforms.appleTv && $0.streamingInfo?.appleTv?.tr.link != nil) ||
                (selectedPlatforms.puhuTv && $0.streamingInfo?.puhuTv?.tr.link != nil) ||
                (selectedPlatforms.prime && $0.streamingInfo?.prime?.tr.link != nil) ||
                (selectedPlatforms.mubi && $0.streamingInfo?.mubi?.tr.link != nil) ||
                (selectedPlatforms.googlePlay && $0.streamingInfo?.googlePlay?.tr.link != nil) ||
                (selectedPlatforms.blutv && $0.streamingInfo?.blutv?.tr.link != nil)) &&
                ($0.yearNumber ?? 0 >=  minYear) && ($0.yearNumber ?? 0 <=  maxYear) && ($0.imdb?.rate ?? 0 >= minImdb)  && ($0.tmdb?.rate ?? 0 >= minTmdb)
            }
        }
        
        filteredMovies = filteredMovies.filter { GlobalHelper.arrayContainsArray(array1: $0.genres ?? [], array2: Genre.getSelectedGenreIds(object: genres)) }

        if filteredMovies.isEmpty{
            return nil
        }else{
            
            let randomInt = Int.random(in: 0..<filteredMovies.count)
            let selectedMovie = filteredMovies[randomInt]
            previusMovies.append(selectedMovie)
            return selectedMovie
        }
        
    }
    
    func initView(){
        let intervals = [Interval(min: 1900, max: 2022, stepValue: 1),
        Interval(min: 1900, max: 2022, stepValue: 1),
        Interval(min: 1900, max: 2022, stepValue: 1)]
        let preSelectedRange = RangeValue(lower: 1900, upper: 2022)
        yearSlider.configureSlider(intervals: intervals, preSelectedRange: preSelectedRange)
        yearSlider.frame = CGRect(x: 0, y: 0, width: yearSliderView.frame.width, height: 25)
        yearSliderView.addSubview(yearSlider)
        yearSlider.trackLayerHeight = 3
        yearSlider.thumbTintColor = .white
        yearSlider.thumbSize = CGSize(width: 25, height: 25)
        yearSlider.trackHighlightTintColor = UIColor(named: "ColorOrange")!
        
        dropdownBackgroundView.backgroundColor = .black.withAlphaComponent(0.7)
        
        dropDownView.layer.borderColor = UIColor(named: "ColorOrange")!.cgColor
        dropDownView.layer.borderWidth = 1.5
        dropDownView.layer.cornerRadius = 10
        
    }

    @IBAction func imdbSliderAction(_ sender: Any) {
        imdbLabel.text = "\(formatSliderValue(value: imdbSlider.value))" + "/10"
        previusMovies = []
    }
    
    @IBAction func tmdbSliderAction(_ sender: Any) {
        tmdbLabel.text = "\(formatSliderValue(value: tmdbSlider.value))" + "/100"
        previusMovies = []
    }
    
    @IBAction func shuffleAction(_ sender: Any) {
        let selectedMovie : Movie? = getRandomMovie()
        if selectedMovie != nil{
            currentMovie = selectedMovie
            performSegue(withIdentifier: "ShuffleToDetailSegue", sender: nil)
        }
        else{
            let alert = UIAlertController(title: "Uyarı", message: "Size uygun gösterilebilecek içeriğimiz kalmadı. Filtrelerinizi değiştirip tekrar deneyin", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func genreSelectAction(_ sender: Any) {
        dropdownBackgroundView.isHidden = !dropdownBackgroundView.isHidden
    }
    
    @IBAction func onGenreSelectButtonAction(_ sender: Any) {
        dropdownBackgroundView.isHidden = !dropdownBackgroundView.isHidden
    }
}

extension ShuffleViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return platformImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
            previusMovies = []
            self.platformsCollectionView.reloadData()
    }
    
}

extension ShuffleViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreTableView",for: indexPath) as! GenreCardTableViewCell
        let row = genres[indexPath.row]
        cell.titleLabel.text = row.title
        cell.currentGenre = row
        cell.currentIndex = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        genres[indexPath.row].isSelected = !genres[indexPath.row].isSelected
        previusMovies = []
    }
    
    
}
