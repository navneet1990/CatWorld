//
//  TestingEnvironmentProtocol.swift
//  CatWorld
//

import Foundation

/* Protocol for validating testing environment
  * Check if UI test case running
  * Check if both UI and Unit test running
  * Return local store mock taka
 **/
protocol TestingEnvironment {
  
  func isUITestCaseRunning() -> Bool
  func getMockBreedsData() -> Data?
}

extension TestingEnvironment{

  func isUITestCaseRunning() -> Bool {
    return  ProcessInfo.processInfo.arguments.contains("isUITesting")
  }

    func getMockBreedsData() -> Data? {
        guard ProcessInfo.processInfo.environment["noData"] == "true",
              let url = Bundle.main.url(forResource: "Breeds",
                                        withExtension: "json"),
              let data = try? Data(contentsOf: url ) else {

                return nil
            }
            return data
        }
}

extension NetworkManager: TestingEnvironment{}
