//
//  HomeView.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Query(sort: [SortDescriptor(\FoodItem.date, order: .reverse)]) private var allFoods: [FoodItem]
    @Query private var userSettings: [UserSettings]
    @State private var showCamera = false
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
                        AppBar(viewModel: viewModel, selectedDate: $selectedDate)
                        CalorieSummaryCard(viewModel: viewModel)
                        MacrosSummaryView(viewModel: viewModel)
                        RecentlyUploadedView(viewModel: viewModel)
                    }
                    .padding(.horizontal, Constants.horizontalPadding)
                    .padding(.top, Constants.topPadding)
                }
                FloatingActionButton(action: { showCamera = true })
                    .padding(Constants.fabPadding)
            }
            .sheet(isPresented: $showCamera) {
                //CameraView()
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

    // MARK: - App Bar
    private struct AppBar: View {
        var viewModel: HomeViewModel
        @Binding var selectedDate: HomeViewModel.DateSelection
        var body: some View {
            HStack {
                Text(Constants.appName)
                    .font(.title2.bold())
                Spacer()
                Picker("Date", selection: $selectedDate) {
                    ForEach(HomeViewModel.DateSelection.allCases, id: \.self) { date in
                        Text(date.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            }
        }
    }

    // MARK: - Calorie Summary Card
    private struct CalorieSummaryCard: View {
        var viewModel: HomeViewModel
        var body: some View {
            HStack(spacing: 16) {
                VStack(alignment: .leading) {
                    Text("\(viewModel.caloriesLeft)")
                        .font(.system(size: 36, weight: .bold))
                    Text(Constants.caloriesLeft)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                CircularProgressBar(progress: viewModel.calorieGoal == 0 ? 0 : Double(viewModel.caloriesLeft) / Double(viewModel.calorieGoal), image: Constants.flameIcon, color: Color.accentColor, lineWidth: 8)
                    .frame(width: 64, height: 64)
            }
            .padding()
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 2)
        }
    }

    // MARK: - Macros Summary
    private struct MacrosSummaryView: View {
        var viewModel: HomeViewModel
        var body: some View {
            HStack(spacing: 16) {
                MacroCard(progress: viewModel.proteinGoal == 0 ? 0 : Double(viewModel.proteinLeft) / Double(viewModel.proteinGoal), title: "\(viewModel.proteinLeft)g", subtitle: Constants.proteinOver, icon: Constants.proteinIcon, color: .red)
                MacroCard(progress: viewModel.carbsGoal == 0 ? 0 : Double(viewModel.carbsLeft) / Double(viewModel.carbsGoal), title: "\(viewModel.carbsLeft)g", subtitle: Constants.carbsLeft, icon: Constants.carbsIcon, color: .orange)
                MacroCard(progress: viewModel.fatsGoal == 0 ? 0 : Double(viewModel.fatsLeft) / Double(viewModel.fatsGoal), title: "\(viewModel.fatsLeft)g", subtitle: Constants.fatsLeft, icon: Constants.fatsIcon, color: .blue)
            }
        }
    }

    private struct MacroCard: View {
        let progress: Double
        let title: String
        let subtitle: String
        let icon: String
        let color: Color
        
        var body: some View {
            VStack(spacing: 4) {
                CircularProgressBar(progress: progress, image: icon, color: color, lineWidth: 4)
                    .frame(width: 32, height: 32)
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(12)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 2)
        }
    }

    // MARK: - Recently Uploaded
    private struct RecentlyUploadedView: View {
        var viewModel: HomeViewModel
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text(Constants.recentlyUploaded)
                    .font(.headline)
                ForEach(viewModel.foodsToday) { food in
                    FoodCard(food: food)
                }
            }
        }
    }

    private struct FoodCard: View {
        let food: FoodItem
        var body: some View {
            HStack(spacing: 12) {
                Rectangle()
                    .fill(Color.green.opacity(0.2))
                    .frame(width: 48, height: 48)
                    .overlay(
                        Image(systemName: "leaf")
                            .resizable()
                            .scaledToFit()
                            .padding(10)
                            .foregroundColor(.green)
                    )
                VStack(alignment: .leading, spacing: 4) {
                    Text(food.name)
                        .font(.subheadline.bold())
                    Text("\(food.calories) calories")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    HStack(spacing: 8) {
                        Label("\(food.protein)g", systemImage: Constants.proteinIcon)
                            .labelStyle(.iconOnly)
                            .foregroundColor(.red)
                        Label("\(food.carbs)g", systemImage: Constants.carbsIcon)
                            .labelStyle(.iconOnly)
                            .foregroundColor(.orange)
                        Label("\(food.fats)g", systemImage: Constants.fatsIcon)
                            .labelStyle(.iconOnly)
                            .foregroundColor(.blue)
                    }
                }
                Spacer()
                Text(food.date, style: .time)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .padding(8)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .shadow(color: .black.opacity(0.02), radius: 2, x: 0, y: 1)
        }
    }

    // MARK: - Circular Progress Bar
    private struct CircularProgressBar: View {
        let progress: Double
        let image: String
        let color: Color
        let lineWidth: CGFloat
        
        var body: some View {
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: lineWidth)
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                Image(systemName: image)
                    .foregroundColor(color)
            }
        }
    }

    // MARK: - Floating Action Button
    struct FloatingActionButton: View {
        let action: () -> Void
        var body: some View {
            Button(action: action) {
                Image(systemName: Constants.plusIcon)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.accentColor)
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }
        }
    }

    // MARK: - Constants
    private enum Constants {
        static let appName = "Vibe Coding Test"
        static let bellIcon = "bell"
        static let flameIcon = "flame"
        static let plusIcon = "plus"
        static let proteinIcon = "fork.knife"
        static let carbsIcon = "leaf"
        static let fatsIcon = "drop"
        static let caloriesLeft = "Calories left"
        static let proteinOver = "Protein over"
        static let carbsLeft = "Carbs left"
        static let fatsLeft = "Fats left"
        static let recentlyUploaded = "Recently uploaded"
        static let verticalSpacing: CGFloat = 24
        static let horizontalPadding: CGFloat = 16
        static let topPadding: CGFloat = 12
        static let fabPadding: CGFloat = 24
    }
}

#Preview {
    HomeView()
}
