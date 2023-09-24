//
//  DetailView.swift
//  MilestoneProject13-15
//
//  Created by Константин Шутов on 24.09.2023.
//

import SwiftUI

struct DetailView: View {
    let image: ImageModel

    var body: some View {
        VStack {
            image.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()

            Text(image.name)
                .font(.title)
                .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
