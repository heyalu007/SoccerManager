//
//  BtCentralController.m
//  SoccerManager
//
//  Created by ihandysoft on 16/2/1.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "BtCentralController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "Util.h"

@interface BtCentralController ()
<
CBCentralManagerDelegate,
CBPeripheralDelegate,
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) CBCentralManager *manager;
@property (strong, nonatomic) NSMutableArray *peripherals;//周边设备列表；
@property (nonatomic, strong) UITableView *tableView;

@end

static NSString * const kServiceUUID = @"312700E2-E798-4D5C-8DCF-49908332DF9F";//服务；
static NSString * const kCharacteristicUUID = @"FFA28CDE-6525-4489-801C-1C060CAC9767";//特征；

@implementation BtCentralController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CBCentralManager *manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    _manager = manager;
}


#pragma mark - CBCentralManagerDelegate

//监听CBCentralManager的状态的方法；
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            /*
             如果制定数组，则表示只扫描指定设备;
             如[_mgr scanForPeripheralsWithServices:@[@"123",@"456"] options:nil];
             只扫描UUID为123或456的设备;
             */
            [self.manager scanForPeripheralsWithServices:nil options:nil];
            //            [self.manager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:kServiceUUID]] options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
            break;
        default:
            NSLog(@"Central Manager did change state");
            break;
    }
}


#pragma mark - CBCentralManagerDelegate

/**
 *  扫描到蓝牙会调用
 *
 *  @param central           中央设备
 *  @param peripheral        周边设备
 *  @param advertisementData 广播数据
 *  @param RSSI              信号质量，可以通过信号质量判断远近；
 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    //把扫描到的蓝牙设备存入数组;
    
    if (![_peripherals containsObject:peripheral]) {
        peripheral.delegate = self;
        [_peripherals addObject:peripheral];
        [self.tableView reloadData];
        DebugLog(@"%ld   %@",_peripherals.count,peripheral);
    }
}


//连接外设成功调用;
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    
    [peripheral discoverServices:nil];//扫描外设中的服务;
}

//连接外设失败调用;
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    ;
}


#pragma mark - CBPeripheralDelegate

//只要扫描到服务就会调用;
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    
    NSArray *services = peripheral.services;
    for (CBService *service in services) {//拿到需要的服务;
        if([service.UUID.UUIDString isEqualToString:@"123"]) {
            //从服务中来获取特征;
            //找到后回调用下面的代理方法;
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
}

//只要扫描到特征就会调用;
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    
    // 拿到服务中所有的特征
    NSArray *characteristics =  service.characteristics;
    // 遍历特征, 拿到需要的特征处理
    for (CBCharacteristic * characteristic in characteristics) {
        if ([characteristic.UUID.UUIDString isEqualToString:@"8888"]) {
            NSLog(@"设置闹钟");
        }
    }
}


#pragma mark - tableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.peripherals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:ID];
    }
    CBPeripheral *peripheral = [self.peripherals objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = peripheral.name;
    cell.textLabel.text = @"123";
    return cell;
}

#pragma mark - tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CBPeripheral *peripheral = [self.peripherals objectAtIndex:indexPath.row];
    [self.manager connectPeripheral:peripheral options:nil];
}





#pragma mark - 懒加载

- (NSMutableArray *)peripherals {
    if (_peripherals == nil) {
        _peripherals = [NSMutableArray array];
    }
    return _peripherals;
}


- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


@end


/*
 
 2.详细描述
 每一个蓝牙设备都是靠服务(CBService)和特征(CBCharacteristic)来展示自己。
 一个蓝牙设备必然包含一个或多个服务，一个服务下面又会包含若干个特征。
 特征是与外界交互的最小单位。
 服务和特征都是用UUID来唯一标识的。
 设备里的各个服务和特征的功能，均由蓝牙设备厂家提供。
 
 3.开发步骤
 a)创建一个中心（centralManager）
 b)扫描周边外设
 c)扫描到后连接
 d)连接成功后，扫描连接成功的外设的里面的而服务
 e)扫描到服务后，扫描特征
 f）根据特征，就可以通讯了
 
 */
