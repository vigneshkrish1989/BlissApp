//
//  mainVC.swift
//  BlissApp
//
//  Created by Vignesh Krishnamurthy on 01/09/21.
//

import UIKit
import CoreData

class mainVC: UIViewController {

    @IBOutlet weak var randomEmoji: UIImageView!
    @IBOutlet weak var searchUser: UITextField!
    var emojiArr = [Emojis]()
    var user = userList()
    var parse = Parser()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.parse.parseEmojis(completion: {
            result in
            self.emojiArr = result
            self.randomEmoji.sd_setImage(with: URL(string: self.emojiArr[0].name ?? ""), placeholderImage: UIImage(named: "placeholder"))
        })
       
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        if sender.tag == 1{
            guard emojiArr.count > 0 else {
                return
            }
            let randomElement = emojiArr.randomElement()!
            
            DispatchQueue.main.async {
                self.randomEmoji.sd_setImage(with: URL(string: randomElement.name ?? ""), placeholderImage: UIImage(named: "placeholder"))
            }
            
            
        }
        else if sender.tag == 2 {
            let emojiView = storyboard?.instantiateViewController(withIdentifier:"emojiListVC_ID") as! emojiListVC
            self.navigationController?.pushViewController(emojiView, animated: true)
        }
        else if sender.tag == 3 {
            
            if self.searchUser.text == "" {
                let alert = UIAlertController(title: "Please enter username!", message: nil, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                let string = searchUser.text?.trimmingCharacters(in: .whitespaces)
                self.parse.parseUser(username: string!, completion: {
                    result in
                    self.user = result
                    print("User",self.user)
                })
            }
            
            
        }
        else if sender.tag == 4 {
            let avatarView = storyboard?.instantiateViewController(withIdentifier:"avatarListVC_ID") as! avatarListVC
            self.navigationController?.pushViewController(avatarView, animated: true)
        }
        else if sender.tag == 5 {
            let repoView = storyboard?.instantiateViewController(withIdentifier:"repoVC_ID") as! repoVC
            self.navigationController?.pushViewController(repoView, animated: true)
        }
        
    }
    
}

extension mainVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == searchUser {
            if range.location == 0 && string == " " { 
                   return false
               }
        }
        return true
    }
}


