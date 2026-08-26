//
//  StickySection.swift
//  StickyScroll
//
//  Created by Salah Khaled on 26/08/2026.
//

import SwiftUI

struct StickySection<Content: View, Header: View, MiniHeader: View>: View {
    
    @ViewBuilder var content: Content
    @ViewBuilder var header: Header
    @ViewBuilder var miniHeader: MiniHeader
    @State private var headerSize: CGSize = .zero
    
    private let section: Section = .init()
    private let spacing: CGFloat = 10
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            header
                .visualEffect { effect, proxy in
                    let rect = proxy.frame(in: .named(section.name))
                    let minY = max(rect.minY - section.sectionPadding, 0)
                    let progress = max(min(minY / section.headerFadeDistance, 1), 0)
                    return effect.opacity(1 - progress)
                }
                .background {
                    miniHeader
                        .frame(maxHeight: .infinity)
                        .offset(y: section.miniHeaderOffset / 2)
                        .visualEffect { effect, proxy in
                            let rect = proxy.frame(in: .named(section.name))
                            let minY = max(rect.minY - section.sectionPadding - section.headerFadeDistance, 0)
                            let progress = max(min(minY / section.headerFadeDistance, 1), 0)
                            return effect.opacity(progress)
                        }
                }
                .padding([.horizontal, .top], section.sectionPadding)
                .onGeometryChange(for: CGSize.self) { $0.size } action: { newValue in headerSize = newValue }
            
            content
                .padding([.horizontal, .bottom], section.sectionPadding)
                .visualEffect { effect, proxy in
                    let rect = proxy.frame(in: .named(section.name))
                    let scrollMinY = proxy.frame(in: .scrollView(axis: .vertical)).minY
                    let minY = max(rect.minY - scrollMinY, 0)
                    return effect.offset(y: -minY)
                }
                .clipped()
        }
        .mask {
            GeometryReader { proxy in
                let rect = proxy.frame(in: .named(section.name))
                let viewHeight = proxy.size.height
                let headerHeight = headerSize.height + section.sectionPadding + section.miniHeaderOffset
                let bottomPadding = min(max(rect.minY, 0), viewHeight - headerHeight)
                
                RoundedRectangle(cornerRadius: section.cornerRadius)
                    .padding(.bottom, bottomPadding)
            }
        }
        .background {
            GeometryReader { proxy in
                let rect = proxy.frame(in: .named(section.name))
                let viewHeight = proxy.size.height
                let headerHeight = headerSize.height + section.sectionPadding + section.miniHeaderOffset
                let bottomPadding = min(max(rect.minY, 0), viewHeight - headerHeight)
                
                Group {
                    if section.isGlass {
                        Rectangle()
                            .fill(.clear)
                            .glassEffect(.regular, in: .rect(cornerRadius: section.cornerRadius))
                    } else {
                        RoundedRectangle(cornerRadius: section.cornerRadius)
                            .fill(section.background)
                    }
                }
                .padding(.bottom, bottomPadding)
            }
        }
        .compositingGroup()
        .visualEffect { [headerSize] effect, proxy in
            let minY = proxy.frame(in: .scrollView(axis: .vertical)).minY
            let headerHeight = headerSize.height + section.sectionPadding + section.miniHeaderOffset
            let cutoffHeight = proxy.size.height - headerHeight
            let distance = abs(min(cutoffHeight + minY, 0))
            let progress = max(min(distance / section.fadeDistance, 1), 0)
            let scale = 1 - (progress * section.fadeScale)
            let opacity = 1 - progress
            
            return effect
                .scaleEffect(scale, anchor: .top)
                .opacity(opacity)
                .offset(y: minY < 0 ? -minY : 0)
        }
        .coordinateSpace(.named(section.name))
    }
    
    // MARK: - Section Setup
    private struct Section {
        /// Section
        var name: String = "SECTION"
        var isGlass: Bool = true
        var background: AnyShapeStyle = .init(.fill.tertiary)
        var sectionPadding: CGFloat = 16
        var cornerRadius: CGFloat = 20
        
        /// Header
        var miniHeaderOffset: CGFloat = 0
        var headerFadeDistance: CGFloat = 16
        var fadeDistance: CGFloat = 45
        var fadeScale: CGFloat = 0.2
    }
}
