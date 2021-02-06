//
//  TabBar.swift
//  UI-120
//
//  Created by にゃんにゃん丸 on 2021/02/06.
//

import SwiftUI

struct TabBar: View {
    @Binding var offset : CGFloat
    @Binding var showCapsule : Bool
    
    @State var with : CGFloat = 0
    var body: some View {
        GeometryReader{proxy -> AnyView   in
            
            let equalwith = UIScreen.main.bounds.width / CGFloat(tabs.count)
            DispatchQueue.main.async {
                self.with = equalwith
            }
            
            
            return AnyView(
                ZStack(alignment:.bottomLeading){
                    
                    Capsule()
                        .fill(gra)
                        .frame(width: equalwith - 15, height: showCapsule ? 40 : 4)
                        .offset(x: getoffset() + 7)
                    
                    HStack(spacing:0){
                        
                        ForEach(tabs.indices,id:\.self){index in
                            
                            
                            
                            
                            Text(tabs[index])
                                .bold()
                                .foregroundColor(showCapsule ? (getindexoffset() == CGFloat(index) ? .black : .white) : .white)
                                .frame(width: equalwith, height: 40)
                                .contentShape(Rectangle())
                                .onTapGesture(perform: {
                                    withAnimation{
                                        
                                        offset = UIScreen.main.bounds.width * CGFloat(index)
                                        
                                    }
                                })
                            
                            
                        }
                        
                    }
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 40, alignment: .center)
                .clipShape(Capsule())
                
            )
            
            
            
            
        }
        .padding()
        .frame(height: 40)
    }
    
    func getoffset() -> CGFloat{
        let progress = offset / UIScreen.main.bounds.width
        
        return progress * with
        
        
    }
    
    func getindexoffset() -> CGFloat{
        
        let indexflat = offset / UIScreen.main.bounds.width
        
        return indexflat.rounded(.toNearestOrAwayFromZero)
    }
    
    
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
