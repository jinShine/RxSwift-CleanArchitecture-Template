//
//  CommonExtension.swift
//  FoodFlyUserApp
//
//  Created by Seungjin on 25/07/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation
import UIKit
import MessageUI


////MARK: - UIStroyBoard

extension UIStoryboard {
	public class func create<T: UIViewController> (_: T.Type,
												   name: String = "Main",
												   bundle: Bundle? = nil,
												   identifier: String? = nil ) -> T {
		let storyboard = self.init(name: name, bundle: bundle)
		
		let withIndentifier = identifier ?? T.description().components(separatedBy: ".").last!
		return (storyboard.instantiateViewController(withIdentifier: withIndentifier) as? T)!
	}
}

///MARK: - UIAlertController

extension UIAlertController {
	static func make(title: String? = nil,
					 message: String? = nil,
           style: UIAlertController.Style,
					 ok: String? = nil,
					 okClosure: ((UIAlertAction) -> Void)? = nil,
					 cancel: String? = nil,
					 cancelClosure: ((UIAlertAction) -> Void)? = nil,
					 sheet: UIAlertAction...) -> UIAlertController {
		let alert = UIAlertController(title: title, message: message, preferredStyle: style)
		
		if ok != nil {
			alert.addAction(UIAlertAction(title: ok, style: .default, handler: okClosure))
		}
		
		if cancel != nil {
			alert.addAction(UIAlertAction(title: cancel, style: .cancel, handler: cancelClosure))
		}
		
		for value in sheet {
			alert.addAction(value)
		}
		return alert
	}
	
	func alertShow(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil ) {
		viewController.present(self, animated: animated, completion: completion)
	}
}

/////MARK: - UIActivityIndicatorView
//
//extension UIActivityIndicatorView {
//  convenience init(activityIndicatorStyle style: UIActivityIndicatorView.Style, scale: CGFloat) {
//    self.init(activityIndicatorStyle: style)
//    self.scale(scale)
//  }
//
//  func scale(_ value: CGFloat) {
//    self.transform = CGAffineTransform(scaleX: value, y: value)
//  }
//}
//
/////MARK: - UIBarButtonItem
//
//extension UIBarButtonItem {
//  convenience init(image: UIImage?, style: UIBarButtonItem.Style) {
//    self.init(image: image, style: style, target: nil, action: nil)
//  }
//}
//
/////MARK: - UISearchBar
//
//extension UISearchBar {
//  var textField: UITextField? {
//    return self.value(forKey: "searchField") as? UITextField
//  }
//
//  var textColor: UIColor {
//    set {
//      self.textField?.textColor = newValue
//    }
//
//    get {
//      return self.textField?.textColor ?? .black
//    }
//  }
//}
//
///MARK: - 스트링 로컬라이제이션 적용
extension String {
  var localize: String {
    return NSLocalizedString(self, comment: self)
  }

  //선택 문자열 배경색 변경
  func foregroundColorOfKeyword(keyword: String, color: UIColor) -> NSMutableAttributedString {
    let attrValue: NSMutableAttributedString = NSMutableAttributedString(string: self)
    attrValue.addAttributes([.foregroundColor: color], range: NSString(string: self).range(of: keyword))

    return attrValue
  }

  //선택 문자열 ------------처리
  func cancleLineOfKeyword(keyword: String) -> NSMutableAttributedString {
    let attrValue: NSMutableAttributedString = NSMutableAttributedString(string: self)
    attrValue.addAttributes([.baselineOffset: 0, .strikethroughStyle: 2], range: NSString(string: self).range(of: keyword))
    return attrValue
  }


  // 스트링 멀티라인 간격
  func lineSpacing(spacing: CGFloat) -> NSAttributedString {
    let style = NSMutableParagraphStyle()
    style.lineSpacing = spacing
    let attributes = [NSAttributedString.Key.paragraphStyle: style]
    return NSAttributedString(string: self, attributes: attributes)
  }

  //스트링 사이즈
//  func rect(font: UIFont, newAttributes: [NSAttributedString.Key: Any] = [:]) -> CGSize {
//    let size = CGSize(width: CGFloat.greatestFiniteMagnitude,
//              height: CGFloat.greatestFiniteMagnitude)
//
//    var attributes: [NSAttributedString.Key: Any] = [NSAttributedStringKey.font: font]
//    attributes.merge(dict: newAttributes)
//    let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
//    let rect = self.boundingRect(with: size,
//                   options: options,
//                   attributes: attributes,
//                   context: nil).size
//
//    return swap(rect)
//  }
//
//  func width(font: UIFont, newAttributes: [NSAttributedString.Key: Any] = [:]) -> CGFloat {
//    let size = CGSize(width: CGFloat.greatestFiniteMagnitude,
//              height: CGFloat.greatestFiniteMagnitude)
//
//    var attributes: [NSAttributedString.Key: Any] = [NSAttributedStringKey.font: font]
//    attributes.merge(dict: newAttributes)
//    let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
//    let width = self.boundingRect(with: size,
//                    options: options,
//                    attributes: attributes,
//                    context: nil).size.width
//
//    return snap(width)
//  }

//  func height(fitWidth width: CGFloat, font: UIFont, newAttributes: [NSAttributedStringKey: Any] = [:]) -> CGFloat {
//    let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
//
//    var attributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: font]
//    attributes.merge(dict: newAttributes)
//    let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
//    let height = self.boundingRect(with: size,
//                     options: options,
//                     attributes: attributes,
//                     context: nil).size.height
//    let scale = UIScreen.main.scale
//        return ceil(height * scale) / scale
//  }
//
//  //정규식
//  func isEmail() -> Bool {
//    let trial = Trial.email.trial()
//    return trial(self)
//  }
//
//  func isPassword() -> Bool {
//    let trail1 = Trial.length(.minimum, 6).trial()
//    let trail2 = Trial.length(.maximum, 12).trial()
//
//    if !trail1(self) || !trail2(self) {
//      return false
//    }
//
//    let trail3 = Trial.format("^[a-zA-Z]{6,12}$").trial()
//    let trail4 = Trial.format("^[0-9]{6,12}$").trial()
//
//    if trail3(self) || trail4(self) {
//      return false
//    }
//    return true
//  }
//
//  func isPhone() -> Bool {
//    let trail1 = Trial.format("^01[0-9]{1}-[0-9]{3,4}-[0-9]{4}$").trial()
//    let trail2 = Trial.format("^01[0-9]{1}[0-9]{3,4}[0-9]{4}$").trial()
//
//    if trail1(self) || trail2(self) {
//      return true
//    } else {
//      return false
//    }
//  }
//
//  func isCertificationNumber() -> Bool {
//    let trail = Trial.format("^[0-9]{4}$").trial()
//    return trail(self)
//  }
//
//  func isMessageCheck() -> Bool {
//    let trail = Trial.format("\\r\n$/g").trial()
//    return trail(self)
//
//  }
}
//
/////MARK: Int(문자열 소수점 처리)
//extension Int {
//  var numberTypeDecimal: String {
//    let numberFormatter = NumberFormatter()
//    numberFormatter.numberStyle = .decimal
//    return numberFormatter.string(from: NSNumber(value: self)) ?? ""
//  }
//}
//
//extension CGFloat {
//  func DegToRed() -> CGFloat {
//    return self * .pi / 180
//  }
//
//  func RedToDeg() -> CGFloat {
//    return self * 180 / .pi
//  }
//}
//
/////MARK - UITabBarController (회전방향)
//extension UITabBarController {
//  open override var shouldAutorotate: Bool {
//    if let viewController = self.selectedViewController {
//      return viewController.shouldAutorotate
//    }
//    return false
//  }
//
//  open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//    if let viewController = self.selectedViewController {
//      return viewController.supportedInterfaceOrientations
//    }
//    return .portrait
//  }
//}
//
/////MARK: UINavigationController (회전 방향)
//extension UINavigationController {
//  open override var shouldAutorotate: Bool {
//    if let viewController = self.topViewController {
//      return viewController.shouldAutorotate
//    }
//    return false
//  }
//
//  open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//    if let viewController = self.topViewController {
//      return viewController.supportedInterfaceOrientations
//    }
//    return .portrait
//  }
//}
//
/////MARK: UICollectionView(빈 뷰)
//extension UICollectionView {
//  var emptyView: UIView? {
//    get { return self.backgroundView }
//    set {
//      self.backgroundView = newValue
//      self.backgroundView?.isHidden = true
//    }
//  }
//}
//
//// MARK: - 최상위 뷰컨
//extension UIApplication {
//  static func topViewController(ViewController: UIViewController? =
//    UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
//
//    if let tabBarViewController = ViewController as? UITabBarController {
//      if let vc = tabBarViewController.selectedViewController {
//        return topViewController(ViewController: vc)
//      }
//    }
//
//    if let navigationViewController = ViewController as? UINavigationController {
//      if let vc = navigationViewController.visibleViewController {
//        return topViewController(ViewController: vc)
//      }
//    }
//
//    if let presentedViewController = ViewController?.presentedViewController {
//      return topViewController(ViewController: presentedViewController)
//    }
//
//    return ViewController
//  }
//}
//
//// MARK: - Dictionary
//extension Dictionary {
//  mutating func merge(dict: [Key: Value]) {
//    for (key, value) in dict {
//      updateValue(value, forKey: key)
//    }
//  }
//}
//
//extension UIView {
//  func dashedRect(color: UIColor = .black, width: CGFloat = 2, dashPattern: [CGFloat] = [10, 5]) {
//
//    if let subLayers = self.layer.sublayers {
//      for (index, layer) in subLayers.enumerated() where layer.name == "DashedRect" {
//        self.layer.sublayers?.remove(at: index)
//        break
//      }
//    }
//
//    let border = CAShapeLayer()
//    border.name = "DashedRect"
//    border.strokeColor = color.cgColor
//    border.lineDashPattern = dashPattern.map { NSNumber(value: Float($0)) }
//    border.frame = self.bounds
//    border.lineWidth = width
//    border.fillColor = nil
//    border.path = UIBezierPath(rect: self.bounds).cgPath
//    self.layer.addSublayer(border)
//  }
//
//    func dashedLine(color: UIColor = .black, width: CGFloat = 2, dashPattern: [CGFloat] = [10, 5], phase: CGFloat = 5, lineCap: String = kCALineCapRound) {
//
//        if let subLayers = self.layer.sublayers {
//            for (index, layer) in subLayers.enumerated() where layer.name == "DashedLine" {
//
//                self.layer.sublayers?.remove(at: index)
//                break
//
//            }
//        }
//
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: self.bounds.minX, y: self.bounds.midY))
//        path.addLine(to: CGPoint(x: self.bounds.maxX, y: self.bounds.midY))
//
//        let layer = CAShapeLayer()
//        layer.name = "DashedLine"
//        layer.path = path.cgPath
//        layer.strokeColor = color.cgColor
//        layer.lineWidth = width
//        layer.lineDashPattern = dashPattern.map { NSNumber(value: Float($0)) }
//        layer.lineDashPhase = phase
//        layer.lineJoin = lineCap
//
//        self.layer.addSublayer(layer)
//    }
//
//    func underLine(color: UIColor = .black, width: CGFloat = 2, dashPattern: [CGFloat] = [10, 5], phase: CGFloat = 5, lineCap: String = kCALineCapRound) {
//
//        if let subLayers = self.layer.sublayers {
//            for (index, layer) in subLayers.enumerated() where layer.name == "UnderLine" {
//
//                self.layer.sublayers?.remove(at: index)
//                break
//
//            }
//        }
//
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: self.bounds.minX, y: self.bounds.maxY-width))
//        path.addLine(to: CGPoint(x: self.bounds.maxX, y: self.bounds.maxY-width))
//
//        let layer = CAShapeLayer()
//        layer.name = "UnderLine"
//        layer.path = path.cgPath
//        layer.strokeColor = color.cgColor
//        layer.lineWidth = width
//        layer.lineDashPattern = dashPattern.map { NSNumber(value: Float($0)) }
//        layer.lineDashPhase = phase
//        layer.lineJoin = lineCap
//
//        self.layer.addSublayer(layer)
//    }
//}
//
//// MARK: NSTextAttachment
//extension NSTextAttachment {
//
//  static func image(_ image: UIImage?) -> NSTextAttachment {
//    let text = NSTextAttachment()
//    text.image = image
//    return text
//  }
//}
//
//
/////MARK: - UIColor를 Hex String 변환
//
//extension UIColor {
//  convenience init(hex: String) {
//    let hexStr: NSString = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased() as NSString
//    let scan = Scanner(string: hexStr as String)
//
//    if hexStr.hasPrefix("#") {
//      scan.scanLocation = 1
//    }
//
//    var color: UInt32 = 0
//    scan.scanHexInt32(&color)
//
//    let mask = 0x000000FF
//    let r = Int(color >> 16) & mask
//    let g = Int(color >> 8) & mask
//    let b = Int(color) & mask
//
//    let red   = CGFloat(r) / 255.0
//    let green = CGFloat(g) / 255.0
//    let blue  = CGFloat(b) / 255.0
//
//    self.init(red: red, green: green, blue: blue, alpha: 1)
//  }
//
//  func toHexStr() -> String {
//    var r: CGFloat = 0
//    var g: CGFloat = 0
//    var b: CGFloat = 0
//    var a: CGFloat = 0
//
//    getRed(&r, green: &g, blue: &b, alpha: &a)
//
//    let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
//
//    return NSString(format: "#%06x", rgb) as String
//  }
//
//  convenience init(r: Int, g: Int, b: Int, a: Int? = nil) {
//    self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a ?? 255) / 255)
//  }
//}
//
/////MARK: - UIImage확장
//extension UIImage {
//
//  ///MARK: UIColor로 UIImage 생성
//  class func imageWithColor(color: UIColor, size: CGSize) -> UIImage? {
//    let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//    UIGraphicsBeginImageContextWithOptions(size, false, 0)
//    color.setFill()
//    UIRectFill(rect)
//
//    guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
//      UIGraphicsEndImageContext()
//      return nil
//    }
//    UIGraphicsEndImageContext()
//    return image
//  }
//
//  ///MARK: Image To Circle
//
//  var circle: UIImage? {
//    let square = CGSize(width: min(size.width, size.height), height: min(size.width, size.height))
//    let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
//    imageView.contentMode = .scaleAspectFill
//    imageView.image = self
//    imageView.layer.cornerRadius = square.width/2
//    imageView.layer.masksToBounds = true
//    UIGraphicsBeginImageContext(imageView.bounds.size)
//    guard let context = UIGraphicsGetCurrentContext() else { return nil }
//    imageView.layer.render(in: context)
//    let result = UIGraphicsGetImageFromCurrentImageContext()
//    UIGraphicsEndImageContext()
//    return result
//  }
//
//  ///MARK: 이미지 틴트컬러 수정
//  func imageWithTintColor(color: UIColor) -> UIImage? {
//    let image = self.withRenderingMode(.alwaysTemplate)
//    UIGraphicsBeginImageContextWithOptions(size, false, scale)
//    color.set()
//    image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
//    let result = UIGraphicsGetImageFromCurrentImageContext()
//    UIGraphicsEndImageContext()
//    return result
//  }
//}
//
/////MARK: - Label 크기에 따른 폰트 크기 자동 변경
//extension UILabel {
//  func autoResizeCalculator(lines: Int, minScale: CGFloat, alian: NSTextAlignment, breakMode: NSLineBreakMode? = nil) {
//    self.adjustsFontSizeToFitWidth = true
//    self.numberOfLines = lines
//    self.minimumScaleFactor = minScale
//    self.textAlignment = alian
//
//    if let mode = breakMode {
//      self.lineBreakMode = mode
//    }
//
//  }
//}
//
/////MARK: --패스워드 암호화 처리
////extension String {
////    var convertSHA512: String {
////        guard let data = self.data(using: .utf8) else { return "" }
////        let nsData = data as NSData
////        var convertedDatas = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
////        CC_SHA512(nsData.bytes, CC_LONG(data.count), &convertedDatas)
////
////        let convertedDataString = convertedDatas.map {
////            return String(format: "%02x", $0)
////            }.joined()
////
////        return convertedDataString
////    }
////}
//
//////MARK: - D-Day
//extension Date {
//  func dateConversionDay(_ dateString: String) -> Int? {
//    let formatter = DateFormatter()
//    formatter.dateFormat = "yyyy-MM-dd"
//    guard let serverDate = formatter.date(from: dateString) else { return nil }
//    guard let currentDate = formatter.date(from: formatter.string(from: self)) else { return nil }
//
//    let components = Calendar.current.dateComponents([.day], from: serverDate, to: currentDate)
//
//    return components.day
//  }
//
//  static var currentMonth: Int {
//    //값이 nil이면 1월을 리턴
//    let components = Calendar.current.dateComponents([.month], from: Date())
//    return components.month ?? 1
//  }
//
//  static var currentDateString: String {
//    let formatter = DateFormatter()
//    formatter.dateFormat = "yyMMdd"
//    return formatter.string(from: Date())
//  }
//}
//
// MARK: CellName
extension UICollectionReusableView {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

//// MARK: Email
//extension MFMailComposeViewController {
//    static func factory(inject: () -> MailComposeModel) -> MFMailComposeViewController {
//        let object = inject()
//        let mailComposeVC = MFMailComposeViewController()
//        mailComposeVC.mailComposeDelegate = object.delegate
//        mailComposeVC.setToRecipients(object.toRecipients)
//        mailComposeVC.setSubject(object.subject)
//        mailComposeVC.setMessageBody(object.body, isHTML: object.isHTML)
//
//        return mailComposeVC
//    }
//}
//
//// MAKR:
//extension UIActivityViewController {
//    static func share(inject: () -> ShareModel ) -> UIActivityViewController {
//        var object = inject()
//
//
//        if let site = object.webSite, let contents = object.webContents {
//            object.shareItems.append(site)
//            object.shareItems.append(contents)
//        }
//
//        let activityViewController = UIActivityViewController(activityItems: object.shareItems, applicationActivities: nil)
//        activityViewController.excludedActivityTypes = [.print, .postToWeibo, .copyToPasteboard,
//                                                        .addToReadingList, .postToVimeo]
//        return activityViewController
//    }
//}
