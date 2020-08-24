//
//  ContentView.swift
//  Geometry
//
//  Created by Mac on 23.08.20.
//  Copyright © 2020 peter. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @ObservedObject var getData = datas()
    
    var body: some View {
        
        NavigationView{
            
            List(getData.jsonData) {i in
                
                ListRow(id: i.id, url: i.avatar_url, name: i.login)
                
            }.navigationBarTitle("Json Parsing")
            }
        }
    }
class datas : ObservableObject {
    
    @Published var jsonData = [dataType]()
    
    init() {
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: "https://api.github.com/users/hadley/orgs")!) { (data, _, _) in
            
            do {
                let fetch = try  JSONDecoder().decode([dataType].self, from: data!)
                
                DispatchQueue.main.async {
                    self.jsonData = fetch
                    
                }
            }
            catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
}

struct dataType : Identifiable, Decodable {
    
    var id : Int
    var login : String
    var node_id : String
    var avatar_url : String
    
}
struct ListRow : View {
    
    var id: Int
    var url: String
    var name: String
    
    var body: some View{
        HStack {
            Text(String(id))
            AnimatedImage(url: URL(string: url)).resizable().frame(width: 30, height: 30)
            Text(name).fontWeight(.heavy).padding(.leading, 10)
            
        }
    }
}
        

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
