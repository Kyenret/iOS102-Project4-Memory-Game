//
//  ContentView.swift
//  Memory Game
//
//  Created by Kyenret Yakubu Ayuba on 3/22/24.
//

import SwiftUI

struct ContentView: View {
    @State private var cards: [Card] = Card.mockedCards
    
    @State private var selectedIndices: [Int] = [] // Store indices of tapped cards
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3) // Define grid columns
    
    var body: some View {
        VStack{
            //Reset button
            Button(action: {
                resetGame()
            }) {
                Text("Reset")
            }
            .padding(.trailing, 70) // Add padding to the right
            
        }
        // Grid of cards
        LazyVGrid(columns: columns, spacing: 10) { // Use LazyVGrid for vertical layout
            ForEach(cards.indices, id: \.self) { index in
                CardView(card: cards[index], onTap: {
                    if selectedIndices.count < 2 { // Allow only two selections at a time
                        selectCard(at: index)
                    }
                })
                .padding(10) // Add padding for spacing between cards
                //.opacity(selectedIndices.contains(index) ? 0.5 : 1.0) // Dim the card if it's selected
            }
        }
        .padding() // Add padding to the grid
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    // Function to select a card
    private func selectCard(at index: Int) {
            if selectedIndices.contains(index) || cards[index].isMatched {
                return // Ignore if the card is already selected or matched
            }
            
            selectedIndices.append(index)
            
            if selectedIndices.count == 2 {
                checkForMatch()
            }
        }
        
        // Function to check for a match
    private func checkForMatch() {
            //var myCards = cards
            let firstIndex = selectedIndices[0]
            let secondIndex = selectedIndices[1]

            if cards[firstIndex].emoji == cards[secondIndex].emoji {
                // Mark cards as matched
                cards[firstIndex].isMatched = true
                cards[secondIndex].isMatched = true
            }

            //cards = myCards
            // Clear selected indices
            selectedIndices.removeAll()
        }
    // Function to reset the game
    private func resetGame() {
        var myCards = cards
            // Reset game-related state
            myCards.shuffle()
            selectedIndices.removeAll()
            for i in myCards.indices {
                myCards[i].isMatched = false
                myCards[i].isFaceDown = true
            }
        cards = myCards
        }
    }

#Preview {
    ContentView()
}
