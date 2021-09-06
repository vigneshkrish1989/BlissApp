//
//  repoVC.swift
//  BlissApp
//
//  Created by Vignesh Krishnamurthy on 01/09/21.
//

import UIKit

class repoVC: UIViewController {

    @IBOutlet weak var repoTblView: UITableView!
    var getAppleRepo = [appleRepo]()
    var parse = Parser()
    
    var page: Int = 1
    var size: Int = 10
    var fetchnigMore = false
    var spinner = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "APPLE REPOS"
        self.loadData(page: self.page, size: self.size)
    }
    
    func loadData(page: Int, size: Int) {
        fetchnigMore = true
        print("GET PAGE",page)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            parser.getAppleRepos(page: page, size: size, completion: {
                result in
                print(result)
                self.getAppleRepo.append(contentsOf: result)
                DispatchQueue.main.async {
                    self.repoTblView.tableFooterView = nil
                    self.fetchnigMore = false
                    self.repoTblView.reloadData()
                }
            })
            
        }
       
    }
    
    func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        spinner.center = footerView.center
        spinner.startAnimating()
        spinner.color = UIColor.white
        footerView.addSubview(spinner)
        return footerView
    }

}

extension repoVC: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getAppleRepo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell")
        cell?.textLabel?.text = self.getAppleRepo[indexPath.row].name
        cell?.textLabel?.textColor = UIColor.white
        return cell!
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (repoTblView.contentSize.height-100-scrollView.frame.size.height)
        {
            self.repoTblView.tableFooterView = createSpinnerFooter()
            if !fetchnigMore
            {
                self.page += 1
                loadData(page: self.page, size: 10)
            }
           
        }
    }

}
