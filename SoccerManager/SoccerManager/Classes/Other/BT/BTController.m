//
//  ViewController.m
//  蓝牙
//
//  Created by  on 15/12/23.
//  Copyright © 2015年 juanjuan. All rights reserved.
//

#import "BTController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>


@interface BTController ()
<
CBCentralManagerDelegate,
CBPeripheralDelegate,
UITableViewDataSource,
UITableViewDelegate
>

//外设数组
@property(nonatomic, strong) NSMutableArray *peripherals;
//中心管理者
@property(nonatomic, strong) CBCentralManager *mgr;
//展示数据
@property(nonatomic, strong) UITableView *tableView;
//外设
@property(nonatomic, strong) CBPeripheral *peripheral;
//特征
@property(nonatomic, strong) CBCharacteristic *characteristic;
@property (nonatomic, weak ) UIButton *openOrclosed;

@end

@implementation BTController

//懒加载重写getter方法
- (NSMutableArray *)peripherals
{
    if(!_peripherals) {
        _peripherals= [NSMutableArray array];
    }
    return _peripherals;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.frame = CGRectMake(200, 20, 50, 60);
    btn2.backgroundColor = [UIColor blackColor];
    [btn2 setTitle:@"打开" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 250, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - CBCentralManagerDelegate

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI

{
    
    // 保存扫描到得外部设备
    
    // 判断如果数组中不包含当前扫描到得外部设置才保存
    
    NSLog(@"查找设备");
    NSLog(@"搜索到的设备的名称：%@",peripheral.name);
    
    if ([peripheral.name isEqualToString:@"J-ME30-019355"]) {
        //if (![self.peripherals containsObject:peripheral]) {
        [self.peripherals addObject:peripheral];
        //  }
        [self.tableView reloadData];
        [self.mgr stopScan];
    }
    //停止扫描--新加入的--
    //[self.mgr stopScan];
}

#pragma mark显示数据的tableView的代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.peripherals.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_id = @"cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];

    }
    CBPeripheral *peripheral = self.peripherals[indexPath.row];
    cell.textLabel.text = peripheral.name;
    return cell;
}

#pragma mark tableView的点击事件

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    self.peripheral = self.peripherals[indexPath.row];
    
    [self.mgr connectPeripheral:self.peripheral options:nil];
    
    self.peripheral.delegate = self;
}

/**
 
 *扫描外设
 
 */
int static flag = 0;

-(void)btnclick
{
    flag ++;
    NSLog(@"clicked is %d",flag);
    if (flag % 2 == 1) {
        
        NSLog(@"扫描");
        
        //[self.navigationItem.rightBarButtonItem setTitle:@"断开"];
        
        // 1.创建中心设备
        
        //设置代理
        
        self.mgr = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        
        // 2.利用中心设备扫描外部设备
        
        /*
         
         如果指定数组代表只扫描指定的设备
         
         */
        
        [self.mgr scanForPeripheralsWithServices:nil options:nil];
        
        
    }
    else {
        
        flag = 1;
        NSLog(@"断开");
        
        [self.mgr stopScan];
        
        if (self.peripheral != nil)
        {
            
            NSLog(@"disConnect start");
            
            [self.mgr cancelPeripheralConnection:self.peripheral];
            
        }
        
        self.peripherals = nil;
        
        [self.tableView reloadData];
    }
}

/**
 
 *  连接外设成功调用
 
 */

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral

{
    
    //    [self showTheAlertViewWithMassage:@"链接成功"];
    
    NSLog(@"链接成功");
    self.peripheral = peripheral;
    
    // 扫描外设中得服务
    
    [peripheral discoverServices:nil];
    
}

/**
 
 *  连接外设失败调用
 
 */

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error

{
    
    //    [self showTheAlertViewWithMassage:@"链接失败"];
    
    NSLog(@"链接失败");
    
}

#pragma makr - CBPeripheralDelegate

/**
 
 *  只要扫描到服务就会调用
 
 *
 
 *  @param peripheral服务所在的外设
 
 */

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    
    NSLog(@"扫描服务");
    //    [self showTheAlertViewWithMassage:@"扫描服务"];
    // 获取外设中所有扫描到得服务
    NSArray *services = peripheral.services;
    
    for (CBService *service in services) {
        
        //拿到需要的服务
        NSLog(@"可以找到的服务编号%@", service.UUID.UUIDString);
        
        //        if ([service.UUID.UUIDString isEqualToString:RX_SERVICE_UUID])
        //
        //        {
        //
        //            [self showTheAlertViewWithMassage:@"拿到了对应的服务了"];
        //
        //            //从需要的服务中查找需要的特征
        //
        //            //从peripheral中得service中扫描特征
        //
        //            [peripheral discoverCharacteristics:nil  forService:service];
        //
        //        }
        [peripheral discoverCharacteristics:nil  forService:service];
    }
    
}

/**
 
 *  只要扫描到特征就会调用
 
 *
 
 *  @param peripheral特征所属的外设
 
 *  @param service特征所属的服务
 
 */

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error

{
    
    NSLog(@"扫描特征");
    
    // 拿到服务中所有的特征
    
    NSArray *characteristics =  service.characteristics;
    
    // 遍历特征, 拿到需要的特征处理
    
    for (CBCharacteristic * characteristic in characteristics) {
        
        NSLog(@"能够找到的特征码--%@",characteristic.UUID.UUIDString);
        
#define ReadWriteCode     @"49535343-6DAA-4D02-ABF6-19569ACA69FE"
#define WriteNotifyCode   @"49535343-ACA3-481C-91EC-D85E28A60318"
#define Notify            @"49535343-1E4D-4BD9-BA61-23C647249616"
#define WriteCode         @"49535343-8841-43F4-A8D4-ECBE34729BB3"
        
        
        if ([characteristic.UUID.UUIDString isEqualToString:ReadWriteCode]) {
            NSLog(@"拿到读写的特征了");
            self.characteristic = characteristic;
            [self.peripheral setNotifyValue:YES forCharacteristic:self.characteristic];
            break;
        }
        if ([characteristic.UUID.UUIDString isEqualToString:WriteNotifyCode]) {
            NSLog(@"拿到写通知的特征了");
            self.characteristic = characteristic;
            [self.peripheral setNotifyValue:YES forCharacteristic:self.characteristic];
            break;
        }
        if ([characteristic.UUID.UUIDString isEqualToString:Notify]) {
            NSLog(@"拿到通知的特征了");
            
            self.characteristic = characteristic;
            [self.peripheral setNotifyValue:YES forCharacteristic:self.characteristic];
            break;
            
        }
        if ([characteristic.UUID.UUIDString isEqualToString:WriteCode]) {
            NSLog(@"拿到可写的特征了");
            self.characteristic = characteristic;
            [self.peripheral setNotifyValue:YES forCharacteristic:self.characteristic];
            break;
        }
    }
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central

{
    
    NSLog(@"检测代理方法");
    
    NSString * state = nil;
    
    switch ([central state])
    {
        case CBCentralManagerStateUnsupported:
            state = @"The platform/hardware doesn't support Bluetooth Low Energy.";
            break;
        case CBCentralManagerStateUnauthorized:
            state = @"The app is not authorized to use Bluetooth Low Energy.";
            break;
        case CBCentralManagerStatePoweredOff:
            state = @"Bluetooth is currently powered off.";
            break;
        case CBCentralManagerStatePoweredOn:
            state = @"work";
            break;
        case CBCentralManagerStateUnknown:
        default:
            ;
    }
    NSLog(@"Central manager state: %@", state);
    if (central.state == 5) {
        [self.mgr scanForPeripheralsWithServices:nil options:nil];
        
        //        [self showTheAlertViewWithMassage:@"手机蓝牙处于可用状态"];
        
    }
    
    NSLog(@"%ld，%@", central.state, central);
    
}

#pragma mark发送消息成功

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error

{
    
    NSLog(@"发送消息的回调");
    
    NSLog(@"----%@", error);
    
    if (!error) {
        
        NSLog(@"??????????");
        
    }
    
}

#pragma mark处理蓝牙发送过来的数据

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error

{
    
    NSLog(@"接收到数据");
    
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error

{
    
    NSLog(@">>>读到新的数据新的数据新的数据>");
    
    if (error)
        
    {
        
        NSLog(@"Error updating value for characteristic %@ error: %@", characteristic.UUID, [error localizedDescription]);
        
        //        if ([_mainMenuDelegate respondsToSelector:@selector(DidNotifyReadError:)])
        
        //            [_mainMenuDelegate DidNotifyReadError:error];
        
        //
        
        //        return;
        
    }
    
    NSMutableData *recvData;
    
    [recvData appendData:characteristic.value];
    
    if ([recvData length] >= 5)//已收到长度
        
    {
        
        //unsignedchar *buffer = (unsignedchar *)[recvDatabytes];
        unsigned char *buffer = (unsigned char *)[recvData bytes];
        int nLen = buffer[3] * 256 + buffer[4];
        
        if ([recvData length] == (nLen + 3 + 2 + 2))
            
        {
            
            //接收完毕，通知代理做事
            
            //            if ([_mainMenuDelegate respondsToSelector:@selector(DidNotifyReadData)])
            
            //                [_mainMenuDelegate DidNotifyReadData];
            
            NSLog(@"???????");
            
        }
        
    }
    
}


- (void)showTheAlertViewWithMassage:(NSString *)massage

{
    
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"温馨提示"message:massage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [alertV show];
    
}

- (void)openTheDoor

{
    
    NSLog(@"拿到了可读可写的特征了");
    
    //    self.peripheral.delegate = self;
    
    //    characteristic.value = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    //    characteristic.value = [NSData dataWithBytes:string.UTF8String length:string.length];
    
    //    [self.peripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
    
    //    [self.peripheral setNotifyValue:NO forCharacteristic:self.characteristic];
    
    [self  writeString:@"OLWANDA_IL12345678"];
    
}

- (void)writeString:(NSString *) string

{
    
    NSData *data = [NSData dataWithBytes:string.UTF8String length:string.length];
    
    //       NSLog(@"%@",self.characteristic.UUID.UUIDString);
    
    self.peripheral.delegate = self;
    
    NSLog(@"%@",self.peripheral.delegate);
    
    if((self.characteristic.properties& CBCharacteristicPropertyWriteWithoutResponse) != 0)
        
    {
        
        [self.peripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
        
    }
    
    else if((self.characteristic.properties & CBCharacteristicPropertyWrite) != 0)
        
    {
        
        [self.peripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
        
    }
    
    else
        
    {
        
        NSLog(@"No write property on TX characteristic, %ld.",self.characteristic.properties);
        
    }
    
    //
    
}




@end

