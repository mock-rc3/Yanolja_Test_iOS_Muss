//
//  UITableView.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/21.
//

import Foundation
import UIKit


//테이블 뷰 비어있을 때 띄우는 화면
extension UITableView {
    func setEmptyView(title: String, message: String, btnMessage: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        let showList = UIView()
        let listLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        showList.translatesAutoresizingMaskIntoConstraints = false
        listLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = UIColor.darkGray
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont.systemFont(ofSize: 15)
        showList.layer.addBorder([.top, .right, .bottom, .left], color: UIColor.emailBlue, width: 0.5)
        showList.layer.cornerRadius = 10
        listLabel.textColor = UIColor.emailBlue
        listLabel.font = UIFont.systemFont(ofSize: 18)
        
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        showList.addSubview(listLabel)
        emptyView.addSubview(showList)
        
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
//        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
//        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        showList.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        showList.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 30).isActive = true
        listLabel.centerXAnchor.constraint(equalTo: showList.centerXAnchor).isActive = true
        listLabel.centerYAnchor.constraint(equalTo: showList.centerYAnchor).isActive = true
        
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        listLabel.text = btnMessage
        listLabel.textAlignment = .center
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
}
