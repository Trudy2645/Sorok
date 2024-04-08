import SwiftUI

struct PlayRecord: View {
    var body: some View{
        
        NavigationStack{
            ZStack{
                Color.prettyBlack
                VStack(alignment: .leading){
                    Image("바다")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .padding(.leading, 46)
                    Text("광안리")
                        .padding(.leading,30)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 20, weight: .semibold))
                        .padding()
                    Text("부산 광안리 해수욕장을 오랜만에 갔는데 파도 소리 가 잔잔하니 듣기 좋았다.")
                        .padding(.leading,30)
                        .padding(.trailing, 75)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 15, weight: .regular))
                        .padding()
                    HStack{
                        Image(systemName: "gobackward.15")
                            .resizable()
                            .frame(width: 25, height: 28)
                            .foregroundColor(.white)
                            .padding(.leading, 80)
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width: 23, height: 30)
                            .foregroundColor(.white)
                            .padding(.leading, 70)
                        Image(systemName: "goforward.15")
                            .resizable()
                            .frame(width: 25, height: 28)
                            .foregroundColor(.white)
                            .padding(.leading, 70)
                    }
                    
                }
                
            }
        }.navigationTitle("Record")
            .foregroundColor(.white)
    }
}

struct PlayRecord_Previews: PreviewProvider {
    static var previews: some View {
        PlayRecord()
        
        
    }
}
