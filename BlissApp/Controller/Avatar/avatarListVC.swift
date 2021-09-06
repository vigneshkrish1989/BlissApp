//
//  avatarListVC.swift
//  BlissApp
//
//  Created by Vignesh Krishnamurthy on 01/09/21.
//

import UIKit
import CoreData

class avatarListVC: UIViewController {

    @IBOutlet weak var userCollectionView: UICollectionView!
    var getUserAvatar = [Users]()
    var parse = Parser()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "AVATARS LIST"
        self.parse.parseUserAvatar(completion: {
            result in
            self.getUserAvatar = result
            DispatchQueue.main.async {
                self.userCollectionView.reloadData()
            }
        })
        
    }
  
}
extension avatarListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.getUserAvatar.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCell_ID", for: indexPath as IndexPath) as! userCell
        cell.cardView.layer.borderWidth = 1
        cell.cardView.layer.borderColor = UIColor.white.cgColor
        cell.cardView.layer.cornerRadius = 10
        cell.userAvatar.sd_setImage(with: URL(string: getUserAvatar[indexPath.row].avatar ?? ""), placeholderImage: UIImage(named: "placeholder"))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let context:NSManagedObjectContext = PersistenceService.context
        context.delete(self.getUserAvatar[indexPath.row])
        self.getUserAvatar.remove(at: indexPath.row)
        
        do {
            try context.save()
            
        } catch _ {
        }
        self.userCollectionView.deleteItems(at: [indexPath])
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let Width = collectionView.frame.width / 4 - 1
        return CGSize(width: Width, height: Width)
       
    }
}
