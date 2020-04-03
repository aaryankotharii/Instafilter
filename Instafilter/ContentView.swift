//
//  ContentView.swift
//  Instafilter
//
//  Created by Aaryan Kothari on 03/04/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import SwiftUI

struct ContentView2: View {
    @State private var blurAmouunt : CGFloat = 0 {
        didSet{
            print(blurAmouunt)
        }
    }
    var body: some View {
        VStack {
            Text("Hello, World!")
                .blur(radius: blurAmouunt)
            Slider(value: $blurAmouunt, in: 0...20)
        }
    }
}

struct ContentView : View{
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white
    var body : some View {
        Text("Hello, world!")
        .frame(width: 300, height: 300)
        .background(backgroundColor)
            .onTapGesture {
                self.showingActionSheet = true
        }.actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("Change Background"), message: Text("Select new colour"), buttons: [
                .default(Text("Red")){ self.backgroundColor = .red },
                .default(Text("Green")){ self.backgroundColor = .green },
                .default(Text("Blue")){ self.backgroundColor = .blue },
                .default(Text("yelllow")){ self.backgroundColor = .yellow },
                .cancel()
            ])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
