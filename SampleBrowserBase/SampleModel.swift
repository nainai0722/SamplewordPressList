//
//  SampleModel.swift
//  SampleBrowserBase
//
//  Created by apple on 2018/09/17.
//  Copyright © 2018年 com.nainai0722. All rights reserved.
//

import Foundation


struct SampleModel: Codable {
    var date: String = ""
    var dateString: String{
        let formatter: DateFormatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        if let date = formatter.date(from: date) {
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            
            let str = formatter.string(from: date)
            
            return str
        }
        return date
    }
    
    var link: String = ""
    
    var title: SampleTitleModel = SampleTitleModel()
    struct SampleTitleModel: Codable {
        var rendered: String = ""
        
    }
    
    
    
}
