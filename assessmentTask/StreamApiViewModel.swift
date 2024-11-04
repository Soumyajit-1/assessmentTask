//
//  StreamApiViewModel.swift
//  assessmentTask
//
//  Created by Soumyajit Pal on 05/11/24.
//

import Foundation

class StreamApiViewModel{
    
    var eventHandler: ((_ event: Event) -> Void)?
    
    var streamData : [String] = []
    
    func startStream(){
        StreamAPIHandler.shared.delegate = self
        StreamAPIHandler.shared.startStream()
        eventHandler?(.loading)
    }
    
    
}

extension StreamApiViewModel: StreamApiProtocol{
    func didGetData(data: String) {
        streamData.append(data)
        eventHandler?(.dataLoaded)
    }
    
}

extension StreamApiViewModel {

    enum Event {
        case loading
        case dataLoaded
        case error(Error?)
    }

}


