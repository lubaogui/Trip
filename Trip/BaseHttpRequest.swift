//
//  BaseHttpRequest.swift
//  Travel  对Alamofire的封装
//
//  Created by Baogui Lu on 9/19/15.
//  Copyright © 2015 Baogui Lu. All rights reserved.
//

import Foundation
import Alamofire
import Gloss


//define callback function
typealias SuccessCallbackHandler = (data: AnyObject?) -> Void;
typealias FailureCallbackHandler = (error: NSError?) -> Void;



enum ParamEncoding {
    case URL;
    case NONEURL;
}


//baseHttpRequest需要封装返回参数的解析
class BaseHttpRequest: NSObject {
    private var headers: [String:String]? ;
    
    
    //提交post请求
    func post(URLString: String, parameters: [String: AnyObject]? = nil, encoding: ParameterEncoding = .URL,  successHandler:SuccessCallbackHandler, failureHandler:FailureCallbackHandler) -> Void {

        request(.POST, URLString, parameters: parameters, encoding: encoding, headers: self.headers)
            .responseJSON { (response) in
                
                let responseData = response.result.value;
                print(responseData.dynamicType);
                
                guard let code = responseData!["code"] else {
                    print("code can not be extracted from result");
                    return;
                }
                
                if (code as! Int == 0) {
                    print("请求正常");
                }
                else {
                    let message = responseData!["message"];
                    print("应用处理错误，错误信息为: \(message)");
                }
                
                successHandler(data: responseData);
                
                print("return result is:");
        }
        
    }
    
    
}
