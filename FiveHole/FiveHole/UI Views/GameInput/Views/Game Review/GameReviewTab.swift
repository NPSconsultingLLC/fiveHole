//
//  GameReviewTab.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 12/6/20.
//

import SwiftUI

struct GameReviewTab: View {
    @FetchRequest(
        entity: Game.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Game.gameDate, ascending: true)
        ]
    ) var games: FetchedResults<Game>
    
    var body: some View {
        List {
            ForEach(games, id: \.opponent) {
                gameCell(game: $0)
            }
        }
    }
}

struct gameCell: View {
    let game: Game
    
    var body: some View {
        game.opponent.map(Text.init)
    }
}

//struct GameReviewTab_Previews: PreviewProvider {
//    @FetchRequest(
//        entity: Game.entity(),
//        sortDescriptors: [
//            NSSortDescriptor(keyPath: \Game.gameDate, ascending: true)
//        ]
//    ) var games: FetchedResults<Game>
//    static var previews: some View {
//        GameReviewTab(games: Game)
//    }
//}
