//
//  BaseHttpRequest.swift
//  Travel  对Alamofire的封装
//
//  Created by Baogui Lu on 9/19/15.
//  Copyright © 2015 Baogui Lu. All rights reserved.
//

import Foundation
import Alamofire


enum ParamEncoding {
    case URL;
    case NONEURL;
}


//general response struct
public struct ResponseObject {
    public var code:Int;
    public var message:String;
    public var _meta:AnyObject?;
    public var data:AnyObject?;
    
    init (data:AnyObject) {
        self.code = data.valueForKeyPath("code") as! Int;
        self.message = data.valueForKeyPath("message") as! String;
        self._meta = data.valueForKeyPath("_meta");
        self.data = data.valueForKeyPath("data");
    }
}


//baseHttpRequest需要封装返回参数的解析
class BaseHttpRequest: NSObject {
    private var headers: Array<String> = [];
    var responseObject: ResponseObject?;
    
    //提交post请求
    func post(URLString: String, parameters: [String: AnyObject]? = nil, encoding: ParamEncoding = .URL, headers: [String: String]? = nil, successHandler:((data:ResponseObject?) -> Void), failureHandler:((error:NSError?)->Void)) -> Void {
        
    }
    
        
}
