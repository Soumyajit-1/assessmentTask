//
//  PhotoApiViewModel.swift
//  assessmentTask
//
//  Created by Soumyajit Pal on 05/11/24.
//

import Foundation

class PhotoApiViewModel{
    var eventHandler: ((_ event: Event) -> Void)?
    var photos : [ImageModel] = []
    
    func getPhotos(){
        eventHandler?(.loading)
        PhotoApiManager.shared.getPhotos{[weak self ] imgs  in
            guard let self = self else {return}
            self.photos = imgs
            self.eventHandler?(.dataLoaded)
        }
    }

}


extension PhotoApiViewModel {

    enum Event {
        case loading
        case dataLoaded
        case error(Error?)
    }

}


