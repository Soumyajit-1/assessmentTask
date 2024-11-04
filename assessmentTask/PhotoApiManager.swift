//
//  ApiManager.swift
//  assessmentTask
//
//  Created by Soumyajit Pal on 05/11/24.
//

import Foundation

class PhotoApiManager{
    
    static let shared = PhotoApiManager()
    
    func getPhotos(completion: @escaping ([ImageModel])->Void){
        
        let url = URL(string: "https://picsum.photos/v2/list?page=2&limit=20")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                   if error != nil {
                       return
                   }
                   guard let data = data else {
                       return
                   }
                   
                   do {
                       let data = try JSONDecoder().decode([ImageModel].self, from: data)
                       completion(data)
                   } catch {
                       print("err decoding")
                   }
               }
               
               
               task.resume()
        
        
        
        
    }
    
    
    
    
}
