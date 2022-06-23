//
//  ContentsViewController.swift
//  NeredeIzlenir
//
//  Created by Tahir Uzelli on 21.06.2022.
//

import UIKit

class ContentsViewController: UIViewController {
    @IBOutlet weak var contentsCollectionView: UICollectionView!
    @IBOutlet weak var platformsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentsCollectionView.delegate = self
        contentsCollectionView.dataSource = self
        
        platformsCollectionView.delegate = self
        platformsCollectionView.dataSource = self
    }
}

extension ContentsViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.contentsCollectionView{
            return 10
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
              return cell
        }
        else if collectionView == self.platformsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlatformCollectionViewCell", for: indexPath) as! PlatformCollectionViewCell
            cell.platformImage.image = UIImage(named: platformImages[indexPath.row])
//            if  cell.isSelected{
//                cell.platformImage.image = UIImage(named: platformImages[0])
//                print("test")
//            }
              return cell
        }
        else {
            //ERROR
            let cell = UICollectionViewCell()
            return cell
        }

    }
    
}
