import SwiftUI
import AVFoundation //녹음 관련
//녹음중일때는 wave 색이 빨개지게 도전

//버튼 양식
struct BtnHome: View{
    var buttonImage: String //버튼 안에 이미지
    var buttonAction: () -> Void //버튼 눌렀을 때
    var buttonTitle: String //버튼 제목
    
    var body: some View {
        VStack{
            //버튼 제목
            Text(buttonTitle)
                .font(.system(size: 17, weight: .semibold))
                .padding(.leading, -140)
                .foregroundColor(.ashGrey)
            
            //버튼에 관하여
            Button(action: buttonAction) {
                //버튼 내의 이미지
                Image(systemName: buttonImage)
                    .resizable()
                    .renderingMode(.original) // 이미지를 원본 모드로 렌더링
                    .aspectRatio(contentMode: .fit) // 이미지 비율을 유지하면서 화면에 맞게 조정
                    .frame(width: 45, height: 35) // 이미지 크기를 45*35로 지정
                    .fontWeight(.semibold)
                    .padding() // 이미지 주위에 padding을 추가
                
            }//버튼 속성
            .frame(width: 285, height: 138)
            .foregroundColor(.white)
            .background(Color.orangeYellow)
            .cornerRadius(10)
            
        }
    }
}

//모달뷰
//struct ModalView: View {
//    @State private var timeElapsed: TimeInterval = 0
//    @State private var isCounting: Bool = false
//    @State private var timer: Timer? = nil
//    
//    var body: some View {
//        
//    }
//}


//실제로 보여주는 뷰
struct HomeView: View {
    @State private var showing = false
    @State private var isShowing = false //Bottomsheet
    @StateObject var audioRecorderManager = AudioRecorderManager()
    @State private var isAlertPresented = false
    @State private var permissionGranted = false
    
    var body: some View {
        NavigationStack{
            
            VStack{
                //최상단의 프로필 버튼
                Button(action: {}, label: {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .fontWeight(.semibold)
                    Text("Trudy")
                        .font(.title)
                        .bold()
                })
                .padding(.leading, -140)
                .padding(.bottom, 37)
                .foregroundColor(Color.ashGrey)
                
                NavigationLink(destination: VoiceMemoView()){
                    BtnHome(buttonImage: "record.circle",buttonAction: {print("눌려짐")}, buttonTitle: "Record")
                   
                }
                 Spacer().frame(height: 22)
                //Record, Character, Challenge 버튼
                
                NavigationLink(destination: CharacterView()){
                    
                    BtnHome(buttonImage: "person.badge.key", buttonAction: {print("두번째버튼눌려짐")}, buttonTitle: "Character")
                } 
                Spacer().frame(height: 22)
                BtnHome(buttonImage: "trophy.circle", buttonAction: {print("세번째버튼눌려짐")}, buttonTitle: "Challenge")
                
                
                //                Button(action: {
                //                    self.isShowing.toggle()
                //                }, label: {
                //                    Image(systemName: "record.circle")
                //                        .resizable() //이미지 크기를 변경하는 권한을 부여
                //                        .frame(width: 43, height: 43)
                //                        .padding(.top, 47)
                //                        .padding(.leading, 290)
                //                    
                //                })//녹음버튼
                //                .foregroundColor(Color.prettyRed)
                //                .sheet(isPresented: $isShowing) {
                //                    ZStack {
                //                        Color(Color.prettynavy)
                //                            .ignoresSafeArea()
                //                        VStack {                   
                //                            //초가 나오도록
                //                            TimerView(audioRecorderManager: audioRecorderManager, isModal: $isShowing)
                //                            RecordPermissionView()
                //                            Button("완료") {
                //                                self.isShowing.toggle() // 완료 버튼을 누르면 모달 창 닫기
                //                            }
                //                            .padding()
                //                            .foregroundColor(.white)
                //                            .background(Color.purple)
                //                            .cornerRadius(10)
                //                            .padding()
                //                        }
                //                    }
                //                }
                //                .presentationDetents([
                //                    .height(142)
                //                ])
                //                .presentationDragIndicator(.visible)
                //            }
                //            .onAppear{
                //                isShowing = false//화면 켜졌을 때는 모달창이 뜨지 않음.
                //            }
            }
            .tabItem {
                Image(systemName: "music.note.house")
                Text("Home")
                    .foregroundColor(.orangeYellow)
            }
            .tag(Tab.home)
        }
    
    }
}


//    .alert("녹음을 저장할까요?", isPresented: $showing) {
//        Button("예", role: .cancel) { 
//            print("예 버튼이 눌림") 
//        }
//        Button("아니오", role: .destructive){
//            print("아니오 버튼이 눌림")
//        }
//    }

//showing = true
