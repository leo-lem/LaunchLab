//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

public extension Module {
  @MainActor static func setup(_ result: Result<ModelContainer, any Error>) {
    guard case .success(let container) = result else { assert(false, "Failed to load model container.") }
    guard let url = Bundle.main.url(forResource: "Modules", withExtension: "json") else {
      assert(false, "Module's file not found.")
    }

    do {
      for module in try JSONDecoder().decode([Module].self, from: try Data(contentsOf: url)) {
        container.mainContext.insert(module)
      }
    } catch {
      assert(false, "Failed to load modules. \(error)")
    }
  }
}
