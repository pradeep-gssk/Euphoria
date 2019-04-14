//
//  EUUpdate.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 4/14/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import Foundation

struct EUUpdate: Codable {
    var update: Bool
    
    enum CodingKeys: String, CodingKey {
        case update = "update"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        update = try values.decodeIfPresent(Bool.self, forKey: .update) ?? false
    }
}
