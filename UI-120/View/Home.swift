//
//  Home.swift
//  UI-120
//
//  Created by にゃんにゃん丸 on 2021/02/06.
//

import SwiftUI
import SDWebImageSwiftUI

let gra = LinearGradient(gradient: .init(colors: [.green,.pink]), startPoint: .center, endPoint: .leading)
struct Home: View {
    @State var offset : CGFloat = 0
    @State var showCapsule = false
    var body: some View {
        GeometryReader{proxy in
            
            let rect = proxy.frame(in: .global)
            ScrollTabBar(tabs: tabs, rect: rect, offset: $offset) {
                
                HStack(spacing:0){
                    ForEach(images.indices,id:\.self){index in
                        
                        WebImage(url: URL(string: images[index]))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: rect.width)
                            .cornerRadius(0)
                            .overlay(gra.opacity(0.2))
                          
                        
                        
                    }
                }
               
                .ignoresSafeArea()
                
            }
           
            
            
            
        }
        .ignoresSafeArea()
        .overlay(
            
            TabBar(offset: $offset, showCapsule: $showCapsule)
            
            ,alignment: .bottom
        
        )
        
        .overlay(
        
            Button(action: {
                
                withAnimation{
                    
                    showCapsule.toggle()
                }
                
            }, label: {
                Image(systemName: "fiberchannel")
                    .font(.title)
                    .foregroundColor(.black)
                    .background(gra)
                    .clipShape(Circle())
                    .padding()
                
            })
            ,alignment: .topTrailing
        )
    }
}

var tabs = ["A","B","C","D"]

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
