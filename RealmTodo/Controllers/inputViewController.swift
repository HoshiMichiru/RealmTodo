//
//  inputViewController.swift
//  RealmTodo
//
//  Created by 星みちる on 2019/07/30.
//  Copyright © 2019 星みちる. All rights reserved.
//

import UIKit
import RealmSwift


class inputViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    
    @IBOutlet weak var button: UIButton!
    
    //前の画面から渡されてきたTODOを受け取る変数
    var todo:Todo? = nil
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        if todo == nil{
            //新規追加の場合
        button.setTitle("追加", for: .normal)
        }else{
            //編集の場合
            button.setTitle("更新", for: .normal)
            textField.text = todo?.title
        }
    }
    
    fileprivate func createNewTodo(_ text: String) {
        //Realmに接続
        let realm = try!Realm()
        //から文字でなければ、データを登録する
        let todo = Todo()
        //最大のIDを取得
        let id = getMaxId()
        
        todo.id = id
        todo.title = text
        todo.date = Date()
        
        try! realm.write {
            realm.add(todo)
        }
    }
    
    fileprivate func updateTodo(_ text: String) {
        //更新,まずれるむに接続
        let realm = try!Realm()
        
        try!realm.write{
            todo?.title = text
        }
    }
    
    @IBAction func inputButton(_ sender: UIButton) {
        //nilかチェックする
//        if textField.text == ""{でもから文字チェックになる
        guard let text = textField.text else{
//            textField.textがnilの場合
//            ボタンがクリックされた時の処理を中断
            return //何も処理をしない
        
        }
        
        if text.isEmpty{
//            textField.textがから文字の場合
//            ボタンがクリックされた時の処理を中断
            return
        }
        
        if todo == nil {
            //新規タスクを追加
            createNewTodo(text)
        }else{
            updateTodo(text)
        }
        
        //新規タスクを追加
        createNewTodo(text)
        
        //前の画面に戻る
//        navigationControllerの持っている履歴から、１つ前の画面に戻る
        navigationController?.popViewController(animated: true)
    }
    
    // 最大IDを取得するメソッド
    func getMaxId() -> Int {
        // Realmに接続
        let realm = try! Realm()
        
        // Todoのシートから最大のIDを取得する（nilが入ってるかもしれない値Int?を返す）
        let id = realm.objects(Todo.self).max(ofProperty: "id") as Int?
        
        if id == nil {
            // 最大IDがnil(存在しない)場合、1を返す
            return 1
        } else {
            // 最大IDが存在する場合、最大ID + １を返す
            return id! + 1
        }
    }

}
