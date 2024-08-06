//
//  ContentView.swift
//  newSwiftUI
//
//  Created by t032fj on 2024/08/06.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedIndex = 0
    @State var inputText = ""
    @State var isLoading : Bool = false
    @ObservedObject var contentViewModel = ContentViewModel()
    
    init() {
        setupLayout()
    }
    
    private func setupLayout() {
        if #available(iOS 16, *) {
            let coloredNavAppearance = UINavigationBarAppearance()
            coloredNavAppearance.configureWithOpaqueBackground()
            coloredNavAppearance.backgroundColor = UIColor.init(red: 41/255, green: 199/255, blue: 50/255, alpha: 0.75)
            UINavigationBar.appearance().standardAppearance = coloredNavAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
            var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
            configuration.headerMode = .supplementary
            configuration.headerTopPadding = 0
            let layout = UICollectionViewCompositionalLayout.list(using: configuration)
            UICollectionView.appearance().collectionViewLayout = layout
            UICollectionView.appearance().bounces = false
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .center, spacing: 0) {
                    Text("検索結果：\(contentViewModel.text)")
                        .padding(5)
                    HStack {
                        TextField("テキストを入力してください", text: $inputText)
                        Button(action: {
                            if contentViewModel.customCells.count > 0 {
                                contentViewModel.clear()
                            } else {
                                Task {
                                    isLoading = true
                                    try? await contentViewModel.search()
                                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                                    isLoading = false
                                }
                            }
                            print("tapped")
                        }){
                            Group {
                                if contentViewModel.customCells.count > 0 {
                                    Text("Clear")
                                } else {
                                    Text("Search")
                                }
                            }
                            .font(.headline)
                        }
                    }
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.black, lineWidth: 0.5)
                    )
                    Picker("", selection: $selectedIndex) {
                        Text("クーポン").tag(0)
                        Text("おすすめ").tag(1)
                        Text("進捗").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.black, lineWidth: 0.5)
                    )
                    .onChange(of: selectedIndex) { oldValue, newValue in
                        print(newValue)
                        
                    }
                    List {
                        ForEach(contentViewModel.customCells) { data in
                            Section {
                                Text("\(data.name)")
                                    .padding(15)
                            }
                            .frame(height: 75)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                print("tap")
                            }
                        }
                        .listRowInsets(EdgeInsets())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.black, lineWidth: 0.5)
                        )
                    }
                }
                .navigationTitle("NavigationView")
                .navigationBarTitleDisplayMode(.inline)
                if isLoading {
                    ActivityIndicatorView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
