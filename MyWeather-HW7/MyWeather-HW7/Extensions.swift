//
//  Extensions.swift
//  MyWeather-HW7
//
//  Created by Ivy Angelova (Apprentice Mobile, eDynamix Training Programme) on 16/01/2023.
//

import Foundation

extension JSONDecoder {
    class var snakeCaseDecoder: JSONDecoder{
        let snakeCaseDecoder = JSONDecoder()
        snakeCaseDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return snakeCaseDecoder
    }
}
