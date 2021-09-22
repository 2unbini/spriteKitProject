//
//  GameViewController.swift
//  slime
//
//  Created by 권은빈 on 2021/09/17.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene()
        
        // 뷰, 장면 생성
        if let view = view as? SKView {
            
            scene.scaleMode = .resizeFill
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            view.presentScene(scene)
        }

    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
