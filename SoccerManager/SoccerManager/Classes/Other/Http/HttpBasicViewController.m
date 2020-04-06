
#import "HttpBasicViewController.h"
#import "MBProgressHUD.h"

@interface HttpBasicViewController ()

@end

@implementation HttpBasicViewController


/*
 
 请求行：包含请求方法，资源路径，http版本等；
 请求头：包含了对客户端的环境描述，客户端请求的主机地址，服务器所能接收的数据类型等；
 HOST:192.168.2.105:8080
 USER-AGENT:
 ACCEPT:
 ACCEPT-LANGUAGE:
 
 */



/*
 
 GET和POST的区别：
 
 GET
 在URL后面以?的形式跟上发给服务器的参数，参数之间用&隔开；
 由于浏览器和服务器对URL的长度是有限制的（一般来说是1kb），所以简单的请求才用GET；
 
 POST
 发给服务器的参数全部放在请求体中；
 理论上来说，长度是没有限制的；
 
 */



- (void)post {

    NSURL *url = [NSURL URLWithString:@""];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.timeoutInterval = 10;
    request.HTTPMethod = @"POST";
    // 设置请求体
    NSString *param = [NSString stringWithFormat:@"username=%@&pwd=%@", @"heyalu", @"123"];
    // NSString --> NSData
    request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];

    //设置请求头信息，注意@"User-Agent"一点都不能写错；
    [request setValue:@"iphone6" forKey:@"User-Agent"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        ;
    }];
    [task resume];
}



/**
 *  发送json给服务器
 */
- (void)postJson {

    // 1.URL
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/order"];
    
    // 2.请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 3.请求方法
    request.HTTPMethod = @"POST";
    
    // 4.设置请求体（请求参数）
    // 创建一个描述订单信息的JSON数据
    NSDictionary *orderInfo = @{
                                @"shop_id" : @"1243324",
                                @"shop_name" : @"啊哈哈哈",
                                @"user_id" : @"899"
                                };
    NSData *json = [NSJSONSerialization dataWithJSONObject:orderInfo options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = json;
    
//    request.HTTPBody = @"username=heyalu&id=123456";//如果body不是这样的参数，一个要进行下一句;
    
    // 5.设置请求头：这次请求体的数据不再是普通的参数，而是一个JSON数据（这是固定写法）
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // 6.发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data == nil || connectionError) return;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSString *error = dict[@"error"];
        if (error) {
//            [MBProgressHUD showError:error];
        } else {
            NSString *success = dict[@"success"];
//            [MBProgressHUD showSuccess:success];
        }
    }];
}

@end
