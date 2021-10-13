//
//  MessageListScene.swift
//  slime
//
//  Created by 권은빈 on 2021/09/26.
//

import Foundation
import SpriteKit
import SwiftUI

// tableView로 바꿈!

/*

struct Message {
    var id: Int
    var title: String
}

class MessageListScene: SKScene {
    
    // test용 인스턴스
    let messageList = [Message(id: 1, title: "hello"), Message(id: 2, title: "cool"), Message(id: 3, title: "bye"), Message(id: 4, title: "more class"), Message(id: 5, title: "T.T")]
    let pos = [60, 25, -10, -45, -80]
    let boxpos = [70, 35, 0, -35, -70]
    
    // 배경화면 노드
    var background = SKSpriteNode(imageNamed: "frame")
    
    // 뒤로가기 버튼 노드
    var backwardButton = SKSpriteNode(imageNamed: "arrow_backward")
    
    // 처음 장면 나올 때 초기화
    override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        set_background()
        set_arrowButton()
        //set_lists()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            
            // 뒤로가기 버튼이 있는 부분을 누르면 GameScene으로 이동
            if location.y >= 95 && location.x <= -85 {
                
                let scene = GameScene()
                
                scene.scaleMode = .resizeFill
                view?.presentScene(scene)
                
                return
            }
        }
    }
    
    // 각 리스트 생성
    // 지금은 LabelNode인데, list화 할 수 있는 노드 찾아야됨
    // SKLabelNode + SkSpriteNode = 극혐
    func set_lists() {
        for i in 0..<messageList.count {
            let boxNode = SKSpriteNode(imageNamed: "box")
            let listNode = SKLabelNode(text: messageList[i].title)
            listNode.fontName = "AppleSDGothicNeo-SemiBold"
            listNode.fontSize = 18
            listNode.fontColor = .black
            listNode.position = CGPoint(x: 0, y: pos[i])
            
            boxNode.size = CGSize(width: 230, height: 40)
            boxNode.position = CGPoint(x: 0, y: boxpos[i])
            addChild(boxNode)
            addChild(listNode)
        }
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

*/
