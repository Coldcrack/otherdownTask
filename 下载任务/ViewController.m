//
//  ViewController.m
//  下载任务
//
//  Created by 嗷嗷叫 on 2017/4/10.
//  Copyright © 2017年 嗷嗷叫aoaojiao. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "UIProgressView+AFNetworking.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)downloadtask:(id)sender {
    //url地址
    NSString *urlString = @"http://218.76.27.57:8080/chinaschool_rs02/135275/153903/160861/160867/1370744550357.mp3";
    //创建manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //创建请求对象
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlString]];
    //创建下载任务
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request
    progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%lli/%lli",downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
    }
    destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response)
    {
        //接收到响应头，需要指定保存路径
        NSLog(@"状态码：%li",((NSHTTPURLResponse *)response).statusCode);
     //临时文件 ，保存路径
      // 返回值 指定的保存路径
        NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/菊花台.mp3"];
        NSLog(@"%@",filePath);
       //创建一个沙盒路径下的子路径，设定保存的文件夹位置
        return [NSURL fileURLWithPath:filePath];
    }
    completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"下载完成");
        }];
    [downloadTask resume];
    
    //绑定任务到进度显示视图
    [_progressView setProgressWithDownloadProgressOfTask:downloadTask animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
