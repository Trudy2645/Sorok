import SwiftUI

// 이미지와 텍스트를 묶는 데이터 타입
struct ImageTextPair {
    let imageName: String
    let text: String
}

struct ImageSlideshowView: View {
    // 이미지와 텍스트 배열
    let imageTextPairs: [ImageTextPair] = [
        ImageTextPair(imageName: "갈매기_1", text: "LV. 1 아기 갈매기"),
        ImageTextPair(imageName: "갈매기_2", text: "LV. 2 성장한 갈매기"),
        ImageTextPair(imageName: "갈매기_3", text: "LV. 3 중사 갈매기"),
        ImageTextPair(imageName: "갈매기_4", text: "LV. 4 소위 갈매기"),
        ImageTextPair(imageName: "갈매기_5", text: "LV. 5 소령 갈매기")
    ]
    
    // 현재 이미지 인덱스를 추적하는 상태 변수
    @State private var currentImageIndex: Int = 0
    
    var body: some View {
        VStack {
            // 이미지 표시
            Image(imageTextPairs[currentImageIndex].imageName)
                .resizable()
                .frame(width: 250, height: 250)
            
            // 텍스트 표시
            Text(imageTextPairs[currentImageIndex].text)
                .padding(.vertical)
                .font(.title3)
                .bold()
            
            // 버튼 그룹
            HStack {
                Button(action: {
                    // 이전 이미지로 이동 (순환)
                    currentImageIndex = (currentImageIndex - 1 + imageTextPairs.count) % imageTextPairs.count
                }) {
                    Text("이전")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Button(action: {
                    // 다음 이미지로 이동 (순환)
                    currentImageIndex = (currentImageIndex + 1) % imageTextPairs.count
                }) {
                    Text("다음")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
        }
    }
}

struct ImageSlideshowView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSlideshowView()
            .preferredColorScheme(.light)
    }
}
