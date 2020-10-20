//
//  HomeView.swift
//  JananeseMarriage
//
//  Created by saki iwamoto on 2020/10/21.
//

import SwiftUI

struct HomeView: View {
    @State var animals: [String] = ["🐶", "🐱", "🐊"]
    
    @State private var isPresented = false
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(animals, id: \.self) { animal in
                        HStack {
                            Text(animal)
                                .padding(.all)
                            Spacer()
                        }
                    }
                    Button("入力する") {
                        self.isPresented = true
                    }
                    .sheet(isPresented: $isPresented) {
                        InputPartnerView()
                    }
                    
                    .frame(height: 50)
                }
                .navigationBarTitle(Text("結婚する人"))
            }
            
            Button("結婚する") {
                print("結婚する")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
