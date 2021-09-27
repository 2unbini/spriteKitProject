//
//  GameScene.swift
//  gameFormat
//
//  Created by 권은빈 on 2021/09/26.
//

import Foundation
import SpriteKit
import UIKit

class GameRoomTableView: UITableView,UITableViewDelegate,UITableViewDataSource {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GameRoomTableView.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        cell.textLabel?.text = GameRoomTableView.items[indexPath.row]
        
        // 셀 투명하게 하기
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.textLabel?.textColor = .white
        
        return cell
    }
    
    // Section 나누기 -> 필요 없어서 지움
    /*
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
     */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
}

extension GameRoomTableView {
    static var items: [String] = ["안녕", "좋은 아침이야", "행복한 하루 보내", "즐겁다", "맛있게 먹어"]
}

class TableScene: SKScene {
    
    // 배경화면 노드
    var background = SKSpriteNode(imageNamed: "frame")
    
    // 뒤로가기 버튼 노드
    var backwardButton = SKSpriteNode(imageNamed: "arrow_backward")
    
    // tableView 생성
    var gameTableView = GameRoomTableView()
    
    private var label : SKLabelNode?
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // 테이블, 배경화면, 뒤로가기 버튼 세팅
        set_tableView()
        set_background()
        set_arrowButton()
        
        // tableView subView에 추가
        // 뷰를 추가하는 것이기 때문에 따로 삭제 해 줘야 함.
        self.scene?.view?.addSubview(gameTableView)
        gameTableView.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            
            // 뒤로가기 버튼이 있는 부분을 누르면 GameScene으로 이동
            if location.y >= 95 && location.x <= -85 {
                
                let scene = GameScene()
                
                // 테이블 뷰 삭제 해 주기
                self.view?.viewWithTag(1)?.removeFromSuperview()
                
                // 교체할 장면 세팅 후 나타내기
                scene.scaleMode = .resizeFill
                view?.presentScene(scene)
                
                return
            }
        }
    }
    
    // 테이블 뷰 세팅
    func set_tableView() {
        gameTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        gameTableView.frame = CGRect(x:60,y:150,width:200,height:160)
        gameTableView.backgroundColor = UIColor(white: 0, alpha: 0)
        gameTableView.tag = 1
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
