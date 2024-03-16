//
//  SavedView.swift
//  HamSearch
//
//  Created by Benjamin Faershtein on 2/4/24.
//

import SwiftUI
import SwiftData

struct SavedView: View {
    @Environment(\.modelContext) private var context
    @Query private var savedLicenses:[DataItem]
    var body: some View {
        NavigationStack{
            if (savedLicenses.count  == 0){
                ContentUnavailableView {
                    Label("No Saved Callsigns", systemImage: "bookmark.circle")
                } description: {
                    Text("Saved callsigns will appear here.")
                }

            }
            List{
                ForEach(savedLicenses){ item in
                    NavigationLink {
                        LicenseView(license: item.license)
                    } label: {
                        Text(item.license.current.callsign)
                    }
                    
                } .onDelete(perform: { indexes in
                    for index in indexes {
                        context.delete(savedLicenses[index])
                    }
                })
            }
            .navigationTitle("Saved Callsigns")
           
            
        }
    }
    
}

#Preview {
    SavedView()
}
