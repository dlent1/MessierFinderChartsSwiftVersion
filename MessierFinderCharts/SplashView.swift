//
//  SplashView.swift
//  MessierFinderCharts
//
//  Created by David Lent on 5/15/26.
//
import SwiftUI

struct SplashView: View {
    @State private var showContentView = false
    
    var body: some View {
        Group {
            if showContentView {
                ContentView()
            }
            else {
                ZStack {
                    VStack(spacing: 0) {
                        Text("Messier Finder Charts")
                            .font(.system(size: 34))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.top, 14)

                        Text("by David Lent")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.top, 6)

                        Text("© 2026")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.top, 6)

                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Image("MessierSplashBackground")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                )
            }
        }
        .task {
            try? await Task.sleep(for: .seconds(4))
            showContentView = true
        }
    }
}

#Preview {
    SplashView()
}
