//
//  TestingEnvironmentProtocol.swift
//  CatWorld
//

import Foundation

/* Protocol for validating testing environment
  * Check if UI test case running
  * Return local store mock data
 * There are many approached, but this is one of the approach we can use for UI testing mock data
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
