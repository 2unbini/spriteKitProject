//
//  GameScene.swift
//  slime
//
//  Created by 권은빈 on 2021/09/17.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // 원래 있던 애들
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    // 방향에 따라 다른 노드들
    // 배경 노드
    var slimeFront = SKSpriteNode()
    var slimeLeft = SKSpriteNode()
    var slimeRight = SKSpriteNode()
    var background = SKSpriteNode(imageNamed: "frame")
    
    // 노드의 마지막 위치
    // 터치액션이 끝나기 전에 다른 터치를 하면 해당 위치부터 시작하는 버그 있음
    var lastPosition = CGPoint(x: 0, y: 0)
    
    // .atlas에 있는 텍스처 배열
    private var textureArray = [SKTexture]()
    
    override func didMove(to view: SKView) {
        
        // 중심점 가운데로 설정
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // 정면 바라보는 슬라임 노드 만들기
        // 정면 바라보는 슬라임의 제자리 움직임 주기
        slimeFront = buildSlime("front")
        animateSlime(slimeFront)
        
        // 배경화면 노드 설정
        // 크기, 위치 하드코딩하는 방법 대신 좀 더 나은 방법..
        background.size = CGSize(width: 650, height: 700)
        background.position = CGPoint(x: 0, y: 20)
        background.zPosition = -1
        
        // 노드 장면에 추가
        self.addChild(background)
        self.addChild(slimeFront)

    }
    
    func buildSlime(_ direction: String) -> SKSpriteNode {
        
        // 텍스처 아틀라스(?) 찾아서 불러오기
        let textureAtlas = SKTextureAtlas(named: "slime_\(direction)")
        var tempArray = [SKTexture]()
        var slime = SKSpriteNode()
        
        // 각 이미지 텍스쳐로 만들어서 배열에 저장
        for i in 1...4 {
            let name = "\(direction)_\(i).png"
            tempArray.append(SKTexture(imageNamed: name))
        }
        textureArray = tempArray
        
        // 슬라임 노드의 첫 번째 이미지 지정
        let firstSlime = textureAtlas.textureNames[0]
        slime = SKSpriteNode(imageNamed: firstSlime)
        
        // 슬라임 노드 설정
        slime.size = CGSize(width: 80, height: 80)
        slime.name = direction
        slime.position = lastPosition
        
        return slime
    }

    func animateSlime(_ slime: SKSpriteNode) {
        // 슬라임 제자리 움직임 계속 주기
        
        let slimeAnimation = SKAction.animate(with: textureArray, timePerFrame: 0.2)
        slime.run(SKAction.repeatForever(slimeAnimation))
    }

    // 터치 감지됐을 때 호출되는 함수
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        // 움직이는동안 보여질 슬라임
        var moveSlime: SKSpriteNode
        var direction = ""
        
        // 터치한 곳의 좌표가 있으면 실행
        if let location = touch?.location(in: self) {

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
            
            // 같은 속도로 움직이게 하기
            // 움직임 주기
            let distance = posx - lastPosition.x > 0 ? posx - lastPosition.x : -(posx - lastPosition.x)
            let moveAction = SKAction.move(to: CGPoint(x: posx, y: posy), duration: Double(distance) / 80)
            childNode(withName: direction)?.run(moveAction)
            
            // 마지막 위치 저장 (실시간으로 움직이는 위치 저장할 수 있는지 찾아보기)
            // 그럼 위의 버그 사라짐
            self.lastPosition = CGPoint(x: posx, y: posy)
        }
    }
    
    func slimeXPosition(_ touchXPosition: CGFloat) -> CGFloat {
        if touchXPosition >= 90 { return 90 }
        else if touchXPosition <= -95 { return -95 }
        else { return touchXPosition }
    }
    
    func slimeDirection(_ currentPosition: CGFloat) -> String {
        if (currentPosition > lastPosition.x) { return "right" }
        else if (currentPosition < lastPosition.x) { return "left" }
        else { return "front" }
    }
    
}

