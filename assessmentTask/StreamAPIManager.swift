//
//  StreamAPIManager.swift
//  assessmentTask
//
//  Created by Soumyajit Pal on 02/11/24.
//

import Foundation

protocol StreamApiProtocol{
    func didGetData(data: String)
}

class StreamAPIHandler: NSObject, URLSessionDataDelegate {
    static let shared = StreamAPIHandler()
    
    var delegate: StreamApiProtocol?
    
    private var urlSession: URLSession!
    private let url = URL(string: "https://accounts.paybito.com/api/optionsMargin/getMainWalletBalanceStream?uuid=c671698a-512e-11ed-b77d-b917944d2d8a")!
    
    
    override init() {
        super.init()
        
        let config = URLSessionConfiguration.default
        urlSession = URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }
    
    func startStream() {
        let task = urlSession.dataTask(with: url)
        task.resume()
    }
    
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        
        guard let jsonString = String(data: data, encoding: .utf8),
                  jsonString.first == "{" || jsonString.first == "[" else {return}
        
        delegate?.didGetData(data: jsonString)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print("Stream error: \(error.localizedDescription)")
        } else {
            print("Stream completed.")
        }
    }
}
