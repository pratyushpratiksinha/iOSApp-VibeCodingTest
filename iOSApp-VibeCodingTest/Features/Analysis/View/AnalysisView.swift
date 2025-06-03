//
//  AnalysisView.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import SwiftData
import SwiftUI

struct AnalysisView: View {
    @Query private var foodItems: [FoodItem]
    @Query private var userSettings: [UserSettings]
    @State private var viewModel = AnalysisViewModel()
    
    var body: some View {
        NavigationStack {
            if foodItems.isEmpty {
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
                    .navigationTitle(Constants.navTitle)
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: Constants.sectionSpacing) {
                        Text(Constants.calorieTrendTitle)
                            .font(.headline)
                        
                        Picker("Range", selection: $viewModel.selectedRangeForCalorieTrend) {
                            ForEach(AnalysisViewModel.TimeRange.allCases) { range in
                                Text(range.rawValue).tag(range)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        let filteredForCalorieRange = viewModel.filteredItems(foodItems, for: viewModel.selectedRangeForCalorieTrend)
                        let calorieData = viewModel.caloriesDistribution(for: filteredForCalorieRange)
                        CalorieTrendChart(data: calorieData, range: viewModel.selectedRangeForCalorieTrend)
                            .frame(height: Constants.chartHeight)
                        
                        Divider()
                        
                        Text(Constants.macroDistributionTitle)
                            .font(.headline)
                        
                        Picker("Range", selection: $viewModel.selectedRangeForMacroDistribution) {
                            ForEach(AnalysisViewModel.TimeRange.allCases) { range in
                                Text(range.rawValue).tag(range)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        let filteredForMacroRange = viewModel.filteredItems(foodItems, for: viewModel.selectedRangeForMacroDistribution)
                        let macroData = viewModel.stackedMacroDistribution(for: filteredForMacroRange)
                        MacroBarChart(data: macroData, range: viewModel.selectedRangeForMacroDistribution)                           .frame(height: Constants.chartHeight)
                    }
                    .padding()
                }
                .navigationTitle(Constants.navTitle)
            }
        }
    }
    
    private enum Constants {
        static let navTitle = "Analysis"
        static let calorieTrendTitle = "Calorie Trend"
        static let macroDistributionTitle = "Macro Distribution"
        static let chartHeight: CGFloat = 200
        static let sectionSpacing: CGFloat = 24
    }
}
