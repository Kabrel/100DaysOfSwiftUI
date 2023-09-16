//
//  DetailView.swift
//  Bookworm
//
//  Created by Константин Шутов on 16.09.2023.
//

import SwiftUI

struct DetailView: View {
    let book : Book
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5,y: -5)
            }
            Text(book.author ?? "Unkown Author")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(book.review ?? "No review")
                .padding()
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
        }
        .navigationTitle(book.title ?? "Unkown Book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book",isPresented: $showingDeleteAlert) {
            Button("Delete",role: .destructive,action: deleteBook)
            Button("Cancel",role: .cancel){}
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button{
                showingDeleteAlert = true
            } label: {
                Label("Delete this book",systemImage: "trash")
            }
        }
    }
    func deleteBook() {
        moc.delete(book)
        //
        dismiss()
    }
}
