//
//  Todo.swift
//  RealmTodo
//
//  Created by 星みちる on 2019/07/30.
//  Copyright © 2019 星みちる. All rights reserved.
//

import RealmSwift

class Todo:Object{
    
    //ID(連番)識別番号的な
    @objc dynamic var id:Int = 0
    
    //タイトル
    @objc dynamic var title: String = ""
    
    //登録日時
    
    @objc dynamic var date:Date = Date()
    
}

//デフォルトでそれぞれのデータに0や""を入れておかないとエラーになる
