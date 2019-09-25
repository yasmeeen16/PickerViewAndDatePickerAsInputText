//
//  MyData.swift
//  PickerViewAndDatePicker
//
//  Created by yasmeen on 9/25/19.
//  Copyright © 2019 yasmeen. All rights reserved.
//

import Foundation
class MyData{
    private var _id:Int!
    private var _name:String!
    
    init(id:Int, name:String) {
        self.id = id
        self.name = name

    }
    public var name:String!{
        get{
            return _name
        }
        set{
            _name = newValue
        }
    }
    public var id:Int!{
        get{
            return _id
        }
        set{
            _id = newValue
        }
    }
    
}
