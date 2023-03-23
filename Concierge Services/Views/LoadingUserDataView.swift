import SwiftUI
import ActivityIndicatorView
import AlertToast
import Combine

struct LoadingUserDataView: View {
    
    @StateObject private var launchScreenState = LaunchScreenStateManager()
    
    @StateObject var firestoreManager: FirestoreManager
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    @State private var showToast = false
    @State private var toastMessage = ""
    
    @State private var showLoadingIndicator: Bool = true
    
    @State var isActive = false
    
    var body: some View {
        
        VStack {
            
            Image("AfricanSun")
                .frame(width: 164, height: 164)
            
            ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .default())
                .frame(width: 32, height: 32)
                .foregroundColor(Color.ColorPrimary)
                .padding(12)
            
            Text("Loading your info...")
                .font(Font.custom("Poppins-Medium", size: 18))
                .padding(12)
            
            NavigationLink(destination: TabbarView().environmentObject(firestoreManager).environmentObject(loginViewModel), isActive: self.$isActive) {
                EmptyView()
            }
        }
        .onAppear {
            
            if(UserDefaultsUtils().getUserLoggedIn()) {
                
                firestoreManager.fetchUserDetails(userID: UserDefaultsUtils().getUserId())
                
                if(UserDefaultsUtils().isUserAdmin()) {
                    firestoreManager.getAgentClients() { clientsSynced in
                        if(clientsSynced) {
                            print("Clients synced")
                        } else {
                            print("Clients sync error")
                        }
                    }
                }
                
                firestoreManager.getGeneralTickets() { loadedTickets in
                    if(loadedTickets) {
                        print("Loaded general tickets")
                    } else {
                        print("Error loading general tickets")
                    }
                }
                
                firestoreManager.getFlightTickets() { loadedTickets in
                    if(loadedTickets) {
                        print("Loaded flight tickets")
                        
                        self.launchScreenState.dismiss()
                        
                        self.isActive.toggle()
                        
                    } else {
                        print("Error loading general tickets")
                    }
                }
            } else {
                self.launchScreenState.dismiss()
                self.isActive.toggle()
            }
        }
        .navigationTitle("")
    }
}

struct LoadingUserDataView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingUserDataView(firestoreManager: FirestoreManager())
    }
}