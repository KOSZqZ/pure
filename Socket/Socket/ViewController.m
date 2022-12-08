//
//  ViewController.m
//  Socket
//
//  Created by ZGH on 2020/8/26.
//  Copyright © 2020 ZGH. All rights reserved.
//

#import "ViewController.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.创建服务器

    
    //第一个参数 domain 协议簇 IPv4
    //第二个参数 type socket的类型 tcp为数据流
    //第三个参数 protocol 协议
    
    //如果返回值为-1,则失败,成功则为socket的描述符
    int clientSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    NSLog(@"%d",clientSocket);

    //2.连接服务器
    //第一个参数 socket的描述符
    //第二个参数 ip地址和端口的结构体
    //第三个参数 第二参数结构体的大小
    
    struct sockaddr_in addr;
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = inet_addr("127.0.0.1");
    //终端输入nc -lk 1000就可以把1000端口设置为服务端了
    addr.sin_port = htons(1000);
    int result = connect(clientSocket, (const struct sockaddr *)&addr, sizeof(addr));
    if (result == 0) {
        NSLog(@"成功");
    }else{
        NSLog(@"失败");
    }
    
    
    //3.发送数据
//    第一个参数指定发送端套接字描述符；
//    第二个参数指明一个存放应用程式要发送数据的缓冲区；
//    第三个参数指明实际要发送的数据的字符数；
//    第四个参数一般置0
    const char *msg = "hello kook!";
    //如果成功则返回发送的字节数,不成功则返回-1
    long sendCount = send(clientSocket, msg, strlen(msg), 0);
    if (sendCount != -1) {
        NSLog(@"成功:%zd",sendCount);
        NSLog(@"成功:%zd",sendCount);
        NSLog(@"成功:%zd",sendCount);
        NSLog(@"%s__func__",__func__);

    }else{
        NSLog(@"失败");
    }
    
    
    //4.接受数据
    unsigned char buffer[1024];
//    该函数的第一个参数指定接收端套接字描述符；
//    第二个参数指明一个缓冲区，该缓冲区用来存放recv函数接收到的数据；
//    第三个参数指明buf的长度；
//    第四个参数一般置0
    long recvCount = recv(clientSocket, buffer, sizeof(buffer), 0);
    if (recvCount) {
        NSLog(@"%zd",recvCount);
        NSData *data = [NSData dataWithBytes:buffer length:recvCount];
        NSString *recvStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"接收到:%@",recvStr);
    }
    
    //5.关闭连接
    close(clientSocket);
    
}


@end
