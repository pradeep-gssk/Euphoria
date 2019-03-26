//
//  EUActivity.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 3/25/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import Foundation

struct EUActivity: Codable {
    
    var trtDescription: String?
    var trtDuration: Int?
    var trtPrice: Decimal?
    var discountPrcnt: Decimal?
    var discountValue: Decimal?
    var appointmentDate: String?
    var appointmentStartTime: String?
    var appointmentEndTime: String?
    var appointmentTherapist: String?
    var appointmentRoom: String?
    var pmsRoom: String?
    var prodDescr: String?
    
    enum CodingKeys: String, CodingKey {
        case trtDescription = "TrtDescription"
        case trtDuration = "TrtDuration"
        case trtPrice = "TrtPrice"
        case discountPrcnt = "DiscountPrcnt"
        case discountValue = "DiscountValue"
        case appointmentDate = "AppointmentDate"
        case appointmentStartTime = "AppointmentStartTime"
        case appointmentEndTime = "AppointmentEndTime"
        case appointmentTherapist = "AppointmentTherapist"
        case appointmentRoom = "AppointmentRoom"
        case pmsRoom = "PMSRoom"
        case prodDescr = "ProdDescr"
    }
}

extension EUActivity {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(trtDescription, forKey: .trtDescription)
        try container.encode(trtDuration, forKey: .trtDuration)
        try container.encode(trtPrice, forKey: .trtPrice)
        try container.encode(discountPrcnt, forKey: .discountPrcnt)
        try container.encode(discountValue, forKey: .discountValue)
        try container.encode(appointmentDate, forKey: .appointmentDate)
        try container.encode(appointmentStartTime, forKey: .appointmentStartTime)
        try container.encode(appointmentEndTime, forKey: .appointmentEndTime)
        try container.encode(appointmentTherapist, forKey: .appointmentTherapist)
        try container.encode(appointmentRoom, forKey: .appointmentRoom)
        try container.encode(pmsRoom, forKey: .pmsRoom)
    }
}

extension EUActivity {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        trtDescription = try values.decodeIfPresent(String.self, forKey: .trtDescription)
        trtDuration = try values.decodeIfPresent(Int.self, forKey: .trtDuration)
        trtPrice = try values.decodeIfPresent(Decimal.self, forKey: .trtPrice)
        discountPrcnt = try values.decodeIfPresent(Decimal.self, forKey: .discountPrcnt)
        discountValue = try values.decodeIfPresent(Decimal.self, forKey: .discountValue)
        appointmentDate = try values.decodeIfPresent(String.self, forKey: .appointmentDate)
        appointmentStartTime = try values.decodeIfPresent(String.self, forKey: .appointmentStartTime)
        appointmentEndTime = try values.decodeIfPresent(String.self, forKey: .appointmentEndTime)
        appointmentTherapist = try values.decodeIfPresent(String.self, forKey: .appointmentTherapist)
        appointmentRoom = try values.decodeIfPresent(String.self, forKey: .appointmentRoom)
        pmsRoom = try values.decodeIfPresent(String.self, forKey: .pmsRoom)
        prodDescr = try values.decodeIfPresent(String.self, forKey: .prodDescr)
    }
}
