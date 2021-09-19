//
//  Button.swift
//  slime
//
//  Created by 권은빈 on 2021/09/19.
//

import Foundation
import SpriteKit

protocol ButtonDelegate: AnyObject {
    func buttonClicked(sender: Button)
}

class Button: SKSpriteNode {
    
    weak var delegate: ButtonDelegate!
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        
        super.init(texture: texture, color: color, size: size)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
        isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.delegate.buttonClicked(sender: self)
    }
}
