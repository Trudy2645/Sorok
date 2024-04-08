import SwiftUI

struct CharacterBusan: View {
    var body: some View {
        VStack{
            //최상단의 프로필 버튼
            Text("Charater")
                .font(.title)
                .padding(.leading, -155)
                .padding(.bottom, 37)
                .foregroundColor(Color.ashGrey)
            ImageSlideshowView()
            
            
        }
           
    }
}


struct CharacterBusan_Previews: PreviewProvider {
    static var previews: some View {
        CharacterBusan()
            .preferredColorScheme(.light)
        
    }
}
