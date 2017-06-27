//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#import "SWRevealViewController/SWRevealViewController.h"


//定位SDK  (单次定位)
//http://lbs.amap.com/api/ios-location-sdk/guide/get-location/singlelocation
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

//地图SDK (显示地图)
//http://lbs.amap.com/api/ios-sdk/guide/create-map/show-map
#import <MAMapKit/MAMapKit.h>
//#import <AMapFoundationKit/AMapFoundationKit.h>

//搜索功能 属于地图SDK
//http://lbs.amap.com/api/ios-sdk/guide/map-data/poi
//在桥接文件中引入头文件
//#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

//导航SDK  (步行路线)
//http://lbs.amap.com/api/ios-navi-sdk/guide/route-plan/walk-route-plan
//http://lbs.amap.com/api/ios-navi-sdk/guide/tools/swift (Swift高德地图使用方法)
#import <AMapNaviKit/AMapNaviKit.h>
//#import <MAMapKit/MAMapKit.h>
//#import <AMapFoundationKit/AMapFoundationKit.h>
//#import <AMapSearchKit/AMapSearchKit.h>




#import <AVOSCloud/AVOSCloud.h>
