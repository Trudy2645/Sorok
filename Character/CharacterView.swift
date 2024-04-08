import SwiftUI

struct CharacterView: View {
    
    var body: some View{
        NavigationView{
            
            VStack{
                //최상단의 프로필 버튼
                Text("Charater")
                    .font(.title)
                    .padding(.leading, -155)
                    .padding(.bottom, 37)
                    .foregroundColor(Color.ashGrey)
                HStack(spacing: 13) {
                    NavigationLink(destination: CharacterBusan()){
                        CharacterBtn(buttonText: "Busan", buttonAction: {print("버튼 눌려짐")},buttonColor: Color.lightBlue)
                    } 
                    CharacterBtn(buttonText: "Seoul", buttonAction: {print("버튼 눌려짐")},buttonColor: Color.olive)
                    
                }.padding(3)
                HStack(spacing: 13){
                    CharacterBtn(buttonText: "Osaka", buttonAction: {print("버튼 눌려짐")},buttonColor: Color.prettyMint)
                    CharacterBtn(buttonText: "Bangkok", buttonAction: {print("버튼 눌려짐")},buttonColor: Color.prettyPink)
                }
            }.toolbar(.hidden, for: .tabBar)
        }
    }
    
}

struct CharacterBtn: View {
    var buttonText: String
    var buttonAction: () -> Void
    var buttonColor: Color
    
    var body: some View {
            Text(buttonText)
                .padding()
                .frame(width: 150, height: 150)
                .foregroundColor(.black)
                .background(buttonColor)
                .cornerRadius(8)
                .bold()
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView()
            .preferredColorScheme(.light)
        
    }
}

