//
//  MainView.swift
//  HamSearch
//
//  Created by Benjamin Faershtein on 2/4/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        
        TabView{
            SearchView()
            .tabItem {
                Label("Search", systemImage: "house")

            }
            SavedView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")

                }
           
        }
       
    }
}

#Preview {
    MainView()
}
