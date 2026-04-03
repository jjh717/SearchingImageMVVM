import SwiftUI

struct PinterestGrid<Data: RandomAccessCollection, Content: View>: View where Data.Element: Identifiable {

    let data: Data
    let columns: Int
    let spacing: CGFloat
    let content: (Data.Element) -> Content

    init(
        _ data: Data,
        columns: Int = 2,
        spacing: CGFloat = 8,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        self.columns = columns
        self.spacing = spacing
        self.content = content
    }

    var body: some View {
        HStack(alignment: .top, spacing: spacing) {
            ForEach(0..<columns, id: \.self) { columnIndex in
                LazyVStack(spacing: spacing) {
                    ForEach(itemsForColumn(columnIndex)) { item in
                        content(item)
                    }
                }
            }
        }
    }

    private func itemsForColumn(_ column: Int) -> [Data.Element] {
        data.enumerated()
            .filter { $0.offset % columns == column }
            .map(\.element)
    }
}
