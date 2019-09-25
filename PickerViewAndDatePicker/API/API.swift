//
//  API.swift
//  PickerViewAndDatePicker
//
//  Created by yasmeen on 9/25/19.
//  Copyright © 2019 yasmeen. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class API: NSObject {
    class func GetData(lang_id: String, apiToken: String, completion: @escaping (_ error :Error?, _ seccess :Bool?,_ data:[MyData]?) -> Void){
        let url = "http://demovisiontsol.com/optibov/api/lists/vaccinationTypes"
        let parameters = [
            "lang_id": lang_id,
            "apiToken": apiToken
            ]
       
        Alamofire.request(url, method: .get , parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseJSON { (response) in
                switch response.result{
                case .failure( let error):
                    print(error)
                    completion(error,false,nil)
                case .success( let value):
                    //print(value)
                   let json = JSON(value)
                   //completion(nil,true,)
                    guard let dataArray = json["data"].array else{
                        completion(nil, nil, nil)
                        return
                    }
                  
                    if let status = json["status"].int{
                        print(">>>>>>>>>>>>>>>\(status)")
                        
                    }
                    if let message = json["message"].string{
                        print(message)
                    }
                    var mydata = [MyData]()
                    for data in dataArray{
                        guard let data = data.dictionary else{return}
                        let rowData = MyData(id: data["id"]?.int ?? 0, name: data["name"]?.string ?? "name not found")
                        mydata.append(rowData)
                    }
                    completion(nil, true, mydata)

                }
        }
    }


}

