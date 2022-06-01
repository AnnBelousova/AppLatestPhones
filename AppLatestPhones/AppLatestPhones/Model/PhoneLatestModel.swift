//
//  PhoneLatestModel.swift
//  AppLatestPhones
//
//  Created by user214004 on 4/15/22.
//

import Foundation


struct phonesCollection : Codable {
    var data : arrPhones
}


struct arrPhones: Codable {
    var phones: [phones]
}

struct phones : Codable {
    var phone_name : String
    var slug : String
    var image : String
}
