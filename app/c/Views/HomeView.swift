//
//  HomeView.swift
//  c
//
//  Created by Dev Prajapati on 19/01/2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var matches: [Game]

    var body: some View {
            NavigationSplitView {
                // Check if matches are empty outside of List
                if matches.isEmpty {
                    VStack {
                        Text("No saved games yet.")
                            .padding()
                    }
                    .toolbar {
                        ToolbarItem {
                            Button(action: addItem) {
                                Label("Add Item", systemImage: "plus")
                            }
                        }
                    }
                } else {
                    List {
                        ForEach(matches) { item in
                            NavigationLink {
                                GameView(game: item)
                            } label: {
                                Text("Game on \(item.name)")
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .navigationTitle("Recent Games")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            EditButton()
                        }
                        ToolbarItem {
                            Button(action: addItem) {
                                Label("Add Item", systemImage: "plus")
                            }
                        }
                        ToolbarItem{
                            Button(action: shareButton)
                            {
                                Image(systemName: "square.and.arrow.up")
                                    
                            }
                        }
                    }
                }
            } detail: {
                Text("Select an item")
            }
        }

    private func addItem() {
        withAnimation {
            let newMatch = Game(timestamp: Date(), name: Date.FormatStyle(date: .abbreviated, time: .standard).format(.now))
            modelContext.insert(newMatch)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(matches[index])
            }
        }
    }
    
    func shareButton() {
            let url = URL(string: "https://www.praj.co.uk/")
            let activityController = UIActivityViewController(activityItems: [url!], applicationActivities: nil)

            UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
    }
}

#Preview {
    HomeView()
        .modelContainer(for: Game.self, inMemory: true)
}
