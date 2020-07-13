//
//  widget.swift
//  widget
//
//  Created by swiftcafe on 2020/7/12.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    public typealias Entry = SimpleEntry

    public func snapshot(with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    
    public func timeline(with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 60 {
            let entryDate = Calendar.current.date(byAdding: .second, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
}

struct PlaceholderView : View {
    
    var body: some View {
        
        ZStack {
            Image("bg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        }
        
    }
}

struct widgetEntryView : View {
    var entry: Provider.Entry
    
    static let taskDateFormat: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            return formatter
    }()
    var body: some View {
        
        ZStack {
            Image("bg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            Text("\(entry.date, formatter: Self.taskDateFormat)")
                .font(.system(size: 25))
                .foregroundColor(.white)
                .padding(.top, 90)
        }
    }
    
}


//struct widgetEntryView : View {
//    var entry: Provider.Entry
//
//    var body: some View {
//
//        Text(entry.date, style: .time)
//    }
//}

@main
struct widget: Widget {
    private let kind: String = "widget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(), placeholder: PlaceholderView()) { entry in
            widgetEntryView(entry: entry)
        }
//        .configurationDisplayName("My Widget")
//        .description("This is an example widget.")
        .configurationDisplayName("桌面时钟")
        .description("可以在桌面显示的实时时钟.")
        .supportedFamilies([.systemSmall])
    }
}

//struct widget_Previews: PreviewProvider {
//    static var previews: some View {
//        widgetEntryView(entry: SimpleEntry(date: Date()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
