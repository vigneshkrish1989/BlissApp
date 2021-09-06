//
//  emojiListVC.swift
//  BlissApp
//
//  Created by Vignesh Krishnamurthy on 01/09/21.
//

import UIKit
import SDWebImage
import CoreData

class emojiListVC: UIViewController {

    @IBOutlet weak var emojiCollectionView: UICollectionView!
    var emojiArr = [Emojis]()
    var parse = Parser()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "EMOJIS LIST"
        self.parse.parseEmojis(completion: {
            result in
            self.emojiArr = result
            DispatchQueue.main.async {
                self.emojiCollectionView.reloadData()
            }
        })
   
    }

}

extension emojiListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.emojiArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emojiCell_ID", for: indexPath as IndexPath) as! emojiCell
        cell.cardView.layer.borderWidth = 1
        cell.cardView.layer.borderColor = UIColor.white.cgColor
        cell.cardView.layer.cornerRadius = 10
        cell.emoji.sd_setImage(with: URL(string: emojiArr[indexPath.row].name ?? ""), placeholderImage: UIImage(named: "placeholder"))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let context:NSManagedObjectContext = PersistenceService.context
        context.delete(self.emojiArr[indexPath.row])
        self.emojiArr.remove(at: indexPath.row)
        
        do {
            try context.save()
            
        } catch _ {
        }
        self.emojiCollectionView.deleteItems(at: [indexPath])
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let Width = collectionView.frame.width / 4 - 1
        return CGSize(width: Width, height: Width)
       
    }
}
