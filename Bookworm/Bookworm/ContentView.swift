//
//  ContentView.swift
//  Bookworm
//
//  Created by Константин Шутов on 16.09.2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors:[
        SortDescriptor(\.title),
        SortDescriptor(\.author),
        SortDescriptor(\.date)
    ]) var books : FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink(destination: DetailView(book: book)) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unkown Title")
                                    .font(.headline)
                                    .foregroundColor(book.rating == 1 ? .red : .primary)
                                
                                Text(book.author ?? "Unkown Author")
                                    .foregroundColor(.secondary)
                                
                                if let date = book.date {
                                    Text(dateFormatter.string(from: date))
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddScreen.toggle()
                    }) {
                        Label("Add Book", systemImage: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddScreen) {
            AddBookView()
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
