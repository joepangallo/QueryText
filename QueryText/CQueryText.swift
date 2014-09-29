//
//  CQueryText.swift
//  QueryText
//
//  Created by Joe Pangallo on 9/25/14.
//  Copyright (c) 2014 Joe Pangallo. All rights reserved.
//

import Foundation

class QuertyText
{
    let apiType            = "/querytextindex"
    let url                = NSURL()
    let endpoint           = String()
    let payLoad            = NSData()
    let request            = NSMutableURLRequest()
    let text               = "government"
    let summaryParam       = "context"
    
    init()
    {
        endpoint           = APIConstants.IDOL_API_URL + APIConstants.syncType + apiType + APIConstants.IDOL_API_VERSION
        url                = NSURL(string: endpoint)
        request            = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        payLoad            = ( "text=\(text)&summary=context&apikey=\(APIConstants.IDOL_API_KEY)".dataUsingEncoding(NSUTF8StringEncoding))!
        
        getData("dsa")
    }
    
    func getData(textToSearchOn: String)
    {
        let task = NSURLSession.sharedSession().uploadTaskWithRequest( request, fromData: payLoad, completionHandler: {data, response, error -> Void in
            
            if let value = data
            {
                var error:NSError? = nil
                if let jsonObject : AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error)
                {
                        let json  = JSONValue(jsonObject)
                        let dict : Dictionary<String, JSONValue> = json.object!
                        let first = dict.values.array
                        
                        if let arr = first[0].array
                        {
                            for var j = 0; j < arr.count; ++j
                            {
                                if let query_results = json["documents"][j]["summary"].string
                                {
                                     println(query_results)
                                     println()
                                }                                
                            }
                        }
                }
                else
                {
                    println(error)
                }
            }
            
        })
        task.resume()
    }
}
