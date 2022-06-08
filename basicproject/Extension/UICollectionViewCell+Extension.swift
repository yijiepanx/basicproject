//
//  UICollectionViewCell+Extension.swift
//  FPVGreat
//
//  Created by UPC3965 on 2020/12/8.
//

import UIKit

extension UICollectionViewCell{
    ///给UITableView的Section切圆角 在willDisplaycell方法里面调用
    @objc func lgl_CollectionView(collectionView: UICollectionView, cellCornerRadius cornerRadius: CGFloat, forRowAt indexPath: IndexPath, cellBackColor: UIColor? = UIColor.white) {
            //圆率
            let cornerRadii = CGSize(width: cornerRadius, height: cornerRadius)
            // 每一段的行数
            let numberOfRows = collectionView.numberOfItems(inSection: indexPath.section)
            //绘制曲线
            var bezierPath: UIBezierPath?
            if numberOfRows == 1 {
                bezierPath = lgl_bezierRoundedPath(.allCorners, cornerRadii)
            } else {
                switch indexPath.row {
                    case 0: //第一个切左上右上
                        bezierPath = lgl_bezierRoundedPath([.topLeft, .topRight], cornerRadii)
                    case numberOfRows-1: //最后一个切左下右下
                        bezierPath = lgl_bezierRoundedPath([.bottomLeft, .bottomRight], cornerRadii)
                    default:
                        bezierPath = lgl_bezierPath()
                }
            }
            lgl_cellAddLayer(bezierPath!,cellBackColor)
        }
        
        ///切圆角
        private func lgl_bezierRoundedPath(_ corners:UIRectCorner, _ cornerRadii:CGSize) -> UIBezierPath {
            return UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: cornerRadii)
        }
        ///不切圆角
        private func lgl_bezierPath() -> UIBezierPath {
            return UIBezierPath.init(rect: self.bounds)
        }
        
        ///添加到cell上
    private func lgl_cellAddLayer(_ bezierPath:UIBezierPath,_ cellBackColor: UIColor? = UIColor.white)  {
            self.backgroundColor = .clear
             //新建一个图层
            let layer = CAShapeLayer()
            //图层边框路径
            layer.path = bezierPath.cgPath
            
            //图层填充色,也就是cell的底色
    //        layer.fillColor = UIColor.red.cgColor
            
    //      layer.strokeColor = UIColor.red.cgColor
        if let color = cellBackColor {
            layer.fillColor = color.cgColor
        }
        else{
            layer.fillColor = UIColor.white.cgColor
        }
            
            self.layer.insertSublayer(layer, at: 0)
        }
}
