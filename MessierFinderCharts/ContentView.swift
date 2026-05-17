import SwiftUI

struct ContentView: View {
    @State private var items: [String] = []
    @State private var selectedItem: String = "m1"

    var body: some View {
        GeometryReader { geo in

            let isLandscape = geo.size.width > geo.size.height

            ZStack {

                // BACKGROUND IMAGE (correct rotation + layout swap)
                Image(backgroundImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: isLandscape ? geo.size.height : geo.size.width,
                        height: isLandscape ? geo.size.width : geo.size.height,
                        alignment: .bottom
                    )
                    .rotationEffect(isLandscape ? .degrees(-90) : .degrees(0))
                    .position(x: geo.size.width / 2, y: geo.size.height / 2)
                    .ignoresSafeArea()

                // UI OVERLAY
                VStack(spacing: 0) {

                    Picker("Select Object", selection: $selectedItem) {
                        ForEach(items, id: \.self) { item in
                            Text(item).tag(item)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 90)
                    .clipped()
                    .background(.ultraThinMaterial)

                    Spacer()
                }
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .top)
                
            }
        }
        .background(Color.black)
        .onAppear {
            loadMessierData()
        }
    }

    // Convert "M-1 Supernova Remnant" → "m1"
    var backgroundImageName: String {
        (selectedItem.components(separatedBy: " ").first ?? "")
            .replacingOccurrences(of: "-", with: "")
            .lowercased()
    }

    func loadMessierData() {
        guard let url = Bundle.main.url(forResource: "MessierData", withExtension: "txt") else {
            print("Could not find MessierData.txt")
            return
        }

        do {
            let contents = try String(contentsOf: url, encoding: .utf8)

            let lines = contents
                .components(separatedBy: .newlines)
                .filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }

            items = lines

            if let first = lines.first {
                selectedItem = first
            }

        } catch {
            print("Error loading file: \(error)")
        }
    }
}

#Preview {
    ContentView()
}
