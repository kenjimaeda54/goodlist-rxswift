//
//  Task.swift
//  GoodList
//
//  Created by kenjimaeda on 21/10/22.
//

import Foundation

enum Priority: Int {
	case high
	case medium
	case low
}

struct Task {
	var title: String
	var priority: Priority
}
