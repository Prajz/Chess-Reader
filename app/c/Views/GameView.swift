//
//  GameView.swift
//  c
//
//  Created by Dev Prajapati on 19/02/2024.
//

import SwiftUI

struct GameView: View {
    
    let game: Game
    var body: some View {
        
        VStack{
            BoardView()
                .frame(maxHeight: 400)

            Text("Moves")
                .multilineTextAlignment(.leading)
                .bold()
                .font(.title)
            Text("1. d4 Nf6 2. Nd2 e5 3. Dxe5 Ng6 4. h3 Ne6 5. fxe3 Qh4+ 6. g3 Qxg3# 0-1")
                .font(.body)
                .padding()
            
            Spacer()
            Spacer()
            Text("Game from \(game.name)" )
            
            
        }
        .navigationTitle("Game details")
    }

}

//for the preview
let new = Game(timestamp: Date(), name: Date.FormatStyle(date: .abbreviated, time: .standard).format(.now))

#Preview {
    GameView(game: new)
}
