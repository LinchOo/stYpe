//
//  ContentView.swift
//  stYpe
//
//  Created by Олег Коваленко on 26.01.2023.
//

import SwiftUI
import AVKit

struct ContentView: View {
    let player = AVPlayer(url: Bundle.main.url(forResource: "stype", withExtension: "mp4")!)
    private let playerItemForward = AVPlayerItem(url: Bundle.main.url(forResource: "stype", withExtension: "mp4")!)
    private let playerItemBackward = AVPlayerItem(url: Bundle.main.url(forResource: "Rstype", withExtension: "mp4")!)
    
    
    @State var videoCurrentTime = 0.0
    @State var Index = 0
    @State var data = DataModel()
    @State var oldIndex = 0
    
    @State var isPlaying = false
    @State var isStated = false
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(.red)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.white)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.white)], for: .normal)
    }
    
    
    //------------////------------////------------////------------////------------//
    var body: some View {
        
        VStack{
            Image("logo3")
                .resizable()
            //.background(.white)
                .foregroundColor(.white)
                .frame(width: 100,height: 50)
            
            VStack{
                VideoPlayer(player: player)
                    .disabled(true)
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 800)
                    .offset(x: -190)
                    .clipShape(Rectangle())
                
            }.onAppear(){
                Play(0,0)
            }
            .ignoresSafeArea(.all, edges: .top)
            .frame(height: 400)
            .clipShape(Rectangle())
            .zIndex(1)
            VStack(spacing: 20, content: {
                TabView(selection: Binding(get: {
                    Index
                }, set: { newValue in
                    oldIndex = Index
                    Index = newValue
                    Play(Index, oldIndex)
                    
                })){
                    ForEach(0..<data.segmenIndexesArray.count, id:\.self){
                        info.tag($0)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .offset(y:50)
                Spacer()
                
                Picker(selection: Binding(get: {
                    Index
                }, set: { newValue in
                    oldIndex = Index
                    Index = newValue
                    Play(Index, oldIndex)
                    
                    
                }), label: Text("")) {
                    ForEach(0..<data.segmenIndexesArray.count, id:\.self){
                        Text(data.segmenIndexesArray[$0]).tag($0)
                    }
                }.pickerStyle(SegmentedPickerStyle())//.padding()
                    .frame(width: 405)
                
                
            })
            .frame(height: UIScreen.main.bounds.maxY / 2 - 80)
            .clipShape(Rectangle())
            .background(Color.gray.opacity(0.13))
            .cornerRadius(50)
            .offset(y:-40)
            .disabled(isPlaying)
            
            bt
                .frame(height: 50)
                .offset(y:-25)
            Spacer()
            
        }
        .frame(width: UIScreen.main.bounds.maxX,height: UIScreen.main.bounds.maxY)
        .background(Color.black)
        .ignoresSafeArea(.all, edges: .all)
        
    }
    
    
    
    //------////------// INFO  //------////------//
    
    
    var info: some View {
        
        VStack{
            
            Text(data.titleArray[Index])
                .foregroundColor(.white)
                .frame(height: 30,alignment: .center)
                .font(.system(size: 19, weight: .medium, design: .serif))
                .padding(.horizontal,3)
                .minimumScaleFactor(0.1)
            
            Spacer()
            Text(data.secondTitleArray[Index])
                .frame(height: 50)
                .font(.system(size: 20, weight: .none, design: .default))
                .foregroundColor(.white.opacity(0.5))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .minimumScaleFactor(0.2)
            
            Text(data.descriptionArray[Index])
                .font(.system(size: 18, weight: .none, design: .default))
                .foregroundColor(.white.opacity(0.4))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .minimumScaleFactor(0.4)
            Spacer()
        }
        .padding(.top,10)
    }
    
    //---------////---------//Buttons//---------////---------//
    var bt : some View{
        ZStack{
            Button {
                // onPress
            } label: {
                Image(systemName: "bag.badge.plus")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 20,height: 20)
                    .padding()
                    .clipShape(Circle())
                    .rotationEffect(Angle.degrees(isStated ? 0 : -90))
            }
            .background(Circle().fill(.red).shadow(color: .black.opacity(0.5), radius: 8))
            .offset(x: isStated ? 75 : 0, y: 0 )
            .opacity(isStated ? 1 : 0)
            Button{
                // onPress
            } label: {
                Image(systemName: "calendar.badge.plus")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 25,height: 25)
                    .padding()
                    .clipShape(Circle())
                    .rotationEffect(Angle.degrees(isStated ? 0 : -90))
            }
            .background(Circle().fill(.red).shadow(color: .black.opacity(0.5), radius: 8))
            .offset(x: isStated ? -75 : 0, y: 0 )
            .opacity(isStated ? 1 : 0)
            
            // Main Button
            Button{
                withAnimation(.spring()) {
                    isStated.toggle()
                }
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 20,height: 20)
                    .padding()
                    .clipShape(Circle())
                    .rotationEffect(Angle.degrees(isStated ? 0 : -90))
            }
            .background(Circle().fill(.red).shadow(color: .black.opacity(0.5), radius: 8))
        }
    }
    
    
    //--------////--------// Player //--------////--------//
    public func Play(_ Index : Int,_ oldIndex: Int) {
        if oldIndex <= Index {
            switch Index {
            case 0:
                playSetup(0,3, 1)
            case 1:
                playSetup(3,4,1)
            case 2:
                playSetup(7,3,1)
            case 3:
                playSetup(11,6,1)
            case 4:
                playSetup(17,3,1)
            case 5:
                playSetup(20,4,1)
            case 6:
                playSetup(24,4,1)
            default:
                break
            }
        } else {
            switch Index {
            case 0:
                playSetup(20, 3, -1)
            case 1:
                playSetup(17, 4, -1)
            case 2:
                playSetup(11, 5, -1)
            case 3:
                playSetup(7, 4, -1)
            case 4:
                playSetup(3, 4, -1)
            case 5:
                playSetup(0, 2, -1)
            default:
                break
            }
        }
    }
    private func playSetup(_ setCurrentTime: Double, _ timeInterval: Double , _ setRate: Float){
        if setRate == 1 {
            player.replaceCurrentItem(with: playerItemForward)
        } else {
            player.replaceCurrentItem(with: playerItemBackward)
        }
        player.seek(to: CMTime(value: CMTimeValue(setCurrentTime), timescale: 1), toleranceBefore: .zero, toleranceAfter: .zero)
        player.playImmediately(atRate: 1.0)
        isPlaying = true
        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { timer in
            player.pause()
                isPlaying = false
        }
    }
}

/* forward
0.01 - 0.03
0.03 - 0.07
0.07 - 0.11
0.11 - 0.17
0.17 - 0.20
0.20 - 0.24
0.24 - 0.28
*/
/* forward
0.20 - 0.24
0.16 - 0.20
0.11 - 0.16
0.07 - 0.11
0.03 - 0.07
0.00 - 0.03
*/


//------------////------------////------------////------------////------------//
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
