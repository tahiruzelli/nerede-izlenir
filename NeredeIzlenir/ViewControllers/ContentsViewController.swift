//
//  ContentsViewController.swift
//  NeredeIzlenir
//
//  Created by Tahir Uzelli on 21.06.2022.
//

import UIKit

class ContentsViewController: BaseViewController {
    
    @IBOutlet weak var contentCountLabel: UILabel!
    
    @IBOutlet weak var contentsCollectionView: UICollectionView!
    @IBOutlet weak var platformsCollectionView: UICollectionView!
    
    var selectedPlatforms : SelectedPlatforms = SelectedPlatforms()
    
    var filteredMovies : [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredMovies = movies ?? []
        contentCountLabel.text = String(filteredMovies.count) + " adet içerik listelendi"
        
        contentsCollectionView.delegate = self
        contentsCollectionView.dataSource = self
        
        platformsCollectionView.delegate = self
        platformsCollectionView.dataSource = self
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
