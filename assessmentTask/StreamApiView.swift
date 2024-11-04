//
//  StreamApiView.swift
//  assessmentTask
//
//  Created by Soumyajit Pal on 04/11/24.
//

import UIKit

class StreamApiView: UIViewController {
    
    @IBOutlet weak var tv : UITableView!
    
    let viewModel = StreamApiViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Stream Api called ")
        tv.delegate = self
        tv.dataSource = self
        tv.register(UINib(nibName: "StreamApiCell", bundle: nil), forCellReuseIdentifier: "StreamApiCell")
        observeVM()
        viewModel.startStream()
    }
    
    func observeVM(){
        viewModel.eventHandler = {[weak self ] event in
            guard let self = self else {return}
            
            switch event{
            case .loading:
                print("Stream Api loading")
            case .dataLoaded:
                print("dataloaded", viewModel.streamData.count)
                DispatchQueue.main.async {
                    self.tv.reloadData()
                }
            case .error(let error):
                print(error!)
            }
        }
    }
}

extension StreamApiView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.streamData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StreamApiCell", for: indexPath) as! StreamApiCell
        cell.textView.text = viewModel.streamData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
