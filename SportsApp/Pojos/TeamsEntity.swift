//
//  LegueModel.swift
//  sportsApp
//
//  Created by Nermeen on 4/21/21.
//  Copyright © 2021 Nermeen. All rights reserved.
//

import Foundation
struct TeamsEntity : Codable {
	let teams : [Teams]?

	enum CodingKeys: String, CodingKey {

		case teams = "teams"
	}
}
