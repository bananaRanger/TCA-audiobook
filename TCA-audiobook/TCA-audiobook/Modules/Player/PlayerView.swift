//
//  PlayerView.swift
//  TCA-audiobook
//
//  Created by Anton Yereshchenko on 23.12.2023.
//

import SwiftUI
import ComposableArchitecture

struct PlayerView: View {
    let store: StoreOf<Player>

    init(store: StoreOf<Player>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            contentView
                .frame(maxHeight: .infinity)
                .padding(.horizontal)
                .background(Color.brandPrimaryBackgorund)
                .gesture(
                    SpatialTapGesture(count: 2, coordinateSpace: .global)
                        .onEnded({ value in
                            ScreenTapHandler.handleTap(
                                in: value.location) { location in
                                    switch location {
                                    case .topLeft: viewStore.send(.moveBackword)
                                    case .topRight: viewStore.send(.moveForward)
                                    default: break
                                    }
                                }
                        })
                )
                .onAppear {
                    viewStore.send(.onAppear)
                }
        }
    }
}

private extension PlayerView {
    var contentView: some View {
        ZStack {
            mainView
            segmentControllerView
        }
    }
    
    var mainView: some View {
        VStack(spacing: 36) {
            
            coverImageView

            VStack(spacing: 16) {
                VStack(spacing: 10) {
                    currentPartLabel
                    shortDescriptionLabel
                }
                seekerView
                speedButton
            }
            
            actionsBarView
            
            Spacer()
        }
    }
    
    var segmentControllerView: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                Spacer()
                
                ImageSegmentedControl(
                    preselectedIndex: Binding(
                        get: { viewStore.selectedSegment },
                        set: { store.send(.onSegmentValueChange($0)) }
                    ),
                    images: [
                        Image(systemName: "headphones"),
                        Image(systemName: "list.bullet.indent")]
                )
            }
        }
    }
    
    var coverImageView: some View {
        Image("BookCoverImage" )
            .resizable()
            .frame(maxHeight: .infinity)
            .frame(height: 320)
            .aspectRatio(1.1, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .foregroundColor(Color.brandTint)
    }
    
    var currentPartLabel: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Text("KEY POINT \(viewStore.currentIndex) OF \(viewStore.audioBookItems.count)")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color.brandSecondaryText)
        }
    }
        
    var shortDescriptionLabel: some View {
        Text("Design is not how a thing looks, but how it works")
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .font(.system(size: 16))
            .foregroundStyle(Color.brandPrimaryText)
    }
    
    var seekerView: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            HStack(spacing: .zero) {
                Text(viewStore.currentTime.pretty)
                    .font(.system(size: 12))
                    .foregroundStyle(Color.brandSecondaryText)
                    .frame(width: 46)
                
                SwiftUISlider(
                    value: 
                        Binding(
                            get: { viewStore.progress },
                            set: { store.send(.onSliderValueChange($0)) }
                        )
                )
                
                Text(viewStore.duration.pretty)
                    .font(.system(size: 12))
                    .foregroundStyle(Color.brandSecondaryText)
                    .frame(width: 46)
            }
        }
    }
    
    var speedButton: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Button {
                viewStore.send(.changeSpeed, animation: nil)
            } label: {
                Text("Speed x\(String.numberFormat(viewStore.speed.rawValue))")
                    .foregroundStyle(Color.brandPrimaryText)
                    .font(.system(size: 14, weight: .semibold))
                    .padding(10)
                    .background(Color.brandSecondaryBackgorund)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            }
        }
    }
    
    var actionsBarView: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            HStack(spacing: 28) {
                ActionButton(systemName: "backward.end.fill") {
                    viewStore.send(.perevious)
                }
                ActionButton(systemName: "gobackward.5") {
                    viewStore.send(.moveBackword)
                }
                Group {
                    if viewStore.isPlaying {
                        ActionButton(systemName: "pause.fill") {
                            viewStore.send(.pause)
                        }
                    } else {
                        ActionButton(systemName: "play.fill") {
                            viewStore.send(.play)
                        }
                    }
                }
                ActionButton(systemName: "goforward.10") {
                    viewStore.send(.moveForward)
                }
                ActionButton(systemName: "forward.end.fill") {
                    viewStore.send(.next)
                }
            }
            .frame(height: 36)
        }
    }
}

#Preview {
    let store = Store(initialState: Player.State()) {
        Player()._printChanges()
    }
    
    return PlayerView(store: store)
}
