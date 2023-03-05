import Foundation

enum UserDefaultsManager {
    
    static var firstLaunch: Bool {
        get { UserDefaults.standard.value(forKey: "firstLaunch") as? Bool ?? false }
        set { UserDefaults.standard.setValue(newValue, forKey: "firstLaunch") }
    }
}
