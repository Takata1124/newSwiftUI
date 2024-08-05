//
//  ContentView.swift
//  newSwiftUI
//
//  Created by t032fj on 2024/08/06.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedIndex = 0
    @State var inputName = ""
    let buttonText = "OK"
    
    let data: [CustomCell] = [
        CustomCell(name: "山田", age: "24"),
        CustomCell(name: "小島", age: "83"),
        CustomCell(name: "岡部", age: "39"),
        CustomCell(name: "山田", age: "24"),
        CustomCell(name: "小島", age: "83"),
        CustomCell(name: "岡部", age: "39"),
        CustomCell(name: "山田", age: "24"),
        CustomCell(name: "小島", age: "83"),
        CustomCell(name: "岡部", age: "39")
    ]
    
    init() {
        if #available(iOS 15, *) {
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
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                HStack {
                    TextField("テキストを入力してください", text: $inputName)
                    Button(action: {
                        print("tapped")
                    }){
                        Text(buttonText)
                            .font(.headline)
                    }
                }
                .padding(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.black, lineWidth: 0.5)
                )
                Picker("", selection: $selectedIndex) {
                       Text("クーポン")
                           .tag(0)
                       Text("おすすめ")
                           .tag(1)
                       Text("進捗")
                           .tag(2)
                   }
                   .pickerStyle(SegmentedPickerStyle())
                   .overlay(
                       RoundedRectangle(cornerRadius: 0)
                           .stroke(Color.black, lineWidth: 0.5)
                   )
                   .onChange(of: selectedIndex) { newValue, oldValue in
                       print(newValue)
                       print(oldValue)
                   }
                List {
                    ForEach(data) { data in
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
                .scrollDisabled(true)
            }
            .navigationTitle("NavigationView")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
