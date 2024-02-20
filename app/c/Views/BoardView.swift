//
//  BoardView.swift
//  c
//
//  Created by Dev Prajapati on 19/02/2024.
//

import SwiftUI

struct BoardView: View {
    
    @ObservedObject var chessEngine = ChessEngine()

        private let files = ["a", "b", "c", "d", "e", "f", "g", "h"]
        private let ranks = Array(1...8).reversed()

        var body: some View {
            GeometryReader { geometry in
                let squareSize = geometry.size.width / 8
                let pieceSize = squareSize * 0.75
                VStack(spacing: 0) {
                    ForEach(0..<8, id: \.self) { row in
                        HStack(spacing: 0) {
                            ForEach(0..<8, id: \.self) { col in
                                ZStack {
                                    Rectangle()
                                        .fill((row + col) % 2 == 0 ? Color.yellow : Color.gray)
                                    if chessEngine.pieceImageAt(col: col, row: row) != "empty"{
                                        
                                        Image(chessEngine.pieceImageAt(col: col, row: row))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: pieceSize, height: pieceSize)
                                        
                                    }
                                    if col == 0 {
                                        Text("\(8 - row)")
                                            .foregroundColor((row + col) % 2 == 0 ? Color.black : Color.white)
                                            .position(x: squareSize * 0.14, y: squareSize * 0.17)
                                            .font(.system(size: 13, weight: .bold))
                                    }
                                    if row == 7 {
                                        Text("\(files[col])")
                                            .foregroundColor((row + col) % 2 == 0 ? Color.black : Color.white)
                                            .position(x: squareSize * 0.89, y: squareSize * 0.84)
                                            .font(.system(size: 13, weight: .bold))
                                    }
                                }
                                .frame(width: squareSize, height: squareSize)
                            }
                        }
                    }
                }
            }
            .padding()
            .onAppear {
                chessEngine.initializeGame()
            }
            .environment(\.sizeCategory, .large)
        }
    }

#Preview {
    BoardView()
}
