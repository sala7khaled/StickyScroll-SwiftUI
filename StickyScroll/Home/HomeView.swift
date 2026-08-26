//
//  HomeView.swift
//  StickyScroll
//
//  Created by Salah Khaled on 26/08/2026.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        StickyScroll()
            .background {
                Image(.wallpaper)
                    .resizable()
                    .ignoresSafeArea()
            }
        
    }
}

#Preview {
    HomeView()
}
