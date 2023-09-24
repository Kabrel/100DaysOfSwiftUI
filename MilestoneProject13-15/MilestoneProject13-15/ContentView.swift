//
//  ContentView.swift
//  MilestoneProject13-15
//
//  Created by Константин Шутов on 24.09.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var imageLoader = ImageLoader()

    var body: some View {
        NavigationView {
            ImageListView(imageLoader: imageLoader)
                .navigationTitle("Image List")
                .onAppear {
                    imageLoader.loadImages()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
