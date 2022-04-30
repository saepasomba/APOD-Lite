//
//  ContentView.swift
//  APOD-Lite
//
//  Created by Sae Pasomba on 30/04/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var apiManager = ApiManager()
    @State var isPresenting: Bool = false
    @State var date: Date = Date()
    
    var body: some View {
        ZStack {
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
                .shadow(color: Color(UIColor.label), radius: 1)
                .padding()
                VStack {
                    Text("Explanation")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.bottom)
                    Text("\(apiManager.apod?.explanation ?? "Unknown")")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            .onAppear {
                apiManager.fetchData()
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        withAnimation {
                            isPresenting.toggle()
                        }
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
        }
        .overlay(
            Group {
                if isPresenting {
                    ZStack {
                        Color.black
                            .opacity(0.9)
                            .ignoresSafeArea()
                        VStack {
                            DatePicker(
                                "What date?",
                                selection: $date,
                                displayedComponents: [.date]
                            )
                            .padding()
                            HStack {
                                Spacer()
                                Button {
                                    withAnimation {
                                        isPresenting.toggle()
                                    }
                                } label: {
                                    Text("Cancel")
                                        .padding()
                                        .background(
                                            .regularMaterial
                                        )
                                        .cornerRadius(25)
                                }
                                Button {
                                    withAnimation {
                                        isPresenting.toggle()
                                        apiManager.fetchData(date: date)
                                    }
                                } label: {
                                    Text("Custom")
                                        .padding()
                                        .background(
                                            .regularMaterial
                                        )
                                        .cornerRadius(25)
                                        .foregroundColor(.green)
                                }

                            }
                        }
                        .padding()
                        .background {
                            Color(UIColor.systemBackground)
                        }
                        .cornerRadius(25)
                    }
                }
            }
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
