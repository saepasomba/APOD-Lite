//
//  ContentView.swift
//  APOD-Lite
//
//  Created by Sae Pasomba on 30/04/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var apiManager = ApiManager()
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        print("Hello")
                    } label: {
                        Text("Custom date?")
                            .padding()
                            .background(
                                .regularMaterial
                            )
                            .cornerRadius(25)
                    }

                }
            }
            .padding()
            
            ScrollView {
                VStack {
                    AsyncImage(url: URL(string: apiManager.apod?.hdurl ?? "")) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Color.gray
                            .frame(minHeight: 300)
                    }
                    .frame(maxWidth: .infinity)
                    VStack(alignment: .leading) {
                        Text("\(apiManager.apod?.title ?? "Unknown")")
                            .font(.title)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack {
                            Text("\(apiManager.apod?.copyright ?? "Unknown")")
                                .fontWeight(.semibold)
                            Spacer()
                            Text("\(apiManager.apod?.date ?? "YYYY-MM-DD")")
                        }
                        .font(.title3)
                        .foregroundColor(.secondary)
                        
                    }
                    .padding()
                }
                .background(.regularMaterial)
                .cornerRadius(25)
                .shadow(color: Color(UIColor.label), radius: 2)
                .padding()
                VStack {
                    Text("Explanation")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text("\(apiManager.apod?.explanation ?? "Unknown")")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            .onAppear {
                apiManager.fetchData()
        }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
