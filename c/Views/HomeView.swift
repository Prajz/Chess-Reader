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
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
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
                                Text("Game on \(item.name)")
                            } label: {
                                Text("Game on \(item.name)")
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                        ToolbarItem {
                            Button(action: addItem) {
                                Label("Add Item", systemImage: "plus")
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
}

#Preview {
    HomeView()
        .modelContainer(for: Game.self, inMemory: true)
}
