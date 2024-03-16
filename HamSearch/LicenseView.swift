//
//  LiscenseView.swift
//  HamSearch
//
//  Created by Benjamin Faershtein on 2/4/24.
//

import SwiftUI
import _MapKit_SwiftUI
import SwiftData

struct LicenseView: View {
    @Environment(\.modelContext) private var context
    @Query private var savedLicenses:[DataItem]


    @State var license: License
    
    @State var camera: MapCameraPosition = .automatic
    
    



    var body: some View {
           
            List{
                Section(header: Text("Status")){
                    Text(license.status)
                }
                
                Section(header: Text("Name")) {
                    Text(license.name)
                }
                if(license.current.callsign != ""){
                    Section(header: Text("CallSign")) {
                        Text(license.current.callsign)
                        if(license.current.operClass != ""){
                            Text(license.current.operClass)
                        }
                        if (!doesAlreadyExist(license: license)){
                            Button(action: {
                                
                                let item = DataItem(license: license)
                                context.insert(item)
                                
                                
                                try! context.save()
                            }) {
                                HStack{
                                    Text("Save")
                                    Spacer()
                                    Image(systemName: "bookmark")
                                }
                            }
                        }
                    }
                }
                if(license.previous.callsign != ""){
                    Section(header: Text("Previus CallSign")) {
                        Text(license.previous.callsign)
                        if(license.previous.operClass != ""){
                            Text(license.previous.operClass)
                        }
                    }
                }
                if(license.location.latitude != ""){
                    
                    Section(header: Text("Location")) {
                        Text(license.address.line1)
                        Text(license.address.line2)
                        Text("lat "+license.location.latitude+", long "+license.location.longitude)
                        Text("GridSquare "+license.location.gridsquare)
                        let licensePin = CLLocationCoordinate2D(latitude: Double(license.location.latitude) ?? 0,
                                                                longitude: Double(license.location.longitude) ?? 0)
                        
                        NavigationLink {
                            NavigationStack{
                                Map(position: $camera){
                                    Marker(license.current.callsign, systemImage: "person.fill",coordinate: licensePin)
                                }
                            }
                            .navigationTitle("Map")
                        } label: {
                            Map(position: $camera){
                                Marker(license.current.callsign, systemImage: "person.fill",coordinate: licensePin)
                            }
                        }
                        .frame(height: 200)
                        .cornerRadius(10)
                        
                        
                        
                    }
                    
                    
                }
                
                if(license.otherInfo.frn != ""){
                    Section(header: Text("Other Info")){
                        Text("FRN "+license.otherInfo.frn)
                        Text("Expiry Date "+license.otherInfo.expiryDate)
                        Text("Grant Date "+license.otherInfo.grantDate)
                    }
                }
                
                if (license.trustee.callsign != ""){
                    Section(header: Text("Trustee")){
                        Text(license.trustee.callsign)
                        Text(license.trustee.name)
                    }
                }
                
                Link("More Info",destination: URL(string: license.otherInfo.ulsUrl)!)

                
                
                
                
            }
            .scrollContentBackground(.hidden)
            
    }
       

      
     
    func doesAlreadyExist(license: License) -> Bool {
        for item in savedLicenses {
            if item.license.current.callsign == license.current.callsign {
                print("True")
                return true
            }
        }
        return false
    }
    
        
    
}
  

