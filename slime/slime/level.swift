//
//  Level.swift
//  slime
//
//  Created by 권은빈 on 2021/09/26.
//

import Foundation
import SpriteKit

struct Level {
    var current = 1
    var count = 0
    var size = 80
    var levelUp = false
    
    // 레벨업 조건
    static var condition = [(0, 0), (1, 20), (2, 50), (3, 100), (4, 200)]
    
    mutating func levelPlus() {
        levelUp = false
        
        count += 1
        print(count)
        
        if (count == Level.condition[current].1) {
            count = 0
            current += 1
            size += size / 2
            levelUp = true
        }
        
        // 레벨 3 이상의 이미지 없으므로 계속 2 이미지 사용
        // 변경필요!!
        if (current >= 3) {
            current = 2
        }
    }
    
    func buildNextLevelSlime(_ lastPosition: CGPoint) -> (SKSpriteNode, [SKTexture]) {
        var nextSlime = SKSpriteNode()
        var textureArray = [SKTexture]()
        
        for i in 1...4 {
            let name = "front\(current)_\(i).png"
            textureArray.append(SKTexture(imageNamed: name))
        }
        
        let firstSlime = "front\(current)_1.png"
        nextSlime = SKSpriteNode(imageNamed: firstSlime)
        
        
        // size 커질 때 감동실화...!!
        // 레벨업하면 사이즈 커지게 하는 기능 추가
        nextSlime.size = CGSize(width: size, height: size)
        nextSlime.name = "front"
        nextSlime.position = lastPosition
        
        let slimeAnimation = SKAction.animate(with: textureArray, timePerFrame: 0.2)
        nextSlime.run(SKAction.repeatForever(slimeAnimation))
        
        return (nextSlime, textureArray)
    }
}
