//
//  LastEvents.swift
//  SportsApp
//
//  Created by Esraa on 21/04/2021.
//

import Foundation

struct LastEvents: Codable {
    let status: String
    let data: [DatumLastEvents]
    let message: String
}

// MARK: - Datum
struct DatumLastEvents: Codable {
    let id: Int
    let employeeName: String
    let employeeSalary, employeeAge: Int
    let profileImage: String

    enum CodingKeys: String, CodingKey {
        case id
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case employeeAge = "employee_age"
        case profileImage = "profile_image"
    }
}
