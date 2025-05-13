//
//  Main_Page.swift
//  To-Do_App
//
//  Created by Hakan Demir on 29.04.2025.
//

import SwiftUI



struct Main_Page: View {
    
    @State private var TaskHeader: String = ""
    @State private var taskText: String = ""
    @State private var tasks: [String] = []
    @State private var type: String = "Work"
    
    let types = ["Work", "Personal", "Study"]

    let tasksKey = "saved_tasks"
    
    
    var body: some View {
        
        NavigationView{
            VStack(spacing: 10){
                List{
                    Section(header: Text("Add Task")) {
                        
                        TextField("Heeading", text: $TaskHeader)
                        
                        Picker("Select Type", selection: $type) {
                            ForEach(types,id: \.self){ Text($0)}
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        TextField("Task" ,text: $taskText)
                        
                        Button(action: addTask) {
                            Text("Add Task")
                                .frame( maxWidth: .infinity)
                                .padding()
                                .background(Color.secondary)
                                .foregroundStyle(.white)
                                .cornerRadius(10)
                        }
                        
                        Section(header: Text("Task List")) {
                            ForEach(tasks.indices, id: \.self) {index in
                                NavigationLink(destination: TaskDetailPage(task: tasks[index])){
                                 Text(tasks[index])
                                        .lineLimit(1)
                                }
                                
                            }
                            .onDelete(perform: onDelete)
                        }
                        
                    }
                }
            }
            .navigationTitle("Tasker")
            .navigationBarTitleDisplayMode(.automatic)
            .onAppear(perform: loadTasks)
        }
        
    }
    
    
    func addTask(){
        if !TaskHeader.isEmpty && !taskText.isEmpty{
            let newTask = "\(TaskHeader) - \(type) \(taskText)"
            tasks.append(newTask)
            TaskHeader = ""
            taskText = ""
            saveTasks()
        }
    }
    
    func saveTasks(){
        UserDefaults.standard.set(tasks, forKey: "taskkey")
    }
    
    func loadTasks(){
        if let saved = UserDefaults.standard.stringArray(forKey: "taskkey"){
            tasks = saved
        }
    }
    
    func onDelete(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        saveTasks()
    }
    
    
    struct TaskDetailPage: View {
        let task: String

        var body: some View {
            ScrollView {
                Text(task)
                    .padding()
                    .font(.body)
            }
            .navigationTitle("Görev Detayı")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    


}

#Preview {
    Main_Page()
}
