//
//  ImageListView.swift
//  MilestoneProject13-15
//
//  Created by Константин Шутов on 24.09.2023.
//

import SwiftUI

struct ImageListView: View {
    @ObservedObject var imageLoader: ImageLoader

    var body: some View {
        List(imageLoader.images) { image in
            NavigationLink(destination: DetailView(image: image)) {
                Text(image.name)
            }
        }
    }
}
