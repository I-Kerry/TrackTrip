
import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var draft: FilterOptions
    
    let onApply: (FilterOptions) -> Void
    
    init(filters: FilterOptions, onApply: @escaping (FilterOptions) -> Void) {
        _draft = State(initialValue: filters)
        self.onApply = onApply
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            timeSection
            transferSection
            Spacer()
            applyButton
        }
        .padding(16)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var timeSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Время отправления")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(Color.blackWhite)
            VStack(alignment: .leading, spacing: 16) {
                ForEach(TimeOfDay.allCases, id: \.self) { time in
                    Button {
                        toggle(time)
                    } label: {
                        HStack {
                            Text(time.title)
                                .foregroundStyle(.blackWhite)
                            Spacer()
                            Image(systemName: draft.selectedTimes.contains(time) ? "checkmark.square.fill" : "square")
                                .foregroundStyle(.blackWhite)
                        }
                    }
                }
            }
        }
    }
    
    private var transferSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Показывать варианты с пересадками")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(Color.blackWhite)

            VStack(alignment: .leading, spacing: 16) {
                transferRow(title: "Да", isSelected: draft.showTransfers == true) {
                    draft.showTransfers = true
                }
                
                transferRow(title: "Нет", isSelected: draft.showTransfers == false) {
                    draft.showTransfers = false
                }
            }
        }
    }
    
    private func transferRow(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .foregroundStyle(.blackWhite)
                Spacer()
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .foregroundStyle(Color.blackWhite)
            }
        }
    }
    
    private func toggle(_ timeOfDay: TimeOfDay) {
        if draft.selectedTimes.contains(timeOfDay) {
            draft.selectedTimes.remove(timeOfDay)
        } else {
            draft.selectedTimes.insert(timeOfDay)
        }
    }
    
    @ViewBuilder
    
    private var applyButton: some View {
        if draft.isActive {
            Button {
                onApply(draft)
                dismiss()
            } label: {
                Text("Применить")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
        }
    }
}

