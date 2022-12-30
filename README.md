# LW003-V3 iOS Software Development Kit Guide

* This SDK only support devices based on LW003-V3.

## Design instructions

* We divide the communications between SDK and devices into two stages: Scanning stage, Connection stage.For ease of understanding, let’s take a look at the related classes and the relationships between them.

`MKBVCentralManager`：global manager, check system’s bluetooth status, listen status changes, the most important is scan and connect to devices;

`MKBVInterface`: When the device is successfully connected, the device data can be read through the interface in `MKBVInterface `;

`MKBVInterface+MKBVConfig`: When the device is successfully connected, you can configure the device data through the interface in `MKBVInterface + MKBVConfig `;


## Scanning Stage

in this stage, `MKBVCentralManager` will scan and analyze the advertisement data of LW003-V3 devices.


## Connection Stage

The device broadcast information includes whether a password is required when connecting.

1.Enter the password to connect, then call the following method to connect:
`connectPeripheral:password:sucBlock:failedBlock:`
2.You do not need to enter a password to connect, call the following method to connect:
`connectPeripheral:sucBlock:failedBlock:`


# Get Started

### Development environment:

* Xcode9+， due to the DFU and Zip Framework based on Swift4.0, so please use Xcode9 or high version to develop;
* iOS12, we limit the minimum iOS system version to 12.0；

### Import to Project

CocoaPods

SDK-PIR is available through CocoaPods.To install it, simply add the following line to your Podfile, and then import <MKLoRaWAN-BV/MKBVSDK.h>:

**pod 'MKLoRaWAN-BV/SDK'**


* <font color=#FF0000 face="黑体">!!!on iOS 10 and above, Apple add authority control of bluetooth, you need add the string to “info.plist” file of your project: Privacy - Bluetooth Peripheral Usage Description - “your description”. as the screenshot below.</font>

*  <font color=#FF0000 face="黑体">!!! In iOS13 and above, Apple added permission restrictions on Bluetooth APi. You need to add a string to the project’s info.plist file: Privacy-Bluetooth Always Usage Description-“Your usage description”.</font>


## Start Developing

### Get sharedInstance of Manager

First of all, the developer should get the sharedInstance of Manager:

```
MKBVCentralManager *manager = [MKBVCentralManager shared];
```

#### 1.Start scanning task to find devices around you,please follow the steps below:

* 1.Set the scan delegate and complete the related delegate methods.

```
manager.delegate = self;
```

* 2.you can start the scanning task in this way:

```
[manager startScan];
```

* 3.at the sometime, you can stop the scanning task in this way:

```
[manager stopScan];
```

#### 2.Connect to device

The `MKBVCentralManager ` contains the method of connecting the device.



```
/// Connect device function
/// @param peripheral peripheral
/// @param password Device connection password,8 characters long ascii code
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
- (void)connectPeripheral:(nonnull CBPeripheral *)peripheral
                 password:(nonnull NSString *)password
                 sucBlock:(void (^)(CBPeripheral *peripheral))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;
```

```
/// Connect device function.
/// @param peripheral peripheral
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
- (void)connectPeripheral:(nonnull CBPeripheral *)peripheral
                 sucBlock:(void (^)(CBPeripheral *peripheral))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;
```

#### 3.Get State

Through the manager, you can get the current Bluetooth status of the mobile phone, and the connection status of the device. If you want to monitor the changes of these two states, you can register the following notifications to achieve:

* When the Bluetooth status of the mobile phone changes，<font color=#FF0000 face="黑体">`mk_bv_centralManagerStateChangedNotification`</font> will be posted.You can get status in this way:

```
[[MKBVCentralManager shared] centralStatus];
```

* When the device connection status changes， <font color=#FF0000 face="黑体"> `mk_bv_peripheralConnectStateChangedNotification` </font> will be posted.You can get the status in this way:

```
[MKBVCentralManager shared].connectState;
```

#### 4.Monitoring device disconnect reason.

Register for <font color=#FF0000 face="黑体"> `mk_bv_deviceDisconnectTypeNotification` </font> notifications to monitor data.


```
[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(disconnectTypeNotification:)
                                                 name:@"mk_bv_deviceDisconnectTypeNotification"
                                               object:nil];

```

```
- (void)disconnectTypeNotification:(NSNotification *)note {
    NSString *type = note.userInfo[@"type"];
    /*
    After connecting the device, if no password is entered within one minute, it returns 0x01. The device has no data communication for three consecutive minutes, it returns 0x02, and the shutdown protocol is sent to make the device shut down and return 0x03.Reset the device, return 0x04.After successful password change, it returns 0x05.
    */
}
```


#### 4.Monitor the scan data of the device.

When the device is connected, the developer can monitor the scan data of the device through the following steps:

*  1.Open data monitoring by the following method:

```
[[MKBVCentralManager shared] notifyStorageDataData:YES];
```


*  2.Set the delegate and complete the related delegate methods.

```

[MKBVCentralManager shared].dataDelegate = self;
                                               
```

* 3.Data Format Description

The maximum length of each packet of data is 176 bytes, and the data format is shown in the following table:

|  data content   | length (bytes) | data description |
| ---- | ---- | ---- |
| HEAD  | 1 | data frame header(0xED) |
| FLAG  | 1 | notify(0x02) |
| CMD  | 1 | CMD(0x01) |
| LEN  | 1 | data length |
| The data content is as follows |
| Number  | 1 | The number of Beacon in this package |
| Beacon0 Data Len  | 1 | The total data length of the first Beacon |
| Beacon0 Data Type | 1 | The data type of the first Beacon (refer to the data type table) |
| Beacon0 Timestamp  | 4 | Time to scan to the first Beacon |
| Timezone | 1 | The time zone of the current device |
| MAC Address  | 6 | MAC address of the first Beacon |
| RSSI  | 1 | RSSI of the first Beacon |
| Raw Data | Beacon0 Data Len - 1(Beacon0 Data Type) - 4(Beacon0 Timestamp) - 1(Timezone) - 6(MAC Address) - 1(RSSI)| The data broadcast by the first Beacon |
| ....... |
| BeaconN Data Len  | 1 | The total data length of the Nth Beacon |
| BeaconN Data Type | 1 | The data type of the Nth Beacon (refer to the data type table) |
| BeaconN Timestamp  | 4 | Time to scan to the Nth Beacon |
| Timezone | 1 | The time zone of the current device |
| MAC Address  | 6 | MAC address of the Nth Beacon |
| RSSI  | 1 | RSSI of the Nth Beacon |
| Raw Data | BeaconN Data Len - 1(BeaconN Data Type) - 4(BeaconN Timestamp) - 1(Timezone) - 6(MAC Address) - 1(RSSI)| The data broadcast by the Nth Beacon |

Device Type Description:

|  Device Type   | Value |
| ---- | ---- |
| iBeacon  | 0 |
| EddyStone-UID  | 1 |
| EddyStone-URL  | 2 |
| EddyStone-TLM  | 3 |
| BXP-iBeacon  | 4 |
| BXP-DeviceInfo  | 5 |
| BXP-ACC  | 6 |
| BXP-T&H  | 7 |
| BXP-Button  | 8 |
| BXP-Tag  | 9 |
| Unknown  | 10 |

* 4.Data parsing example:

```
#pragma mark - mk_bv_storageDataDelegate
- (void)mk_bv_receiveStorageData:(NSString *)content {
    NSInteger number = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(8, 2)];
    if (number == 0) {
        //The last piece of data, you can get the total number of stored data.
        NSString  *sum = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(10, 4)];
        return;
    }
    
    NSArray *list = [self parseSynData:content];
}
```

```

- (NSDateFormatter *)formatter {
    if (!_formatter) {
        _formatter = [[NSDateFormatter alloc] init];
        _formatter.dateFormat = @"YYYY/MM/dd hh:mm:ss";
    }
    return _formatter;
}

- (NSArray *)parseSynData:(NSString *)content {
    content = [content substringFromIndex:10];
    
    NSInteger index = 0;
    NSMutableArray *dataList = [NSMutableArray array];
    for (NSInteger i = 0; i < content.length; i ++) {
        if (index >= content.length) {
            break;
        }
        NSInteger subLen = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(index, 2)];
        index += 2;
        if (content.length < (index + subLen * 2)) {
            break;
        }
        NSString *subContent = [content substringWithRange:NSMakeRange(index, subLen * 2)];
        NSString *deviceType = [MKBLEBaseSDKAdopter getDecimalStringWithHex:subContent range:NSMakeRange(0, 2)];
        
        NSInteger time = [MKBLEBaseSDKAdopter getDecimalWithHex:subContent range:NSMakeRange(2, 8)];
        NSNumber *timezone = [MKBLEBaseSDKAdopter signedHexTurnString:[subContent substringWithRange:NSMakeRange(10, 2)]];
        self.formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:([timezone integerValue] * 0.5 * 60 * 60)];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
        NSString *timestamp = [self.formatter stringFromDate:date];
        NSString *tempMac = [subContent substringWithRange:NSMakeRange(12, 12)];
        tempMac = [tempMac uppercaseString];
        NSString *macAddress = [NSString stringWithFormat:@"%@:%@:%@:%@:%@:%@",[tempMac substringWithRange:NSMakeRange(0, 2)],[tempMac substringWithRange:NSMakeRange(2, 2)],[tempMac substringWithRange:NSMakeRange(4, 2)],[tempMac substringWithRange:NSMakeRange(6, 2)],[tempMac substringWithRange:NSMakeRange(8, 2)],[tempMac substringWithRange:NSMakeRange(10, 2)]];
        
        NSNumber *rssi = [MKBLEBaseSDKAdopter signedHexTurnString:[subContent substringWithRange:NSMakeRange(24, 2)]];
        NSString *rawData = [subContent substringFromIndex:26];
        
        index += subLen * 2;
        NSDictionary *dic = @{
            @"timestamp":timestamp,
            @"timezone":[NSString stringWithFormat:@"%@",timezone],
            @"deviceType":deviceType,
            @"macAddress":macAddress,
            @"rssi":[NSString stringWithFormat:@"%@",rssi],
            @"rawData":subContent,
        };
        [dataList addObject:dic];
    }
    return dataList;
}

```




#### 5.Monitoring device disconnect reason.

Register for <font color=#FF0000 face="黑体"> `mk_bv_deviceDisconnectTypeNotification` </font> notifications to monitor data.

```
[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(disconnectTypeNotification:)
                                                 name:@"mk_bv_deviceDisconnectTypeNotification"
                                               object:nil];

```

```
- (void)disconnectTypeNotification:(NSNotification *)note {
    /*After connecting the device, if no password is entered within one minute, it returns 0x01. The device has no data communication for three consecutive minutes, it returns 0x02, and the shutdown protocol is sent to make the device shut down and return 0x03.Reset the device, return 0x04.After successful password change, it returns 0x05.*/
}
```

#### 6.Monitor the log of device operation

When the device is connected, you can monitor the log information of the device operation through the following steps:

*  1.Enable the log data monitoring function.

```
[[MKBVCentralManager shared] notifyLogData:YES];
```


*  2.Set the data proxy and implement the related proxy methods:

```

[MKBVCentralManager shared].logDelegate = self;
                                               
```

* 3.Data Example Explanation

```
 #pragma mark - mk_bv_centralManagerLogDelegate
- (void)mk_bv_receiveLog:(NSString *)deviceLog {
    //deviceLog is an ASCII string.
}
```

# Change log

* 20210316 first version;
