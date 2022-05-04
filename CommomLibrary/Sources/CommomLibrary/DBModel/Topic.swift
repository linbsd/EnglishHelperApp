//
//  File.swift
//  
//
//  Created by 老房东 on 2022-03-08.
//

import Foundation
import RealmSwift

public class Topic: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) public var id: ObjectId
    @Persisted public var name: String
    @Persisted public var isSelect = true
    @Persisted public var pictures = RealmSwift.List<Picture>()
    
    @Persisted(originProperty: "topics") public var assignee: LinkingObjects<Chapter>
}

struct JTopic: Codable, Identifiable {
    var id = UUID()
    var name: String
    var pictureFiles = [JPictureFile]()
    var isSelect = true
    enum CodingKeys: String, CodingKey {
        case pictureFiles
        case name
    }
}