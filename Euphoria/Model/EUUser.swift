//
//  EUUser.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 5/5/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

struct EUUser: Codable {
    var firstName: String?
    var lastName: String?
    var address: String?
    var town: String?
    var country: String?
    var zipcode: String?
    var email: String?
    var phone: String?
    var customerId: Int?
    
    //Custom Keys
    enum CodingKeys: String, CodingKey {
        case firstName = "CustomerName"
        case lastName = "CustomerSurname"
        case address = "Address"
        case town = "Town"
        case country = "Country"
        case zipcode = "ZipCode"
        case email = "Email"
        case phone = "Phone"
        case customerId = "CustomerId"
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encoded, forKey: USER_PROFILE_DATA)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var user: EUUser? {
        if let data = UserDefaults.standard.object(forKey: USER_PROFILE_DATA) as? Data {
            if let user = try? JSONDecoder().decode(EUUser.self, from: data) {
                return user
            }
        }
        return nil
    }
}

extension EUUser {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(address, forKey: .address)
        try container.encode(town, forKey: .town)
        try container.encode(country, forKey: .country)
        try container.encode(zipcode, forKey: .zipcode)
        try container.encode(email, forKey: .email)
        try container.encode(phone, forKey: .phone)
        try container.encode(customerId, forKey: .customerId)
    }
}

extension EUUser {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        town = try values.decodeIfPresent(String.self, forKey: .town)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        zipcode = try values.decodeIfPresent(String.self, forKey: .zipcode)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        customerId = try values.decodeIfPresent(Int.self, forKey: .customerId)
    }
}
