//
//  ServerManager.swift
//  MoviesApp
//
//  Created by Muhammad Ahmad on 24/11/2023.
//

import Foundation
import Alamofire
struct APIPath {

    //Marks:- BaseURL
    static let BaseURL =  "https://api.themoviedb.org/"

}
enum APIMethods : String{
    case popularMovie  = "3/movie/popular"
}

class ServerManager {
    
    static func withoutParmsFetchApiDataPostAppJson<T: Decodable>(APIMethodName : String, Token : String, completion: @escaping (T?) -> ()) {
     
        
        let url = "\(APIPath.BaseURL)\(APIMethodName)"
        print(url)

        let headers = [
            "Authorization" : "Bearer \(Token)",
//            "Content-Type": "application/json"
        ]
        
        print(headers)
        
       
        Alamofire.request(url, method: .get, encoding:  JSONEncoding.default, headers: headers).responseJSON { (response ) in
            
            
            
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    
                    
                    debugPrint(response)
                    
                    
                    let responseJson = response.result.value! as! NSDictionary
                    print(responseJson)
                    
                    
                    ///=====
                    if response.result.value != nil {
                        do {
                            let obj = try JSONDecoder().decode(T.self, from: response.data!)
                            completion(obj)
                        }catch{
                            completion(nil)
                            print("* === * Error: While Paesing JSON (Invalid Model Object Passed in func Parameret )")
                        }
                        
                    }else {
                        completion(nil)
                        print("***====*** No JSON Data")
                    }
                    
                case 401:
                    completion(nil)
                    print("401: Session Expied")
                    
                    
                    
                default:
                    completion(nil)
                    print("-=-=-=-= Error: in API Path")
                }
                
            } else {
                completion(nil)
                print("=-=-=-=-=-Error:  No Response from API / no internet connection ")
            }
        }
        
        
    }//end generic function
}
