//
//  ViewController.swift
//  assessmentTask
//
//  Created by Soumyajit Pal on 02/11/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnTaskDidTap(_ sender: UIButton){
        switch sender.tag{
        case 0:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "StreamApiView") as! StreamApiView
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "photoLoadingView") as! photoLoadingView
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            return
            
        }
    }

}

