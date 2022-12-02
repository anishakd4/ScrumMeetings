//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by Anish kumar dubey on 29/11/22.
//

import SwiftUI

struct DetailEditView: View{
    
    @Binding var data: DailyScrum.Data
    @State private var newAttendeename = ""
    
    var body: some View{
        Form{
            Section(header: Text("Meeting Info")){
                TextField("Title", text: $data.title)
                HStack{
                    Slider(value: $data.lengthInMinutes, in: 5...30, step: 1){
                        Text("Length")
                    }
                    .accessibilityValue("\(Int(data.lengthInMinutes)) minutes")
                    Spacer()
                    Text("\(Int(data.lengthInMinutes)) minutes")
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $data.theme)
                    
            }
            Section(header: Text("Attendees")){
                ForEach(data.attendees){ attendee in
                    Text(attendee.name)
                }
                .onDelete{ indices in
                    data.attendees.remove(atOffsets: indices)
                }
                HStack{
                    TextField("New Attendee", text: $newAttendeename)
                    Button(action: {
                        withAnimation{
                            let attendee = DailyScrum.Attendee(name:newAttendeename)
                            data.attendees.append(attendee)
                            newAttendeename = ""
                        }
                    }){
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(newAttendeename.isEmpty)
                }
            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider{
    static var previews: some View{
        DetailEditView(data: .constant(DailyScrum.sampleData[0].data))
    }
}
