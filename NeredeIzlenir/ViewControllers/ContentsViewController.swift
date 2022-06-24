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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentCountLabel.text = String(movies?.count ?? 0) + " adet içerik listelendi"
        
        contentsCollectionView.delegate = self
        contentsCollectionView.dataSource = self
        
        platformsCollectionView.delegate = self
        platformsCollectionView.dataSource = self
    }
}

extension ContentsViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.contentsCollectionView{
            return movies?.count ?? 0
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
            cell.titleLabel.text = movies![indexPath.row].title?.original
            cell.backgroundButton.addTarget(self, action: #selector(onCellPressed), for: .touchUpInside)
            cell.movie = movies![indexPath.row]
//            cell.movieImage.downloaded(from: movies![indexPath.row].poster?.tmdbPoster?.en ?? movies![indexPath.row].backdrops?.first ?? "")
              return cell
        }
        else if collectionView == self.platformsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlatformCollectionViewCell", for: indexPath) as! PlatformCollectionViewCell
            cell.platformImage.image = UIImage(named: platformImages[indexPath.row])
              return cell
        }
        else {
            //ERROR
            let cell = UICollectionViewCell()
            return cell
        }
        
    }
    
    @objc func onCellPressed(){
        
    }
    
}
