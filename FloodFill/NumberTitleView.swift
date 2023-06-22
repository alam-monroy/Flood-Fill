//
//  NumberTitleView.swift
//  FloodFill
//
//  Created by Alam Monroy on 20/06/23.
//

import Foundation
import UIKit

class NumberTileView: UIView {
    let label: UILabel
    var index: [Int]
    
    init(number: Int, index: [Int]) {
        label = UILabel()
        label.text = "\(number)"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        self.index = index
        super.init(frame: .zero)
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSelected() {
        label.backgroundColor = .green
    }
    
    func isSelected() -> Bool {
        return label.backgroundColor != .clear
    }
    
    func getIndex() -> (x: Int, y: Int) {
        let x = index[0]
        let y = index[1]
        return (x, y)
    }
}
