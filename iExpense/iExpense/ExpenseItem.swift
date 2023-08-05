//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Константин Шутов on 03.08.2023.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
