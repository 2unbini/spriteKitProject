//
//  CellView.swift
//  slime
//
//  Created by 권은빈 on 2021/09/27.
//

import Foundation
import SpriteKit

class CellView: SKScene{
    
    // 배경화면 노드
    var background = SKSpriteNode(imageNamed: "frame")
    
    // 뒤로가기 버튼 노드
    var backwardButton = SKSpriteNode(imageNamed: "arrow_backward")
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        set_background()
        set_arrowButton()
        set_title("안녕")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: view) {
            if location.x <= -85 && location.y > 95 {
                
                let tableScene = TableScene()

                tableScene.scaleMode = .resizeFill
                view?.presentScene(tableScene)
                
                return
            }
        }
    }
    
    func set_title(_ title: String) {
        let titleNode = SKLabelNode(text: title)
        
        titleNode.name = "title"
        titleNode.fontSize = 30
        addChild(titleNode)
    }
    
    // 배경화면 세팅
    func set_background() {
        
        background.name = "background"
        background.size = CGSize(width: 650, height: 700)
        background.position = CGPoint(x: 0, y: 20)
        background.zPosition = -1
        addChild(background)
    }
    
    // 뒤로가기 버튼 세팅
    func set_arrowButton() {
        backwardButton.name = "backward"
        backwardButton.size = CGSize(width: 30, height: 30)
        backwardButton.position = CGPoint(x: -95, y: 110)
        addChild(backwardButton)
    }
    
}
