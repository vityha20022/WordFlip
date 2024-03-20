//
//  File.swift
//  
//
//  Created by Виктор Борисовский on 20.03.2024.
//

import UIKit

public class DefaultButton: UIButton {
    private var text = ""
    private var color = UIColor.clear
    
    public init(text: String, color: MyColors) {
        super.init(frame: .zero)
        self.text = text
        self.color = color.setup()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func setup() {
        setTitle(text, for: .normal)
        // TODO: set settings size
        titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        backgroundColor = color
        layer.cornerRadius = 30
        layer.shadowRadius = 3
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowOpacity = 0.35
        layer.shadowRadius = 0.0
        layer.masksToBounds = false
        setTitleColor(MyColors.buttonText.setup(), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
