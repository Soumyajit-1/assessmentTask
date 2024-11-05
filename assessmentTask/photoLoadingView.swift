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
    
    var imageCache = NSCache<NSString, UIImage>()

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
        cell.selectionStyle = .none
        cell.img.image = UIImage(named: "placeholder")
        cell.lblDes.text = viewModel.photos[indexPath.row].author
        cell.lblTitle.text = viewModel.photos[indexPath.row].id
        
        if let urlString = viewModel.photos[indexPath.row].download_url{
            
            loadImage(from: urlString) { image in
                DispatchQueue.main.async {
                    if let currentIndexPath = tableView.indexPath(for: cell), currentIndexPath == indexPath {
                        cell.img.image = image
                    }
                }
            }
        }
        
        return cell
    }
    
    //height  --> Top 82. Hr 32
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let pxH = viewModel.photos[indexPath.row].height
        let pxW = viewModel.photos[indexPath.row].width
        
        let imgWidth = tableView.frame.width - 32
        let imgHeight = imgWidth * CGFloat(Double(pxH!) / Double(pxW!))
        
        return CGFloat(imgHeight + 82)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAlert(with: viewModel.photos[indexPath.row].author!)
    }
    
    
    
}

extension photoLoadingView{
    
    func showAlert(with message: String) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
            
            if let cachedImage = imageCache.object(forKey: urlString as NSString) {
                completion(cachedImage)
                return
            }
            
            
            guard let url = URL(string: urlString) else {
                completion(nil)
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, let image = UIImage(data: data), error == nil else {
                    completion(nil)
                    return
                }
                
                
                self.imageCache.setObject(image, forKey: urlString as NSString)
                completion(image)
            }.resume()
        }
    }
    
