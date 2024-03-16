//
//  CallookAPI.swift
//  HamSearch
//
//  Created by Benjamin Faershtein on 12/24/23.
//

import Foundation


    
func searchCallSign(CallSign: String) -> String {
    let URLCallSign = CallSign.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        guard let url = URL(string: "https://callook.info/"+URLCallSign+"/json") else {
            return "Error"
        }
        
    let request = URLRequest(url: url)
   
        
    
        
        var responseData: Data?
        
        let group = DispatchGroup()
        group.enter()
        
        do {
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                defer {
                    group.leave()
                }
                
                if let error = error {
                    print(error)
                    return
                }
                
                if let data = data {
                    responseData = data
                }
            }
            
            task.resume()
            
            group.wait()
            
            if let responseData = responseData {
                if let responseString = String(data: responseData, encoding: .utf8) {
                    return responseString
                }
            }
        } catch {
            print(error)
        }
        
        return ""
    }
