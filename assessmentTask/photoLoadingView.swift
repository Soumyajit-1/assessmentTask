//
//  photoLoadingView.swift
//  assessmentTask
//
//  Created by Soumyajit Pal on 04/11/24.
//

import UIKit

class photoLoadingView: UIViewController {
    @IBOutlet weak var tv: UITableView!
    
    let viewModel = PhotoApiViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tv.delegate = self
        tv.dataSource = self
        tv.register(UINib(nibName: "ImageCell", bundle: nil), forCellReuseIdentifier: "ImageCell")
        observeVM()
        viewModel.getPhotos()

        print("photo loading api called")
    }
    

    func observeVM(){
        viewModel.eventHandler = {[weak self ] event in
            switch event{
            case .loading:
                print("loading")
            case .dataLoaded:
                DispatchQueue.main.async{
                    self?.tv.reloadData()
                }
            case .error(let err):
                print(err)
            }
            
        }
    }
    

}

extension photoLoadingView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
        return cell
    }
    
    //height  --> Top 82. Hr 32
    
    
}
