//
//  ViewController.swift
//  OFO
//
//  Created by iMac on 2017/6/1.
//  Copyright © 2017年 JoJo. All rights reserved.
//

import UIKit
import SWRevealViewController
import FTIndicator



class ViewController: UIViewController, MAMapViewDelegate, AMapSearchDelegate,AMapNaviWalkManagerDelegate {

    var mapView: MAMapView!  //创建一个高德地图
    
    var search: AMapSearchAPI! //创建一个主搜索API
    
    var pin: MyPinAnnotation! //定义一个全局的大头针
    
    var pinView : MAAnnotationView! //保存视图
    
    var nearBySearch = true
    
    //线路查找
    var start,end : CLLocationCoordinate2D! //起始位置和结束为止
    var walkManger: AMapNaviWalkManager!
    
    
    
    ///面板
    @IBOutlet var panelView: UIView!
    
    ///定位按钮
    @IBAction func locationBtnTap(_ sender: UIButton) {
        
        print("定位按钮")
//        mapView.zoomLevel = 18 //缩放级别
        nearBySearch = true
        searchBickNearby()////搜索下附近
    }
    
    
    //搜索周边小黄车
    func searchBickNearby() {
        searchCustomLocation(mapView.userLocation.coordinate)//使用当前坐标搜索
    }
    
    func searchCustomLocation(_ center: CLLocationCoordinate2D) {
        /*
         第 5 步，设置周边检索的参数
         请求参数类为 AMapPOIAroundSearchRequest，location是必设参数。
         Objective-C	Swift
         let request = AMapPOIAroundSearchRequest()
         request.tableID = TableID
         
         request.location = AMapGeoPoint.location(withLatitude: CGFloat(39.990459), longitude: CGFloat(116.481476))
         request.keywords = "电影院"
         request.requireExtension = true
         */
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(center.latitude), longitude: CGFloat(center.longitude))//转换
        
        request.keywords = "便利店"
        request.radius = 500  //500mi半径
        request.requireExtension = true //显示相关的搜索(默认不显示)

        search.aMapPOIAroundSearch(request)//POI 周边查询接口
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        SWRevealViewController 
        
        
        mapView = MAMapView(frame: view.bounds)//初始化高德地图
        view.addSubview(mapView)
        view.bringSubview(toFront: panelView)//面板放到前面
        
        mapView.delegate = self
        

        
        //需要缩放到合适比例级别
        mapView.zoomLevel = 17 //缩放级别
        
        //定位蓝点
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow //追踪样式 (持续追逐 涉及到iOS隐私,需要到系统plist文件里面去配置)
        
       //搜索附近的小黄车
        search = AMapSearchAPI()
        search.delegate = self//搜索的代理
        
        walkManger = AMapNaviWalkManager()
        walkManger.delegate = self
        //小黄车没有数据,所以我们需要模拟小黄车的数据(通过其他POI数据来替换)
        
        
        
        //由于navigationItem的Item主题默认是蓝色,而图片是黄色,我们需要改系统的主题
        //设置设置UIImage的渲染模式：UIImage.renderingMode
        
        /**
         UIImageRenderingModeAutomatic  // 根据图片的使用环境和所处的绘图上下文自动调整渲染模式。
         UIImageRenderingModeAlwaysOriginal   // 始终绘制图片原始状态，不使用Tint Color。
         UIImageRenderingModeAlwaysTemplate   // 始终根据Tint Color绘制图片，忽略图片的颜色信息。
         
         renderingMode属性的默认值是UIImageRenderingModeAutomatic，即UIImage是否使用Tint Color取决于它显示的位置。其他情况可以看下面的图例
         **/
        
//        self.navigationItem.leftBarButtonItem?.image?.withRenderingMode(.alwaysOriginal)
//        self.navigationItem.rightBarButtonItem?.image?.withRenderingMode(.alwaysOriginal)
//        
        
        
        //注意:上述是添加控件之后添加图片,代码该主题没实现效果.所以直接代码添加items去实现
        //还是需要添加item的控件,然后去掉title
        self.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "leftTopImage").withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "rightTopImage").withRenderingMode(.alwaysOriginal)
        
        //添加中间
        self.navigationItem.titleView = UIImageView.init(image: #imageLiteral(resourceName: "ofoLogo"))
        
        //设置回退不显示title,只留返回按钮,为空title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        
        
     //视图
     //最开始启动容器
        
        if let revealVC = revealViewController() {
            
            revealVC.rearViewRevealWidth = 280 //如果侧边栏显示不完全就需要设置宽度
            
            navigationItem.leftBarButtonItem?.target = revealVC
            navigationItem.leftBarButtonItem?.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }

        //添加中间的地图
        /*
         (sb中添加控件)充满容易的约束 
         在Capabilities里面开启Maps功能
         勾选启用Pedestrian步行和Bike骑行功能
         */
        
        
        /*
            添加右边点击进入wenview
            scalesPageToFit启用  网页自适应
         */
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //大头针动画
    func pinAnimation() {
        //坠落效果,Y轴加速移
        
        let endFrame = pinView.frame
        pinView.frame = endFrame.offsetBy(dx: 0, dy: -15)
        
        //弹性动画
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: [], animations: {
            self.pinView.frame = endFrame
        }, completion: nil)
    }
    
    
    //MARK: - MapView Delegate
    
    func mapView(_ mapView: MAMapView!, rendererFor overlay: MAOverlay!) -> MAOverlayRenderer! {
        if overlay is MAPolyline {//当前图层渲染路线
            
            //锁住大图针
            pin.isLockedToScreen = false
            mapView.visibleMapRect = overlay.boundingMapRect//缩放
            
            let renderer = MAPolylineRenderer(overlay: overlay)
            
            renderer?.lineWidth = 8.0
            renderer?.strokeColor = UIColor.blue
            
            return renderer
            
        }
        //其他图层返回空
        return nil
    }
    
    
    func mapView(_ mapView: MAMapView!, didSelect view: MAAnnotationView!) {
        print("点击了目标图标")
        
        start = pin.coordinate //大图标坐标
        end = view.annotation.coordinate
        
        let startPoint = AMapNaviPoint.location(withLatitude:CGFloat(start.latitude), longitude:CGFloat(end.longitude))!
        let endPoint = AMapNaviPoint.location(withLatitude:CGFloat(end.latitude), longitude:CGFloat(end.longitude))!
        
        walkManger.calculateWalkRoute(withStart: [startPoint], end: [endPoint])
    }
    
    
    //用户移动地图的交互
    //将要移动
    
    func mapView(_ mapView: MAMapView!, didAddAnnotationViews views: [Any]!) {
        let aViews = views as! [MAAnnotationView]
        
        for aView in aViews {
            guard aView.annotation is MAPointAnnotation else {
                continue
            }
            
            aView.transform = CGAffineTransform(scaleX: 0, y: 0)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
                aView.transform = .identity
            }, completion: nil)
        }
    }
    
    
    func mapView(_ mapView: MAMapView!, mapDidMoveByUser wasUserAction: Bool) {
        if wasUserAction {
            pin.isLockedToScreen = true
            pinAnimation()
            searchCustomLocation(mapView.centerCoordinate)
        }
    }

    
    /// 地图初始化完成后
    ///
    /// - Parameter mapView: mapView
    func mapInitComplete(_ mapView: MAMapView!) {
        //创建一个MyPintAnnotion
        pin = MyPinAnnotation()
        pin.coordinate = mapView.centerCoordinate//中心坐标
        pin.lockedScreenPoint = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
        
        mapView.addAnnotation(pin)
        mapView.showAnnotations([pin], animated: true)
        
        //搜索下附近
        searchBickNearby()
        
        
    }
    
    
    
    /// 自定义大头针试图
    ///
    /// - Parameters:
    ///   - mapView: mapView
    ///   - annotation: 标注
    /// - Returns: 大头针视图
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) ->MAAnnotationView! {
//        print("大头针代理")
        //用户自定义的不需要自定义
        if annotation is MAUserLocation {
            return nil
        }
        
        if annotation is MyPinAnnotation {
            let reuseid = "anchor"
            var av = mapView.dequeueReusableAnnotationView(withIdentifier: reuseid)
            if av == nil {
                av = MAPinAnnotationView(annotation: annotation, reuseIdentifier: reuseid)
            }

            av?.image = #imageLiteral(resourceName: "homePage_wholeAnchor")
            av?.canShowCallout = false
            
            pinView = av
            
            return av
            
            
        }
        
        let reuseid = "myid"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseid) as? MAPinAnnotationView
        
        if annotationView == nil {
            annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: reuseid)
        }
        if annotation.title  == "正常可用" {
            annotationView?.image = #imageLiteral(resourceName: "HomePage_nearbyBike")
        }else{
            annotationView?.image = #imageLiteral(resourceName: "HomePage_nearbyBikeRedPacket")
            
        }
        
        annotationView?.canShowCallout = true //先是起泡
        annotationView?.animatesDrop = true//动画
        
        return annotationView
    
    }
    
    
    
    
    //# MARK: - AMap Search Delegate
    //搜索周边完成后的处理回调
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        /*
         第 7 步，在回调中处理数据
         当检索成功时，会进到 onPOISearchDone 回调函数中，通过解析 AMapPOISearchResponse 对象把检索结果在地图上绘制点展示出来。
         说明：
         1）可以在回调中解析 response，获取 POI 信息。
         2）response.pois 可以获取到 AMapPOI 列表，POI 详细信息可参考 AMapPOI 类。
         3）若当前城市查询不到所需 POI 信息，可以通过 response.suggestion.cities 获取当前 POI 搜索的建议城市。
         4）如果搜索关键字明显为误输入，则可通过 response.suggestion.keywords法得到搜索关键词建议。
         Objective-C	Swift
         func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
         
         if response.count == 0 {
         return
         }
         
         //解析response获取POI信息，具体解析见 Demo
         }
         */
        //        if response.count == 0 {
        //
        //        }
        //guard来替换上面的语句
        
//        
//        
//        for poi in response.pois{
//            print(poi)
//            print(poi.name)
//            dump(poi)
//        }
//        
//        
        
        guard response.count > 0 else {
            print("周边没有小黄车")
            return
        }
        
        var annotations : [MAPointAnnotation] = []
        
        annotations = response.pois.map {
            let annnotaion = MAPointAnnotation()
            
            annnotaion.coordinate = CLLocationCoordinate2D(latitude:CLLocationDegrees($0.location.latitude),longitude:CLLocationDegrees($0.location.longitude))
            
            //这里我们按距离来分红包单车和普通单车
            if $0.distance < 300{
                annnotaion.title = "红包区域内开锁任意小黄车"
                annnotaion.subtitle = "骑行10分钟可获得现金红包"
                
            }else{
                annnotaion.title = "正常可用"
            }
            
            return annnotaion
            
        }
        
        mapView.addAnnotations(annotations)
        
        if nearBySearch{
        mapView.showAnnotations(annotations, animated: true)//自动缩放
            nearBySearch = !nearBySearch
            
        }
    }

    //MARK: - AMapNaviWalkMangerDelegate 导航代理
    func walkManager(onCalculateRouteSuccess walkManager: AMapNaviWalkManager) {
        print("步行路线规划成功!")
        
        mapView.removeOverlays(mapView.overlays)
        
        var coordinates = walkManager.naviRoute!.routeCoordinates!.map {
            return CLLocationCoordinate2D(latitude: CLLocationDegrees($0.latitude), longitude: CLLocationDegrees($0.longitude))
        }
        
        let polyline = MAPolyline(coordinates: &coordinates, count: UInt(coordinates.count)) //绘制导航线 (需要添加协议)
        mapView.add(polyline)//添加导航线
        
        //提示步行距离和用时
       let walkMinute = walkManager.naviRoute!.routeTime / 60  //分钟为单位
        
        var timeDesc = "1分钟以内"
        if walkMinute > 0 {
            timeDesc = walkMinute.description + "分钟"
            
        }
        
        let hintTitle = "步行" + timeDesc
        
        let hintSubtile = "距离" + walkManager.naviRoute!.routeLength.description + "米"
        
//        let ac = UIAlertController(title: hintSubtile, message: hintSubtile, preferredStyle: .alert)
//        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
//        ac.addAction(action)
//        self.present(ac, animated:true, completion:nil)
        
        
        //显示导航时间和距离提示
        FTIndicator.setIndicatorStyle(.dark)
        FTIndicator.showNotification(with: #imageLiteral(resourceName: "clock"), title: hintTitle, message: hintSubtile)

    }
    
    func walkManager(_ walkManager: AMapNaviWalkManager, onCalculateRouteFailure error: Error) {
        print("路线规划失败:",error)
    }


}

