//
//  StickyScroll.swift
//  StickyScroll
//
//  Created by Salah Khaled on 26/08/2026.
//

import SwiftUI

struct StickyScroll: View {
    
    // MARK: - Properties
    let padding: CGFloat = 16
    
    // MARK: - Body
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: padding - 2) {
                weatherSection
                weatherSection2
                weatherSection
                weatherSection2
                weatherSection
                weatherSection2
                weatherSection
                weatherSection2
            }
        }
        .safeAreaPadding(padding)
    }
    
    // MARK: - Weather Section
    var weatherSection: some View {
        StickySection {
            HStack(spacing: 10) {
                Image(systemName: "cloud.fill")
                Text("Scattered light rain from 10PM to 12PM")
            }
            .padding(.vertical, 10)
        } header: {
            HStack {
                Text ("Highlights")
                    .fontWeight(.semibold)
                
                Spacer (minLength: 0)
                
                Image(systemName: "exclamationmark.bubble.fill")
                    .font(.callout)
                
            }
        } miniHeader: {
            HStack(spacing: 6) {
                Image(systemName: "cloud")
                Text("HIGHLIGHTS")
                Spacer(minLength: 0)
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
    }
    
    // MARK: - Weather Section 2
    var weatherSection2: some View {
        StickySection {
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    Image(systemName: "cloud.sun.fill")
                    Text("Scattered light rain from 10PM to 12PM")
                }
                
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1966, when designers at Letraset and James Mosley, the librarian at St Bride Printing Library in London, took a 1914 Cicero translation and scrambled it to make dummy text for Letraset's Body Type sheets. It has survived not only many decades, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised thanks to these sheets and more recently with desktop publishing software like Aldus PageMaker and Microsoft Word including versions of Lorem Ipsum.")
                    .font(.footnote)
                    .opacity(0.8)
                
            }
            .padding(.vertical, 10)
        } header: {
            HStack {
                Text ("Weather")
                    .fontWeight(.semibold)
                
                Spacer (minLength: 0)
                
                Image(systemName: "exclamationmark.bubble.fill")
                    .font(.callout)
                
            }
        } miniHeader: {
            HStack(spacing: 6) {
                Image(systemName: "cloud")
                Text("HIGHLIGHTS")
                Spacer(minLength: 0)
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    StickyScroll()
}
