//
//  HomeView.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import SwiftData
import SwiftUI
import UIKit

struct HomeView: View {
    @Query(sort: [SortDescriptor(\FoodItem.timestamp, order: .reverse)]) private var allFoods: [FoodItem]
    @Query private var userSettings: [UserSettings]
    @State private var selectedDate: HomeViewModel.DateSelection = .today
    @State private var viewModel: HomeViewModel

    init() {
        _viewModel = State(wrappedValue: HomeViewModel(allFoods: [], userSettings: [], selectedDate: .today))
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
                        Picker("Date", selection: $selectedDate) {
                            ForEach(HomeViewModel.DateSelection.allCases, id: \.self) { date in
                                Text(date.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        CalorieSummaryCard(
                            caloriesConsumed: $viewModel.caloriesConsumed,
                            calorieGoal: $viewModel.calorieGoal
                        )
                        
                        MacrosSummaryView(
                            proteinConsumed: $viewModel.proteinConsumed,
                            proteinGoal: $viewModel.proteinGoal,
                            carbsConsumed: $viewModel.carbsConsumed,
                            carbsGoal: $viewModel.carbsGoal,
                            fatsConsumed: $viewModel.fatsConsumed,
                            fatsGoal: $viewModel.fatsGoal
                        )
                        
                        TodayYesterdayDataView(viewModel: viewModel, selectedDate: selectedDate)
                    }
                    .padding(.horizontal, Constants.horizontalPadding)
                    .padding(.top, Constants.topPadding)
                }

                FloatingActionButton(action: { viewModel.showCamera = true })
                    .padding(Constants.fabPadding)
            }
            .navigationTitle(Constants.appName)
            .sheet(isPresented: $viewModel.showCamera) {
                CameraView()
            }
            .sheet(item: $viewModel.editingFood) { food in
                FoodEditView(food: food, onSave: {
                    viewModel.updateInputs(allFoods: allFoods, userSettings: userSettings)
                })
            }
            .onAppear {
                viewModel.updateInputs(allFoods: allFoods, userSettings: userSettings)
            }
            .onChange(of: allFoods) { _, newFoods in
                viewModel.updateInputs(allFoods: newFoods, userSettings: userSettings)
            }
            .onChange(of: userSettings) { _, newSettings in
                viewModel.updateInputs(allFoods: allFoods, userSettings: newSettings)
            }
            .onChange(of: selectedDate) { _, newDate in
                viewModel.selectedDate = newDate
            }
        }
    }

    private struct TodayYesterdayDataView: View {
        var viewModel: HomeViewModel
        let selectedDate: HomeViewModel.DateSelection

        var body: some View {
            if viewModel.foodsToday.isEmpty {
                VStack {
                    Spacer()
                    VStack(spacing: 16) {
                        Image(systemName: "fork.knife.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.gray.opacity(0.4))
                        Text("No food data yet")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.height/2)
            } else {
                LazyVStack(alignment: .leading, spacing: 8) {
                    if selectedDate == .today {
                        Text(Constants.recentlyUploaded)
                            .font(.headline)
                    }
                    ForEach(viewModel.foodsToday) { food in
                        FoodCard(food: food, onTap: {
                            viewModel.editingFood = food
                        })
                    }
                }
            }
        }
    }

    private enum Constants {
        static let appName = "Vibe Coding Test"
        static let recentlyUploaded = "Recently uploaded"
        static let verticalSpacing: CGFloat = 24
        static let horizontalPadding: CGFloat = 16
        static let topPadding: CGFloat = 12
        static let fabPadding: CGFloat = 24
    }
}
