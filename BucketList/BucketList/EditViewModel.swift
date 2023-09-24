//
//  EditViewModel.swift
//  BucketList
//
//  Created by Константин Шутов on 24.09.2023.
//

import SwiftUI
class EditViewModel: ObservableObject {
    @Published var name: String
    @Published var description: String

    init(location: Location) {
        self.name = location.name
        self.description = location.description
    }
}
