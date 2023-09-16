//
//  AddBookView.swift
//  Bookworm
//
//  Created by Константин Шутов on 16.09.2023.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    @State private var date = "01.02.2023"
    
    let genres = ["Fantasy","Horror","Kids","Mystery","Poetry","Romance","Triller"]
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name" , text:$author)
                    
                    Picker ("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        
                        }
                    }
                }
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                Section {
                    Button("Save") {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating) 
                        newBook.genre = genre
                        newBook.review = review
                        newBook.date = Date()
                        
                        try? moc.save()
                        dismiss()
                        
                    }
                }
            }
            .navigationTitle("AddBook")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
