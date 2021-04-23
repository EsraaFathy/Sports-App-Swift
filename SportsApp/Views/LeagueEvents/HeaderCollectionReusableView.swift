//
//  HeaderCollectionReusableView.swift
//  SportsApp
//
//  Created by Esraa on 22/04/2021.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
        static let idetifire = "cellHeader"
    
    public func configer(){
        //backgroundColor = .systemGray
        addSubview(label)
    }
    private let label : UILabel = {
        let label = UILabel()
        label.text = "Header"
        label.textAlignment = .center
        return label
        
    }()
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        label.frame = bounds
    }
}
