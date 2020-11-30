//
//  ContentView.swift
//  ButtonStyle
//
//  Created by Tashnik on 11/30/20.
//

import SwiftUI

struct EmptyStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
  }
}

struct ColoredButtonStyle: ButtonStyle {
  let color: Color
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.vertical)
      .padding(.horizontal, 50)
      .background(color)
      .clipShape(RoundedRectangle(cornerRadius: 10))
      .foregroundColor(.white)
      .overlay(
        Color.black
          .opacity(configuration.isPressed ? 0.3 : 0.0)
          .clipShape(RoundedRectangle(cornerRadius: 10))
      )
  }
}

struct StripedButtonStyle: ButtonStyle {
  var offColor = Color.blue
  var onColor = Color.green
  
  func color(for configuration: Configuration) -> Color {
    configuration.isPressed ? onColor : offColor
  }
  
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      Rectangle()
        .fill(color(for: configuration))
        .frame(width: 10)
      
      configuration.label
        .padding()
        .foregroundColor(color(for: configuration))
        .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
        .font(Font.title.bold())
        .border(color(for: configuration))
    }
    .fixedSize()
    .animation(nil)
  }
}

struct PushButtonStyle: ButtonStyle {
  let lightGray = Color(white: 0.8)
  
  func makeBody(configuration: Configuration) -> some View {
    let startEdge: UnitPoint
    let endEdge: UnitPoint
    
    if configuration.isPressed {
      startEdge = UnitPoint.bottomTrailing
      endEdge = UnitPoint.topLeading
    } else {
      startEdge = UnitPoint.topLeading
      endEdge = UnitPoint.bottomTrailing
    }
    
    return configuration.label
      .foregroundColor(Color.black.opacity(configuration.isPressed ? 0.7 : 1.0))
      .font(.largeTitle)
      .padding(40)
      .background(LinearGradient(gradient: Gradient(colors: [lightGray, Color.white]), startPoint: startEdge, endPoint: endEdge))
      .overlay(
        Circle()
          .stroke(
            LinearGradient(gradient: Gradient(colors: [Color.white, lightGray]), startPoint: startEdge, endPoint: endEdge), lineWidth: 16
          )
          .padding(2)
          .overlay(
            Circle()
              .stroke(configuration.isPressed ? Color.black : Color.gray, lineWidth: 4)
          )
      )
      .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
      .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
      .shadow(color: Color.black.opacity(configuration.isPressed ? 0 : 0.2), radius: 10, x: 10, y: 10)
      .animation(nil)
  }
}

extension Color {
  static let classicRed = Color(red: 0.65, green: 0, blue: 0.075)
  static let classicGreen = Color(red: 0.1, green: 0.6, blue: 0.1)
  static let classicBlue = Color(red: 0.0, green: 0.2, blue: 0.7)
}

struct GlassButtonStyle: ButtonStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.label
                .font(Font.largeTitle.bold())
                .foregroundColor(color)
                .offset(x: -1, y: -1)

            configuration.label
                .font(Font.largeTitle.bold())
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            color
                .overlay(
                    LinearGradient(gradient: Gradient(stops: [
                        Gradient.Stop(color: Color.white.opacity(0.6), location: 0),
                        Gradient.Stop(color: Color.white.opacity(0.15), location: 0.499),
                        Gradient.Stop(color: Color.white.opacity(0), location: 0.5),
                        Gradient.Stop(color: Color.white.opacity(0), location: 0.8),
                        Gradient.Stop(color: Color.white.opacity(0.2), location: 1)
                    ]), startPoint: .top, endPoint: .bottom)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .strokeBorder(Color.white.opacity(0.4), lineWidth: 1)
                )
        )
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}


struct ContentView: View {
  var body: some View {
    
    VStack(spacing: 30) {
      
      Button {
        print("Pressed")
      } label: {
        Text("I am first button")
      }
      .buttonStyle(ColoredButtonStyle(color: .blue))
      
      Button {
        print("Pressed")
      } label: {
        Text("I am Button")
      }
      .buttonStyle(StripedButtonStyle())
      
      Button {
        print("Pressed")
      } label: {
        Image(systemName: "square.circle")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 100, height: 100)
      }
      .buttonStyle(PushButtonStyle())
      .padding()
      
      Button {
        print("Pressed")
      } label: {
        HStack {
          Image(systemName: "phone.down.fill")
          Text("End Call")
        }
      }
      .buttonStyle(GlassButtonStyle(color: .classicRed))
      .padding(.horizontal)
    }
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
