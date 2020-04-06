

#import "FileUploadViewController.h"

@interface FileUploadViewController ()

@end


#define HMFileBoundary @"heima"
#define HMNewLien @"\r\n"
#define HMEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]


@implementation FileUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (NSString *)MIMEType:(NSURL *)url
{
    // 1.创建一个请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 2.发送请求（返回响应）
    NSURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    // 3.获得MIMEType
    return response.MIMEType;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self upload];
    //    NSURL *url = [[NSBundle mainBundle] URLForResource:@"autolayout" withExtension:@"txt"];
    
    //    NSURL *url = [NSURL fileURLWithPath:@"/Users/apple/Desktop/课堂共享/第一次考试/考试说明.docx"];
    //    NSLog(@"%@", url);
    //    NSLog(@"%@", [self MIMEType:url]);
}

/*
 参数1
 参数2
 结束标记
 */

/*
 * 文件参数
 heima
 Content-Disposition: form-data; name="参数名"; filename="文件名"
 Content-Type: 文件类型（MIMEType）
 
 文件具体数据
 
 * 非文件参数
 heima
 Content-Disposition: form-data; name="参数名"
 
 参数值
 */

- (void)upload
{
    // 非文件参数
    NSDictionary *params = @{
                             @"username" : @"李四",
                             @"pwd" : @"123",
                             @"age" : @30,
                             @"height" : @"1.55"
                             };
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"autolayout" withExtension:@"txt"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSString *MIMEType = [self MIMEType:url];
    [self upload:@"test.txt" mimeType:MIMEType fileData:data params:params];
    
    // 文件数据
    //    UIImage *image = [UIImage imageNamed:@"minion_03"];
    //    NSData *imageData = UIImagePNGRepresentation(image);
    //
    //    [self upload:@"777.png" mimeType:@"image/png" fileData:imageData params:params];
}



- (void)upload:(NSString *)filename mimeType:(NSString *)mimeType fileData:(NSData *)fileData params:(NSDictionary *)params
{
    // 1.请求路径
    NSURL *url = [NSURL URLWithString:@"http://192.168.15.172:8080/MJServer/upload"];
    
    // 2.创建一个POST请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    // 3.设置请求体
    NSMutableData *body = [NSMutableData data];
    
    // 3.1.文件参数
    [body appendData:HMEncode(@"--")];
    [body appendData:HMEncode(HMFileBoundary)];
    [body appendData:HMEncode(HMNewLien)];
    
    NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"", filename];
    [body appendData:HMEncode(disposition)];
    [body appendData:HMEncode(HMNewLien)];
    
    NSString *type = [NSString stringWithFormat:@"Content-Type: %@", mimeType];
    [body appendData:HMEncode(type)];
    [body appendData:HMEncode(HMNewLien)];
    
    [body appendData:HMEncode(HMNewLien)];
    [body appendData:fileData];
    [body appendData:HMEncode(HMNewLien)];
    
    // 3.2.非文件参数
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [body appendData:HMEncode(@"--")];
        [body appendData:HMEncode(HMFileBoundary)];
        [body appendData:HMEncode(HMNewLien)];
        
        NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"", key];
        [body appendData:HMEncode(disposition)];
        [body appendData:HMEncode(HMNewLien)];
        
        [body appendData:HMEncode(HMNewLien)];
        [body appendData:HMEncode([obj description])];
        [body appendData:HMEncode(HMNewLien)];
    }];
    
    // 3.3.结束标记
    [body appendData:HMEncode(@"--")];
    [body appendData:HMEncode(HMFileBoundary)];
    [body appendData:HMEncode(@"--")];
    [body appendData:HMEncode(HMNewLien)];
    
    request.HTTPBody = body;
    
    // 4.设置请求头(告诉服务器这次传给你的是文件数据，告诉服务器现在发送的是一个文件上传请求)
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", HMFileBoundary];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    // 5.发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", dict);
    }];
}



@end
