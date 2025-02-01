import Data
import Testing

@testable import LaunchLab

struct ModuleTests {
  @Test("is completed")
  func testIsCompleted() {
    let module = Module.example(Int.random(in: 50...100))
    #expect(!module.isCompleted)
    module.progress = module.length
    #expect(module.isCompleted)
  }
}
