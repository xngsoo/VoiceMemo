//
//  OnboardingView.swift
//  VoiceMemo
//
//  Created by Han on 2/26/24.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var onboardingViewModel: OnboardingViewModel = OnboardingViewModel()
    var body: some View {
        // TODO:  -화면 전환 구현 필요
        OnboardingContentView(onboardingViewModel: onboardingViewModel)
    }
}

//MARK: -온보딩 컨텐츠 뷰
private struct OnboardingContentView: View {
    @ObservedObject private var onboardingViewModel: OnboardingViewModel
    
    fileprivate init(onboardingViewModel: OnboardingViewModel) {
        self.onboardingViewModel = onboardingViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            // 온보딩 셀리스트 뷰
            onboardingCellListView(onboardingViewModel: onboardingViewModel)
            Spacer()
            // 시작 버튼 뷰
            StartButtonView()
        }
        .edgesIgnoringSafeArea(.top)
    }
}

// MARK: - 온보딩 셀 리스트 뷰
private struct onboardingCellListView: View {
    @ObservedObject private var onboardingViewModel: OnboardingViewModel
    @State private var selectedIndex = 0
    fileprivate init(onboardingViewModel: OnboardingViewModel,
         selectedIndex: Int = 0) {
        self.onboardingViewModel = onboardingViewModel
        self.selectedIndex = selectedIndex
    }
    fileprivate var body: some View {
        TabView(selection: $selectedIndex) {
            // 온보딩 셀
            ForEach(Array(onboardingViewModel.onboardingContents.enumerated()), id: \.element) {
                index, onboardingContent in
                OnboardingCellView(onboardingContent: onboardingContent)
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.5)
        .background(
            selectedIndex % 2 == 0
            ? Color.customSky : Color.customBackgroundGreen
        )
        .clipped()
    }
}

// MARK: - 온보딩 셀 뷰
private struct OnboardingCellView: View {
    private var onboardingContent: OnboardingContent
    
    fileprivate init(onboardingContent: OnboardingContent) {
        self.onboardingContent = onboardingContent
    }
    fileprivate var body: some View {
        VStack {
            Image(onboardingContent.imageFileName)
                .resizable()
                .scaledToFit()
            
            HStack {
                Spacer()
                VStack {
                    Spacer()
                        .frame(height: 46)
                    
                    Text(onboardingContent.title)
                        .font(.system(size: 16, weight: .bold))
                    
                    Spacer()
                        .frame(height: 5)
                    Text(onboardingContent.subTitle)
                        .font(.system(size: 16))
                    
                }
                
                Spacer()
            }
            .background(Color.customWhite)
            .cornerRadius(0)
        }
        .shadow(radius: 10)
    }
}

//MARK: -시작하기 버튼 뷰
private struct StartButtonView: View {
    fileprivate var body: some View {
        Button {
            //
        } label: {
            HStack {
                Text("시작하기")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.customGreen)
                Image("startHome")
                    .renderingMode(.template)
                    .foregroundColor(.customGreen)
            }
        }
        .padding(.bottom, 50)
    }
}
#Preview {
    OnboardingView()
}
