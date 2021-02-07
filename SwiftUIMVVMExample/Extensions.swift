//
//  Extensions.swift
//  SimpleShoppingApp
//
//  Created by Chee Ket Yung on 03/02/2021.
//

import Foundation


extension Bundle {
    func decodeJson <T:Decodable> (_ type : T.Type , fileName : String,
         dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
         keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
            
         guard let url = self.url(forResource: fileName, withExtension: nil) else {
             fatalError("Failed to load file ")
         }
            
         do {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy
                
            let result = try decoder.decode(type, from: jsonData)
            return result
         }
         catch {
            fatalError("err:\(error)")
         }
    }
}

extension URLSession {
    func decodeJson <T:Decodable> (_ type : T.Type , urlString : String ,
         completion: @escaping (Result<T, Error>)->Void,
         dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
         keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys)  {
            
         guard let url = URL(string: urlString) else {
            return
         }
        
         let task = self.dataTask(with: url, completionHandler: { data, response, error in
                
            if let error = error {
                completion(.failure(error))
            }
            else {
                do {
                   let decoder = JSONDecoder()
                   decoder.dateDecodingStrategy = dateDecodingStrategy
                   decoder.keyDecodingStrategy = keyDecodingStrategy
                
                   let results = try decoder.decode(type, from: data!)
                   completion(.success(results))
                }
                catch {
                   completion(.failure(error))
                }
            }
         })
         task.resume()
    }
}

extension DateFormatter {
      func jsonDateDecodingStrategy(dateFormat : String )
       -> JSONDecoder.DateDecodingStrategy{
         self.dateFormat = dateFormat
         return .formatted(self)
      }
        
      func string( from : Date ,dateFormat : String ) -> String {
          self.dateFormat = dateFormat
          return self.string(from: from)
      }
}


extension String {
    
    func upperCaseFirst() -> String {
        
        return prefix(1).capitalized + dropFirst()
    }
}
