import SwiftUI
import AVFoundation


struct VoiceMemoView: View {
    @StateObject var audioRecorderManager = AudioRecorderManager()
    
    var body: some View {
        VStack(spacing: 20) {
            RecordPermissionView()
            /// 타이틀 뷰
            RecordingTitleView()
            
            /// 현재 메모 진행중 상태 뷰
            RecordingStatusView(audioRecorderManager: audioRecorderManager)
            
            /// 음성메모 버튼 뷰
            RecordingButtonView(audioRecorderManager: audioRecorderManager)
            
            /// 메모 리스트 뷰
            RecordingListView(audioRecorderManager: audioRecorderManager)
        }
        .padding()
    }
}


struct RecordPermissionView: View {
    @State private var isAlertPresented = false
    @State private var permissionGranted = false
    
    var body: some View {
        VStack {
            if !permissionGranted {
                Text("녹음 권한을 허용해주세요.")
                    .padding()
                
                Button("녹음 권한 요청") {
                    isAlertPresented = true
                }
                .padding()
            } else {
                Text("녹음 권한이 허용되었습니다.")
                    .padding()
            }
        }
        .alert(isPresented: $isAlertPresented) {
            Alert(
                title: Text("녹음 권한 요청"),
                message: Text("녹음 권한을 허용하시겠습니까?"),
                primaryButton: .default(Text("허용"), action: {
                    requestPermission()
                }),
                secondaryButton: .cancel(Text("취소"))
            )
        }
    }
    
    func requestPermission() {
        Task {
            do {
                let status = try await AVAudioApplication.requestRecordPermission()
                switch status {
                case true:
                    print("녹음 권한이 허용되었습니다.")
                    permissionGranted = true
                case false:
                    print("녹음 권한이 거부되었습니다.")
                    permissionGranted = false
//                case .undetermined:
//                    print("녹음 권한이 아직 결정되지 않았습니다.")
//                    permissionGranted = false
                @unknown default:
                    print("알 수 없는 상태입니다.")
                    permissionGranted = false
                }
            } catch {
                print("녹음 권한 요청 중 오류가 발생했습니다: \(error.localizedDescription)")
                permissionGranted = false
            }
        }
    }
}

class AudioRecorderManager: NSObject, ObservableObject, AVAudioPlayerDelegate {
    /// 음성메모 녹음 관련 프로퍼티
    var audioRecorder: AVAudioRecorder?
    @Published var isRecording = false
    
    /// 음성메모 재생 관련 프로퍼티
    var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false
    @Published var isPaused = false
    
    /// 음성메모된 데이터
    var recordedFiles = [URL]()
    
    // MARK: - 음성메모 녹음 관련 메서드
    func startRecording() {
        let fileURL = getDocumentsDirectory().appendingPathComponent("\(Date().hashValue).m4a")
        // 파일 경로 출력
        print("녹음 파일 경로: \(fileURL.path)")
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: fileURL, settings: settings)
            audioRecorder?.record()
            self.isRecording = true
            
        } catch {
            print("녹음 중 오류 발생: \(error.localizedDescription)")
        }
    }
    
    
    
    func stopRecording() {
        audioRecorder?.stop()
        self.recordedFiles.append(self.audioRecorder!.url)
        // 추가된 파일 경로 출력
        print("추가된 파일 경로: \(self.audioRecorder!.url.path)")
        self.isRecording = false
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // MARK: - 음성메모 재생 관련 메서드
    func startPlaying(recordingURL: URL) {
        do {
            print(recordingURL)
            audioPlayer = try AVAudioPlayer(contentsOf: recordingURL)
            audioPlayer?.delegate = self
            audioPlayer?.play()
            self.isPlaying = true
            self.isPaused = false
            print("재생됨")
        } catch {
            print("재생 중 오류 발생: \(error)")
        }
    }
    
    func stopPlaying() {
        audioPlayer?.stop()
        self.isPlaying = false
    }
    
    func pausePlaying() {
        audioPlayer?.pause()
        self.isPaused = true
    }
    
    func resumePlaying() {
        audioPlayer?.play()
        self.isPaused = false
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.isPlaying = false
        self.isPaused = false
    }
}





// MARK: - 음성메모 타이틀 뷰
private struct RecordingTitleView: View {
    var body: some View {
        HStack {
            Text("음성 메모")
                .font(.largeTitle)
        }
    }
}

// MARK: - 음성메모 현재 상태 뷰
private struct RecordingStatusView: View {
    @ObservedObject var audioRecorderManager: AudioRecorderManager
    
    var body: some View {
        if audioRecorderManager.isRecording {
            Text("음성메모 중")
                .foregroundColor(.red)
        } else {
            Text("음성메모 준비")
        }
    }
}

// MARK: - 음성메모 버튼 뷰
private struct RecordingButtonView: View {
    @ObservedObject var audioRecorderManager: AudioRecorderManager
    
    var body: some View {
        HStack {
            Button(
                action: {
                    audioRecorderManager.isRecording
                    ? audioRecorderManager.stopRecording()
                    : audioRecorderManager.startRecording()
                }
            ) {
                Text(audioRecorderManager.isRecording ? "음성메모 종료" : "음성메모 시작")
                    .foregroundColor(.white)
                    .padding()
                    .background(audioRecorderManager.isRecording ? Color.red : Color.blue)
                    .cornerRadius(10)
            }
        }
    }
}

// MARK: - 음성메모 리스트 뷰
private struct RecordingListView: View {
    @ObservedObject var audioRecorderManager: AudioRecorderManager
    
    var body: some View {
        Text("음성메모 리스트")
            .font(.title)
            .padding()
        
        List {
            ForEach(audioRecorderManager.recordedFiles, id: \.self) { recordedFile in
                Button(
                    action: {
                        if audioRecorderManager.isPlaying && audioRecorderManager.audioPlayer?.url == recordedFile {
                            audioRecorderManager.isPaused
                            ? audioRecorderManager.resumePlaying()
                            : audioRecorderManager.pausePlaying()
                        } else {
                            audioRecorderManager.startPlaying(recordingURL: recordedFile)
                        }
                    }
                ) {
                    Text(recordedFile.lastPathComponent)
                        .foregroundColor(
                            audioRecorderManager.isPlaying && audioRecorderManager.audioPlayer?.url == recordedFile
                            ? (audioRecorderManager.isPaused ? .green : .red)
                            : .black
                        )
                }
            }
        }
    }
}

struct VoiceMemoView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceMemoView()
    }
}

