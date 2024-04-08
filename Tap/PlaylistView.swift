import SwiftUI

struct Record: Hashable {
    var date: String
    var location: String
}

struct PlaylistView: View {
    
    var recordContent: [Record] = [
        Record(date: "24.02.03", location: "Busan"),
        Record(date: "23.11.03~10", location: "Osaka"),
        Record(date: "22.03.18~21", location: "Bangkok"),
        Record(date: "18.01.29~30", location: "Seoul")
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(recordContent, id: \.self) { record in
                            NavigationLink(destination: PlayRecord()) { 
                                HStack() {
                                    Text("\(record.date)")
                                        .foregroundColor(.black)
                                        .padding(.leading, 12)
                                        .font(.system(size: 15, weight: .semibold))
                                    Text("In: \(record.location)")
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.leading)
                                        .font(.system(size: 15, weight: .semibold))
                                    Spacer()
                                    Image(systemName: "play.fill")
                                        .resizable()
                                        .frame(width: 13, height: 17)
                                }
                                .frame(width: 324, height: 50)
                                .padding()
                                .background(Color.prettyYellow)
                                .cornerRadius(10)  
                            } 
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Playlist")
            
            
        }
    }
}


//struct RecordBox: View {
//    
//    var body: some View {
//        
//    }
//}
//
//#Preview {
//    recordBox()
//}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView()
            .preferredColorScheme(.light)
    }
}
