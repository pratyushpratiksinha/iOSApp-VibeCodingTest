//
//  HistoryView.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 04/06/25.
//

import SwiftData
import SwiftUI

struct HistoryView: View {
    @Query private var foodItems: [FoodItem]
    @Query private var userSettings: [UserSettings]
    @State private var viewModel = HistoryViewModel()
    
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
                    let grouped = viewModel.groupedItems(foodItems)
                    let visibleGroups = Array(grouped.prefix(viewModel.visibleSectionCount))
                    ForEach(visibleGroups, id: \.key) { date, items in
                        let summary = viewModel.summary(for: items, userSettings: userSettings.first)
                        sectionView(date: date, items: items, summary: summary)
                            .onAppear {
                                if grouped.count > viewModel.visibleSectionCount,
                                   date == visibleGroups.last?.key {
                                    viewModel.visibleSectionCount += 10
                                }
                            }
                    }
                    .padding()
                }
                .navigationTitle(Constants.navTitle)
            }
        }
    }
    
    @ViewBuilder
    private func sectionView(date: String, items: [FoodItem], summary: (consumed: (calories: Int, protein: Int, carbs: Int, fats: Int), goal: (calories: Int, protein: Int, carbs: Int, fats: Int))) -> some View {
        LazyVStack(alignment: .leading, spacing: 0) {
            Text(date)
                .font(.subheadline.weight(.medium))
                .foregroundColor(.black)
                .padding(.horizontal)
                .padding(.top, 16)
            
            CalorieSummaryCard(
                caloriesConsumed: .constant(summary.consumed.calories),
                calorieGoal: .constant(summary.goal.calories)
            )
            .padding(.all)
            
            MacrosSummaryView(
                proteinConsumed: .constant(summary.consumed.protein),
                proteinGoal: .constant(summary.goal.protein),
                carbsConsumed: .constant(summary.consumed.carbs),
                carbsGoal: .constant(summary.goal.carbs),
                fatsConsumed: .constant(summary.consumed.fats),
                fatsGoal: .constant(summary.goal.fats)
            )
            .padding(.all)
            
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                foodCardView(for: item, isLast: index == items.count - 1)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 2)
        .padding(.bottom, 8)
    }
    
    @ViewBuilder
    private func foodCardView(for item: FoodItem, isLast: Bool) -> some View {
        FoodCard(food: item, onTap: nil)
            .padding(.horizontal)
            .padding(.vertical, 6)
            .padding(.bottom, isLast ? 10 : 0)
    }
    
    private enum Constants {
        static let navTitle = "History"
        static let sectionSpacing: CGFloat = 24
    }
}
