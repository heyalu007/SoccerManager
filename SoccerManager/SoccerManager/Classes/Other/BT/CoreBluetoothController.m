//
//  CoreBluetoothController.m
//  SoccerManager
//
//  Created by 何亚鲁 on 16/4/7.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "CoreBluetoothController.h"
#import <CoreBluetooth/CoreBluetooth.h>


@interface CoreBluetoothController ()
<
UITableViewDelegate,
UITableViewDataSource,
CBPeripheralDelegate,
CBCentralManagerDelegate
>

#define RX_SERVICE_UUID @"1234"
#define RX_CHAR_UUID @"1234"
#define TX_CHAR_UUID @"1234"

/**
 
 *外设数组
 
 */
@property(nonatomic, strong)NSMutableArray *peripherals;

/**
 
 *  中心管理者
 
 */
@property(nonatomic, strong)CBCentralManager *mgr;

/*
 
 *展示数据
 
 */
@property(nonatomic, strong)UITableView *tableView;

//外设
@property(nonatomic, strong)CBPeripheral *peripheral;

//特征
@property(nonatomic, strong)CBCharacteristic *characteristic;


@end


@implementation CoreBluetoothController


- (NSMutableArray *)peripherals {
    
    if(!_peripherals) {
        _peripherals = [NSMutableArray array];
    }
    return _peripherals;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIBarButtonItem *buttonI = [[UIBarButtonItem alloc] initWithTitle:@"扫描"style:UIBarButtonItemStylePlain target:self action:@selector(openOrclosed)];
    self.navigationItem.rightBarButtonItem = buttonI;
    UIBarButtonItem *buttonRB = [[UIBarButtonItem alloc] initWithTitle:@"open"style:UIBarButtonItemStylePlain target:self action:@selector(openTheDoor)];
    self.navigationItem.leftBarButtonItem = buttonRB;
    
    self.tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
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
    
    if (![self.peripherals containsObject:peripheral]) {
        
        //        if ([peripheral.identifier.UUIDString isEqualToString:@""]) {
        
        [self.peripherals addObject:peripheral];
        
        //        peripheral.delegate = self;
        
        [self.tableView reloadData];
        
        //        }
        
    }
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    self.peripheral = self.peripherals[indexPath.row];
    
    //    self.peripheral.delegate = self;
    
    //    ((CBPeripheral *)self.peripherals[indexPath.row]).delegate = self;
    
    //    [self.mgr connectPeripheral:self.peripherals[indexPath.row] options:nil];
    
    self.peripheral = self.peripherals[indexPath.row];
    [self.mgr connectPeripheral:self.peripheral options:nil];
    self.peripheral.delegate = self;
    //    ((CBPeripheral *)self.peripherals[indexPath.row]).delegate=self;
    
}

/**
 
 *扫描外设
 
 */

- (void)openOrclosed

{
    
    if([self.navigationItem.rightBarButtonItem.title isEqualToString:@"扫描"]) {
        
        NSLog(@"扫描");
        
        [self.navigationItem.rightBarButtonItem setTitle:@"断开"];
        
        // 1.创建中心设备
        
        //设置代理
        
        self.mgr = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        
        // 2.利用中心设备扫描外部设备
        
        /*
         
         如果指定数组代表只扫描指定的设备
         
         */
        
        [self.mgr scanForPeripheralsWithServices:nil options:nil];
        
    }else {
        
        NSLog(@"断开");
        
        [self.mgr stopScan];
        
        if (self.peripheral !=nil)
            
        {
            
            NSLog(@"disConnect start");
            
            [self.mgr cancelPeripheralConnection:self.peripheral];
            
        }
        
        self.peripherals =nil;
        
        [self.tableView reloadData];
        
        [self.navigationItem.rightBarButtonItem setTitle:@"扫描"];
        
    }
    
}

/**
 
 *  连接外设成功调用
 
 */

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral

{
    
    //    [self showTheAlertViewWithMassage:@"链接成功"];
    
    NSLog(@"链接成功");
    
    // 扫描外设中得服务
    
    [peripheral discoverServices:nil];
    
}

/**
 
 *  连接外设失败调用
 
 */

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error

{
    
    //    [self showTheAlertViewWithMassage:@"链接失败"];
    
    NSLog(@"链接失败");
    
}

#pragma makr - CBPeripheralDelegate

/**
 
 *  只要扫描到服务就会调用
 
 *
 
 *  @param peripheral服务所在的外设
 
 */

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error

{
    
    NSLog(@"扫描服务");
    
    //    [self showTheAlertViewWithMassage:@"扫描服务"];
    
    // 获取外设中所有扫描到得服务
    
    NSArray *services = peripheral.services;
    
    for (CBService *service in services) {
        
        //拿到需要的服务
        
        NSLog(@"%@", service.UUID.UUIDString);
        
        if ([service.UUID.UUIDString isEqualToString:RX_SERVICE_UUID])
            
        {
            
            [self showTheAlertViewWithMassage:@"拿到了对应的服务了"];
            
            //从需要的服务中查找需要的特征
            
            //从peripheral中得service中扫描特征
            
            [peripheral discoverCharacteristics:nil forService:service];
            
        }
        
    }
    
}

/**
 
 *  只要扫描到特征就会调用
 
 *
 
 *  @param peripheral特征所属的外设
 
 *  @param service特征所属的服务
 
 */

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error

{
    
    NSLog(@"扫描特征");
    
    // 拿到服务中所有的特征
    
    NSArray *characteristics = service.characteristics;
    
    // 遍历特征, 拿到需要的特征处理
    
    for (CBCharacteristic *characteristic in characteristics) {
        
        if ([characteristic.UUID.UUIDString isEqualToString:RX_CHAR_UUID]) {
            
            //            [self showTheAlertViewWithMassage:@"拿到只读的的特征了"];
            
            NSLog(@"拿到可写的的特征了");
            
            //            characteristic.value
            
            NSString *valueStr = [[NSString alloc]initWithData:characteristic.value encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@????", valueStr);
            
            self.characteristic = characteristic;
            
            [self showTheAlertViewWithMassage:valueStr];
            
        }
        
        if ([characteristic.UUID.UUIDString isEqualToString:TX_CHAR_UUID]) {
            
        }
        
    }
    
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central

{
    
    NSLog(@"检测代理方法");
    
    if (central.state == 5) {
        
        [self.mgr scanForPeripheralsWithServices:nil options:nil];
        
        //        [self showTheAlertViewWithMassage:@"手机蓝牙处于可用状态"];
        
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
    
    NSLog(@">>>>>>>");
    
    if (error)
        
    {
        
        NSLog(@"Error updating value for characteristic %@ error: %@", characteristic.UUID, [error localizedDescription]);
        
        //        if ([_mainMenuDelegate respondsToSelector:@selector(DidNotifyReadError:)])
        
        //            [_mainMenuDelegate DidNotifyReadError:error];
        
        //
        
        //        return;
        
    }
    
    NSMutableData *recvData;
    
    [recvData appendData:characteristic.value];
    
    if ([recvData length] >= 5)//已收到长度
        
    {
        
        unsigned char *buffer = (unsigned char *)[recvData bytes];
        
        int nLen = buffer[3]*256 + buffer[4];
        
        if ([recvData length] == (nLen+3+2+2))
            
        {
            
            //接收完毕，通知代理做事
            
            //            if ([_mainMenuDelegate respondsToSelector:@selector(DidNotifyReadData)])
            
            //                [_mainMenuDelegate DidNotifyReadData];
            
            NSLog(@"???????");
            
        }
        
    }
    
}

- (void)didReceiveMemoryWarning

{
    
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
    
}

- (void)showTheAlertViewWithMassage:(NSString *)massage

{
    
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"温馨提示"message:massage delegate:self cancelButtonTitle:@"确定"otherButtonTitles:nil];
    
    [alertV show];
    
}

- (void)openTheDoor

{
    
    NSLog(@"拿到了可读可写的特征了");
    
    //    self.peripheral.delegate = self;
    
    //    characteristic.value = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    //    characteristic.value = [NSData dataWithBytes:string.UTF8String length:string.length];
    
    //    [self.peripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
    
    //    [self.peripheral setNotifyValue:NO forCharacteristic:self.characteristic];
    
    [self writeString:@"OLWANDA_IL12345678"];
    
}

- (void) writeString:(NSString *) string

{
    
    NSData *data = [NSData dataWithBytes:string.UTF8String length:string.length];
    
    //       NSLog(@"%@",self.characteristic.UUID.UUIDString);
    
    self.peripheral.delegate=self;
    
    NSLog(@"%@",self.peripheral.delegate);
    
    if((self.characteristic.properties& CBCharacteristicPropertyWriteWithoutResponse) != 0)
        
    {
        
        [self.peripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
        
    }
    
    else if((self.characteristic.properties& CBCharacteristicPropertyWrite) != 0)
    {
        [self.peripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
    }
    else
    {
        NSLog(@"No write property on TX characteristic, %ld.",self.characteristic.properties);
    }
}


@end
