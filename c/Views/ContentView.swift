//
//  ContentView.swift
//  c
//
//  Created by Dev Prajapati on 19/01/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var matches: [Game]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(matches) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text("Game on \(item.name)") //, format: Date.FormatStyle(date: .numeric, time: .standard))
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
    ContentView()
        .modelContainer(for: Game.self, inMemory: true)
}
