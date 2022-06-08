//
//  OKBaseController.swift
//  okart
//
//  Created by panyijie on 2022/5/17.
//

import UIKit
import RxSwift
import Alamofire
import Moya
//列表异常显示
@objc public enum emptyType: Int {
    
    case normal
    case networkerror
    case nocontent
    case serverbusy
}

open class OKBaseController: UIViewController ,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    struct Content_Layout {
        static let smallPlayHeight: CGFloat = 62
        static let bottomMargin: CGFloat = 49 + UIDevice.safeBottomHeight()
    }
    //用户启动的时候，调用初始化接口
    var isInit: Bool = false
    
    //is First Appear
    var isFirstAppear: Bool = true
    
    var emptyType: emptyType = .normal
    
    //分页数据的时候page
    var page: Int = 1
    
    let disposeBag = DisposeBag()

   
    open override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        contentInsetOperation()
        extendNavigationBars()
        view.backgroundColor = UIColor.init(hexString: "#0D0D0D")
        
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let delegate  = UIApplication.shared.delegate as! AppDelegate
//        delegate.allowOrentitaionRotation = false
//        delegate.allowAll = false
//        UIDevice.current.deviceMandatoryLandscapeWithNewOrientation(interfaceOrientation: UIInterfaceOrientation.portrait)
//        UIViewController.attemptRotationToDeviceOrientation()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
  
    }
    open override func viewWillDisappear(_ animated: Bool) {
//        print(self,"show=false",self.self,"-----rign13")
    }
    public func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
        let emptyView = ScrollViewEmptyView()
        emptyView.dataForEmpty = getEmptyDataFor(emptyType: self.emptyType)
        emptyView.tapActionHandler = {
            [weak scrollView] in
            scrollView?.beginHeadRefreshing()
        }
        return emptyView
    }
    public func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -scrollView.bounds.size.height/9.0
    }
    public func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return self.emptyType != .normal
    }
    public func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
        return self.emptyType != .nocontent
    }
    public func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return false
    }
    public func emptyDataSetWillAppear(_ scrollView: UIScrollView!) {
        
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    open override var shouldAutorotate: Bool {
        return false
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    func obserVerNetWorkChange() {

    }
}


extension NSObject {
    func getEmptyDataFor(emptyType: emptyType) -> ScrollViewEmptyView.ScrollEmptyViewData {
        switch emptyType {
        case .normal:
            return ScrollViewEmptyView.EmptyData.normalData
        case .nocontent:
            return ScrollViewEmptyView.EmptyData.emptyData
        case .networkerror:
            return ScrollViewEmptyView.EmptyData.networkData
        case .serverbusy:
            return ScrollViewEmptyView.EmptyData.severErrorData
        }
    }
    //显示异常消息错误
    func showErrorMsgInCenterView(refresh: Bool, showListCount: Int, error: Error, defaultMsg: String? = nil){
        if refresh, showListCount == 0 {
            return
        }
        if refresh, showListCount > 0 {
            getShowMoyaErrorForMsg(error: error, defaultMsg: defaultMsg)
            return
        }
        
        if !refresh, showListCount > 0 {
            getShowMoyaErrorForMsg(error: error, defaultMsg: defaultMsg)
            return
        }
    }
    
    func getEmptyTypeFrom(error: Swift.Error) -> emptyType? {
        guard let moyaError = error as? RxSwiftMoyaError else {
            return .normal
        }
        switch moyaError {
        case .RXSwiftMoyaNoNetwork:
            return .networkerror
        case .RxSwiftMoyaNoData:
            return .nocontent
        case .RxSwiftMoyaNotSuccessfulHTTP:
            return .serverbusy
        default:
            return .serverbusy
        }
    }
    
    @discardableResult
    func getShowMoyaErrorForMsg(error: Swift.Error, defaultMsg: String? = nil, ignoreMsg: Bool = false) -> Int?{
        func showDefaulMsg(msgStr: String?) {
            if let defMsg = msgStr, !defMsg.isEmptyStr {
                HUDHelper.showFailureMessage(message: defMsg)
//                HUDHelper.showCenterMessage(message: defMsg)
            }
        }
        guard let moyaError = error as? RxSwiftMoyaError else {
            showDefaulMsg(msgStr: defaultMsg)
            return nil
        }
        switch moyaError {
        case .RxSwiftMoyaBizError(resultCode: let code, resultMsg: let msg):
            if ignoreMsg {
                showDefaulMsg(msgStr: defaultMsg)
            }else{
                let isEmptyMsg = msg?.isEmptyStr ?? true
                if !isEmptyMsg {
                    showDefaulMsg(msgStr: msg ?? "")
                }else{
                    showDefaulMsg(msgStr: defaultMsg)
                }
            }
            return code
        case .RXSwiftMoyaNoNetwork:
            showDefaulMsg(msgStr: "网络异常，请检查网络~")
        case .RxSwiftMoyaNoData:
            showDefaulMsg(msgStr: "无更多数据")
        case .RxSwiftMoyaNotSuccessfulHTTP:
            if ignoreMsg {
                showDefaulMsg(msgStr: defaultMsg)
            }else{
                if let defMsg = defaultMsg, !defMsg.isEmptyStr {
                    showDefaulMsg(msgStr: defMsg)
                }else{
                    showDefaulMsg(msgStr: "数据异常，请稍后再试")
                }
            }
        default:
            showDefaulMsg(msgStr: defaultMsg)
        }
        return nil
    }
    
    //swift.error to moyaerror
    @discardableResult
    func getMoyaErrorForMsg(error: Swift.Error) -> RxSwiftMoyaError?{
        guard let moyaError = error as? RxSwiftMoyaError else {
            return nil
        }
        return moyaError
    }

    
}

extension OKBaseController : UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController == self {
            navigationController.setNavigationBarHidden(true, animated: true)
        } else {
            if navigationController.isKind(of: UIImagePickerController.self) {
                return
            }

            navigationController.setNavigationBarHidden(false, animated: true)

//            if navigationController.delegate == viewController {
//                navigationController.delegate = nil
//            }
        }
    }
    
}

extension OKBaseController {
    //不自动调整滑动视图的偏移量
    func contentInsetOperation(scrollView: UIScrollView? = nil) {
        if #available(iOS 11.0, *) {
            scrollView?.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false;
        }
    }
    //控制视图的坐标系，默认从0，0开始，有导航的情况下
    func extendNavigationBars(){
//        extendedLayoutIncludesOpaqueBars = false;
//        self.edgesForExtendedLayout = .top
    }
}

extension OKBaseController {
   
    // 错误提示
    func showEmptyView(error: RxSwiftMoyaError, count: Int = 0) {
        switch error {
        case .RXSwiftMoyaNoNetwork:
            if count == 0 {
                self.emptyType = .networkerror
            }else {
                HUDHelper.showBottomMessage(message:  "网络异常，请检查网络~")
            }
        case .RxSwiftMoyaNoData:
            if count == 0 {
                self.emptyType = .nocontent
            }else {
                HUDHelper.showBottomMessage(message:  "无更多数据")
            }
        case .RxSwiftMoyaNotSuccessfulHTTP:
            if count == 0 {
                self.emptyType = .serverbusy
            }else {
                HUDHelper.showBottomMessage(message: "数据异常，请稍后再试")
            }
        default:
            self.emptyType = .normal
            break
        }
    }
   
}
