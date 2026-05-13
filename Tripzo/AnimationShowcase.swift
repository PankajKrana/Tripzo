//
//  AnimationShowcase.swift
//  Tripzo
//
//  This file demonstrates all available animations and transitions

import SwiftUI

struct AnimationShowcase: View {
    @State private var selectedAnimation = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                TabView(selection: $selectedAnimation) {
                    shimmerShowcase.tag(0)
                    pulseShowcase.tag(1)
                    bounceShowcase.tag(2)
                    rotatingShowcase.tag(3)
                    slideShowcase.tag(4)
                    buttonEffectShowcase.tag(5)
                    elevationShowcase.tag(6)
                    transitionShowcase.tag(7)
                }
                .tabViewStyle(.page(indexDisplayMode: .automatic))
            }
            .navigationTitle("Animation Library")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var shimmerShowcase: some View {
        VStack(spacing: 24) {
            Text("Shimmer Effect")
                .font(.titleLarge)
                .fontWeight(.bold)
            
            RoundedRectangle(cornerRadius: 12)
                .fill(TripzoColors.surface)
                .frame(height: 100)
                .shimmer()
            
            RoundedRectangle(cornerRadius: 12)
                .fill(TripzoColors.surface)
                .frame(height: 60)
                .shimmer()
            
            Text("Used for loading skeleton screens")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Spacer()
        }
        .padding(24)
    }
    
    private var pulseShowcase: some View {
        VStack(spacing: 24) {
            Text("Pulse Effect")
                .font(.titleLarge)
                .fontWeight(.bold)
            
            Circle()
                .fill(TripzoColors.primary)
                .frame(width: 100, height: 100)
                .pulse()
            
            Text("Used for attention-grabbing notifications")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Spacer()
        }
        .padding(24)
    }
    
    private var bounceShowcase: some View {
        VStack(spacing: 24) {
            Text("Bounce Effect")
                .font(.titleLarge)
                .fontWeight(.bold)
            
            Image(systemName: "star.fill")
                .font(.system(size: 60))
                .foregroundStyle(TripzoColors.accent)
                .bounce()
            
            Text("Used for floating action buttons")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Spacer()
        }
        .padding(24)
    }
    
    private var rotatingShowcase: some View {
        VStack(spacing: 24) {
            Text("Rotating Effect")
                .font(.titleLarge)
                .fontWeight(.bold)
            
            Image(systemName: "gear")
                .font(.system(size: 60))
                .foregroundStyle(TripzoColors.primary)
                .rotating()
            
            Text("Used for loading spinners")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Spacer()
        }
        .padding(24)
    }
    
    private var slideShowcase: some View {
        VStack(spacing: 24) {
            Text("Slide Animation")
                .font(.titleLarge)
                .fontWeight(.bold)
            
            RoundedRectangle(cornerRadius: 12)
                .fill(TripzoColors.secondary)
                .frame(height: 100)
                .slideAnimation(duration: 0.5)
            
            Text("Used for entrance animations")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Spacer()
        }
        .padding(24)
    }
    
    private var buttonEffectShowcase: some View {
        VStack(spacing: 24) {
            Text("Button Scale Effect")
                .font(.titleLarge)
                .fontWeight(.bold)
            
            ModernButton(
                title: "Press Me",
                systemImage: "hand.thumbsup.fill",
                action: {},
                style: .primary
            )
            
            Text("Scales to 95% on tap")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Spacer()
        }
        .padding(24)
    }
    
    private var elevationShowcase: some View {
        VStack(spacing: 24) {
            Text("Elevation Shadows")
                .font(.titleLarge)
                .fontWeight(.bold)
            
            VStack(spacing: 16) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .frame(height: 60)
                    .elevation(.small)
                    .overlay(Text("Small").foregroundStyle(.secondary))
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .frame(height: 60)
                    .elevation(.medium)
                    .overlay(Text("Medium").foregroundStyle(.secondary))
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .frame(height: 60)
                    .elevation(.large)
                    .overlay(Text("Large").foregroundStyle(.secondary))
            }
            
            Text("Used for depth and hierarchy")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Spacer()
        }
        .padding(24)
    }
    
    private var transitionShowcase: some View {
        VStack(spacing: 24) {
            Text("Combined Transitions")
                .font(.titleLarge)
                .fontWeight(.bold)
            
            Text("Scale + Opacity")
                .font(.callout)
                .transition(.scale.combined(with: .opacity))
            
            Divider()
            
            Text("Slide + Opacity")
                .font(.callout)
                .transition(.slide.combined(with: .opacity))
            
            Text("Used for view state changes")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Spacer()
        }
        .padding(24)
    }
}

#Preview {
    AnimationShowcase()
}
