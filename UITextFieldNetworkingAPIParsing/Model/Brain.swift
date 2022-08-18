//
//  Brain.swift
//  UITextFieldNetworkingAPIParsing
//
//  Created by mustafa yildiz on 18.08.2022.
//

import Foundation

protocol BrainDelegate{
    func updateUI(with:String)
}

struct Brain{
    
    var delegate:BrainDelegate?
    
    func fetchData(cityName:String){
        
        
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=21b674a6e65debae4a26bb63a9d0f9cb&q=" + cityName
        
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let info = parseJSON(jsonData: safeData){
                        self.delegate?.updateUI(with: info)
                    }
            
                
                }
                    
                
            }
            task.resume()
        }
        
        func parseJSON(jsonData:Data)->String?{
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(RelatedData.self, from: jsonData)
                return String(format:"%.0f",decodedData.main.temp)
                
            } catch  {
                print(error)
                return nil
                
            }
        }
        
        
    }
    

}

struct RelatedData: Codable {
    let main:Main
    
}

struct Main: Codable{
    let temp:Double
}
