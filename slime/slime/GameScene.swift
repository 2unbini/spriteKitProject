//
//  GameScene.swift
//  slime
//
//  Created by 권은빈 on 2021/09/17.
//

import SpriteKit
import GameplayKit
import SwiftUI

// MARK: Basic game Scene! not View - with SpriteKit

class GameScene: SKScene {
    
    // 현재 노드
    var currentSlime = SKSpriteNode()
    
    // 배경 노드
    var background = SKSpriteNode(imageNamed: "frame")
    
    // 버튼 노드
    var levelUpButton = SKSpriteNode(imageNamed: "heart")
    
    // 메시지 버튼 노드
    var messageButton = SKSpriteNode(imageNamed: "message")
    
    // 레벨 관련 변수
    var level = Level()
    
    // 노드의 마지막 위치
    // update 함수로 계속 갱신함
    var lastPosition = CGPoint(x: 0, y: 0)
    
    // .atlas에 있는 텍스처 배열
    private var textureArray = [SKTexture]()
    
    // 뷰에 장면이 나타났을 때 호출
    override func didMove(to view: SKView) {
        
        // 중심점 가운데로 설정
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // 정면 바라보는 슬라임 노드 만들기
        // 정면 바라보는 슬라임의 제자리 움직임 주기
        currentSlime = buildSlime("front")
        animateSlime(currentSlime)
        
        // 배경화면 노드 설정
        set_background()
        // 버튼 노드 설정
        set_levelUpButton()
        // 메세지 버튼 노드 설정
        set_messageListButton()
        
        // 노드 장면에 추가
        self.addChild(background)
        self.addChild(levelUpButton)
        self.addChild(messageButton)
        self.addChild(currentSlime)
    }
    
    // 배경화면 노드 설정
    func set_background() {
        background.name = "background"
        background.size = CGSize(width: 650, height: 700)
        background.position = CGPoint(x: 0, y: 20)
        background.zPosition = -1
    }
    
    // 버튼 노드 설정
    func set_levelUpButton() {
        levelUpButton.name = "levelButton"
        levelUpButton.size = CGSize(width: 30, height: 30)
        levelUpButton.position = CGPoint(x: 90, y: 110)
    }
    
    // 메시지 버튼 노드 설정
    func set_messageListButton() {
        messageButton.name = "messageButton"
        messageButton.size = CGSize(width: 30, height: 30)
        messageButton.position = CGPoint(x: 90, y: 75)
    }
    
    func buildSlime(_ direction: String) -> SKSpriteNode {
        
        var tempArray = [SKTexture]()
        var slime = SKSpriteNode()
 
        
        // 각 이미지 텍스쳐로 만들어서 배열에 저장
        for i in 1...4 {
            let name = "\(direction)\(level.current)_\(i).png"
            tempArray.append(SKTexture(imageNamed: name))
        }
        
        textureArray = tempArray

        // 슬라임 노드의 첫 번째 이미지 지정
        let firstSlime = "\(direction)\(level.current)_1.png"
        slime = SKSpriteNode(imageNamed: firstSlime)
        
        // 슬라임 노드 설정
        slime.size = CGSize(width: level.size, height: level.size)
        slime.name = direction
        slime.position = lastPosition
        
        return slime
    }

    func animateSlime(_ slime: SKSpriteNode) {
        // 슬라임 제자리 움직임 계속 주기
        
        let slimeAnimation = SKAction.animate(with: textureArray, timePerFrame: 0.2)
        slime.run(SKAction.repeatForever(slimeAnimation))
    }
    
    override func update(_ currentTime: TimeInterval) {
        // 슬라임의 현재 위치 계속 갱신
        
        let currentPositionX = currentSlime.position.x
        lastPosition.x = currentPositionX
    }

    // 터치 감지됐을 때 호출되는 함수
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        // 움직이는동안 보여질 슬라임
        var moveSlime: SKSpriteNode
        var direction = ""
        
        // 터치한 곳의 좌표가 있으면 실행
        if let location = touch?.location(in: self) {
            
            // 버튼 노드 부근이면 레벨 카운트 +1
            // 다음 레벨 슬라임 생성
            if location.y > 95 && location.x > 85 {
                level.levelPlus()
                
                if level.levelUp == true {
                    (currentSlime, textureArray) = level.buildNextLevelSlime(lastPosition)
                    self.children.last?.removeFromParent()
                    self.addChild(currentSlime)
                }
                
                return
            }
            
            // 메시지 버튼 노드 부근이면 신 교체
            
            if location.y > 65 && location.x > 85 {
                let tableScene = TableScene()

                tableScene.scaleMode = .resizeFill
                view?.presentScene(tableScene)
                
                return
            }

            // 좌표 x, y
            // y 축으로는 이동하지 않도록 0 고정
            let posx: CGFloat
            let posy: CGFloat = 0.0
            
            // 슬라임 이동 제한구역 설정
            posx = slimeXPosition(location.x)
            
            // 슬라임 방향 설정
            direction = slimeDirection(posx)
            
            // 움직이는 슬라임 생성, 제자리 움직임 주기
            moveSlime = buildSlime(direction)
            animateSlime(moveSlime)
            
            // 기존에 있던 슬라임 삭제하고 움직이는 슬라임 장면에 추가
            self.children.last?.removeFromParent()
            self.addChild(moveSlime)
            currentSlime = moveSlime
            
            // 같은 속도로 움직이게 하기
            // 움직임 주기
            let distance = posx - lastPosition.x > 0 ? posx - lastPosition.x : -(posx - lastPosition.x)
            let moveAction = SKAction.move(to: CGPoint(x: posx, y: posy), duration: Double(distance) / 80)
            childNode(withName: direction)?.run(moveAction)

        }
    }
    
    // 슬라임 이동 제한구역 두기
    func slimeXPosition(_ touchXPosition: CGFloat) -> CGFloat {
        if touchXPosition >= 85 { return 85 }
        else if touchXPosition <= -95 { return -95 }
        else { return touchXPosition }
    }
    
    // 슬라임 방향 설정
    func slimeDirection(_ currentPosition: CGFloat) -> String {
        if (currentPosition > lastPosition.x) { return "right" }
        else if (currentPosition < lastPosition.x) { return "left" }
        else { return "front" }
    }
    
}

