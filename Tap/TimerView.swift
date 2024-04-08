import SwiftUI

struct TimerView: View {
    @ObservedObject var audioRecorderManager: AudioRecorderManager
    // 경과된 시간을 나타내는 속성
    @State private var timeElapsed: TimeInterval = 0
    // 타이머가 실행 중인지 여부를 나타내는 속성
    @State private var isCounting: Bool = false
    // 타이머 객체를 저장하는 속성
    @State private var timer: Timer? = nil
    @Binding var isModal: Bool
    var body: some View {
        VStack {
            // 경과된 시간을 텍스트로 표시
            HStack{
                Image(systemName: "waveform.path")
                    .resizable()
                    .frame(width: 25,height: 22)
                    .foregroundColor(.white)
                Text("\(timeString(timeElapsed))")
            }
//             시작/정지 버튼
                        Button(action: { 
                            isModal.toggle()
                            toggleTimer()
                            print("record")
                        }, label: {
                            Text(isCounting ? "녹음 종료" : "녹음 시작")
                        })//녹음버튼
//            Button(action: {
//                if audioRecorderManager.isRecording {
//                    audioRecorderManager.stopRecording()
//                } else {
//                    audioRecorderManager.startRecording()
//                }
//            }) {
//                Text(audioRecorderManager.isRecording ? "녹음 종료" : "녹음 시작")
//            }
        }
        .padding()
        .onDisappear {
            audioRecorderManager.stopRecording()
        }
    }


// 시작/정지 버튼이 눌렸을 때 실행되는 함수
private func toggleTimer() {
    isCounting.toggle() // 타이머 상태를 토글
    
    if isCounting {
        startTimer() // 타이머 시작
    } else {
        stopTimer() // 타이머 정지
    }
}

// 타이머를 시작하는 함수
private func startTimer() {
    // 0.1초마다 실행되며 경과된 시간을 증가시키는 타이머 생성
    timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
        timeElapsed += 0.01 // 경과된 시간 증가
    }
}

// 타이머를 정지하는 함수
private func stopTimer() {
    timer?.invalidate() // 타이머 무효화
    timer = nil // 타이머 초기화
}

// TimeInterval을 받아서 분:초:밀리세컨드 형식의 문자열로 변환하는 함수
private func timeString(_ time: TimeInterval) -> String {
    let minutes = Int(time) / 60
    let seconds = Int(time) % 60
    let milliseconds = Int(time * 100) % 100
    return String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
}
}

struct TimerView_Previews: PreviewProvider {
    @Binding var isModal: Bool
    
    static var previews: some View {
        TimerView(audioRecorderManager: AudioRecorderManager(), isModal: .constant(false))
    }
}
