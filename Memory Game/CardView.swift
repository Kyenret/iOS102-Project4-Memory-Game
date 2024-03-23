//
//  CardView.swift
//  Memory Game
//
//  Created by Kyenret Yakubu Ayuba on 3/22/24.
//

import SwiftUI

struct CardView: View {
    @State var card: Card
    let onTap: () -> Void // Add onTap closure
    //let onTap: () -> Void // Add onTap closure
    @State private var isFaceDown = true //initial state is face down
    var body: some View {
        ZStack {
            // Card background
            RoundedRectangle(cornerRadius: 25.0)
                .fill(isFaceDown ? Color.blue : .white) // Use gray color for facedown cards .indigo)
                .shadow(color: .black, radius: 4, x: -2, y: 2)
            if isFaceDown {
                // Display a blank card if face-down
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color.blue)
            } else {
                // Display emoji when card is flipped
                Text(card.emoji)
                    .font(.largeTitle)
            }
//            VStack(spacing: 20) {
//                // Card type (question vs answer)
//                Text(isShowingQuestion ? "Question" : "Answer")
//                    .bold()
//                // Separator
//                Rectangle()
//                    .frame(height: 1)
//                // Card text
//                Text(isShowingQuestion ? card.question : card.answer)
//            }
//            .font(.title)
//            .foregroundStyle(.white)
//            .padding()
        }
        .frame(width: 100, height: 150)
        .opacity(card.isMatched ? 0 : 1.0) // Dim the card if it's selected
        .onTapGesture {
            onTap() //notifying when a specific card has been tapped
            flipCard()
        }
    }
    // Function to flip the card
    private func flipCard() {
        isFaceDown.toggle()
    }
}
// Card data model
struct Card: Equatable {
    let emoji: String
    var isMatched: Bool = false // Add isMatched property
    var isFaceDown: Bool = true // Add isFaceDown  property
    
    static let mockedCards = [
        Card(emoji: "😂"),
        Card(emoji: "🥺"),
        Card(emoji: "😘"),
        Card(emoji: "😞"),
        Card(emoji: "😬"),
        Card(emoji: "😊"),
        Card(emoji: "😂"),
        Card(emoji: "🥺"),
        Card(emoji: "😘"),
        Card(emoji: "😞"),
        Card(emoji: "😬"),
        Card(emoji: "😊")
        ]
}

//Preview {
struct CardViewPreview: PreviewProvider {
    static var previews: some View {
        let card = Card(emoji: "😊") // Create a sample card
        return CardView(card: card, onTap: {}) // Return the CardView with the sample card
    }
}
