//
//  Users.swift
//  TestApplicationWithPosts
//
//  Created by macbook on 02.10.2023.
//

import Foundation
import RealmSwift

class UserRealm: Object, Decodable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var username: String
    @Persisted var email: String
    @Persisted var address: AddressRealm?
    @Persisted var phone: String
    @Persisted var website: String
    @Persisted var company: CompanyRealm?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case email
        case address
        case phone
        case website
        case company
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        username = try container.decode(String.self, forKey: .username)
        email = try container.decode(String.self, forKey: .email)
        phone = try container.decode(String.self, forKey: .phone)
        website = try container.decode(String.self, forKey: .website)
        company = try container.decode(CompanyRealm.self, forKey: .company)
        address = try container.decode(AddressRealm.self, forKey: .address)
    }
}

    
class CompanyRealm: Object, Decodable {
    @Persisted var name: String
    @Persisted var catchPhrase: String
    @Persisted var bs: String

    enum CodingKeys: String, CodingKey {
        case name
        case catchPhrase
        case bs
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        catchPhrase = try container.decode(String.self, forKey: .catchPhrase)
        bs = try container.decode(String.self, forKey: .bs)
    }
}


class AddressRealm: Object, Decodable {
    @Persisted var street: String
    @Persisted var suite: String
    @Persisted var city: String
    @Persisted var zipcode: String
    @Persisted var geo: GeoRealm?

    enum CodingKeys: String, CodingKey {
        case street
        case suite
        case city
        case zipcode
        case geo
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        street = try container.decode(String.self, forKey: .street)
        suite = try container.decode(String.self, forKey: .suite)
        city = try container.decode(String.self, forKey: .city)
        zipcode = try container.decode(String.self, forKey: .zipcode)
        geo = try container.decode(GeoRealm.self, forKey: .geo)
    }
}

class GeoRealm: Object, Decodable {
    @Persisted var lat: String
    @Persisted var lng: String

    enum CodingKeys: String, CodingKey {
        case lat
        case lng
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        lat = try container.decode(String.self, forKey: .lat)
        lng = try container.decode(String.self, forKey: .lng)
    }
}

