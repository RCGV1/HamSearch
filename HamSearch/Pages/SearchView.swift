//
//  SearchView.swift
//  HamSearch
//
//  Created by Benjamin Faershtein on 2/4/24.
//

import SwiftUI
import MapKit

struct SearchView: View {
    
    @State var searchText: String = ""
    @State var isSearchCompleted = 1
    @State var apiError = false
    @State var loading = false
    @State var noResults = false
    
    
    @State var license: License?
    
    
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationStack{
            

            
            HStack{
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.gray)
                
                TextField("", text: $searchText,prompt: Text("Search a Ham callsign").foregroundColor(colorScheme == .dark ? .black : .gray))
                    .foregroundStyle(.black)
                    .onChange(of: searchText, { oldValue, newValue in
                        apiError = false
                        noResults = false
                    })
                    .autocorrectionDisabled(true)
                    .submitLabel(.search)
                    .onSubmit {
                        isSearchCompleted = 2
                        apiError = false
                        noResults = false
                        let jsonString = searchCallSign(CallSign: searchText)
                        if jsonString == "Error" {
                            license = nil
                            apiError = true
                            isSearchCompleted = 3
                        } else {
                            if let jsonData = jsonString.data(using: .utf8) {
                                do {
                                    let decoder = JSONDecoder()
                                    license = try decoder.decode(License.self, from: jsonData)
                                    isSearchCompleted = 3
                                } catch {
                                    license = nil
                                    noResults = true
                                    print("Error decoding JSON: \(error)")
                                    isSearchCompleted = 3
                                }
                            } else {
                                license = nil
                                apiError = true
                                print("Failed to convert JSON string to data")
                                isSearchCompleted = 3
                            }
                        }
                    }

                
                    .overlay(
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .padding()
                            .foregroundColor(.accentColor)
                            .opacity(searchText.isEmpty ? 0.0 : 1.0)
                            .onTapGesture {
                                license = nil
                                searchText = ""
                            }
                            ,alignment: .trailing
                    )
            }
            
            .font(.headline)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.white)
                    .shadow(
                        color: (searchText.isEmpty ? Color.gray : Color.black),
                        radius: 10, x: 0, y: 0
                    )
                
                
            )
            .padding()
            Spacer()
            if (isSearchCompleted == 2){
                ProgressView()
                    .scaleEffect(3)
                    
            }
            if (license != nil){
                LicenseView(license: license!)
            }
            if (apiError){
                VStack{
                    Image(systemName: "wifi.exclamationmark")
                    Text("API Error")
                }
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
            }
            if (noResults){
                ContentUnavailableView {
                    Label("No results", systemImage: "person.crop.circle.badge.exclamationmark")
                } description: {
                    Text("Enter a valid US callsign.")
                }
            }
            Spacer()
            VStack{
                Text("Developed by Benjamin Faershtein")
                Text("Powered by CALLOOK")
            }
            .padding(.bottom)
            .font(.footnote)
            .foregroundColor(.gray)
        }
    }
    
}


#Preview {
    SearchView()
}

