import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            HomeView()
                .tabItem {
                    Image(systemName: "music.note.house")
                    Text("Home")
                        .foregroundColor(.orangeYellow)
                }
                .tag(Tab.home)
//            MapView()
            PlaylistView()
                .font(.largeTitle)
                .tabItem {
                    Image(systemName: "music.note.list")
                    Text("Playlist")
                }
                .tag(Tab.playlist)
            MapView()
                .tabItem { 
                    Image(systemName: "map")
                    Text("Map")
                        .foregroundColor(.orangeYellow)
                }
                .tag(Tab.map)
        }.preferredColorScheme(.light)
    }
}

