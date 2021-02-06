//
//  ScrollTabBar.swift
//  UI-120
//
//  Created by にゃんにゃん丸 on 2021/02/06.
//

import SwiftUI

struct ScrollTabBar<Content : View>: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return ScrollTabBar.Coordinator(parent: self)
    }
    
    var content : Content
   
    let scrollview = UIScrollView()
    var rect : CGRect
    @Binding var offset : CGFloat
    var tabs : [Any]
    
    init(tabs:[Any],rect : CGRect,offset : Binding<CGFloat>,@ViewBuilder content: () -> Content) {
        self.content = content()
        self._offset = offset
        self.rect = rect
        self.tabs = tabs
        
    }
    
    
    func makeUIView(context: Context) -> UIScrollView {
        
        setupScrollView()
        scrollview.contentSize = CGSize(width: rect.width * CGFloat(tabs.count), height: rect.height)
        scrollview.addSubview(extractView())
        scrollview.delegate = context.coordinator
        return scrollview
        
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        if uiView.contentOffset.x != offset{
            
            uiView.delegate = nil
            
            UIView.animate(withDuration: 0.6) {
                uiView.contentOffset.x = offset
            } completion: { (statas) in
                if statas{uiView.delegate = context.coordinator}
            }

            
            
            
        }
        
        
    }
    
    class Coordinator : NSObject,UIScrollViewDelegate{
        let parent : ScrollTabBar
        
        init(parent : ScrollTabBar) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.offset = scrollView.contentOffset.x
            
        }
        
        
        
        
    }
    
    func setupScrollView(){
        
        scrollview.isPagingEnabled = true
        scrollview.bounces = false
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
    }
    
    func extractView() -> UIView{
        
        let controller = UIHostingController(rootView: content)
        controller.view.frame = CGRect(x: 0, y: 0, width: rect.width * CGFloat(tabs.count), height: rect.height)
        return controller.view!
        
    }
    
    
}




