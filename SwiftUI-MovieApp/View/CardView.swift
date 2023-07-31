import SwiftUI

struct CardView: View {
    
    var image: URL
    var title: String
    
    public init(
        image: URL,
        title: String
    ) {
        self.image = image
        self.title = title
    }
    
    var body: some View {
        VStack {
            if #available(iOS 15.0, *) {
                AsyncImage(url: image).fixedSize()
            } else {
                // Fallback on earlier versions
            }
 
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .layoutPriority(100)
 
                Spacer()
            }
            .padding()
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
        .padding([.top, .horizontal])
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(image: URL(string: "https://m.media-amazon.com/images/M/MV5BNjM0NTc0NzItM2FlYS00YzEwLWE0YmUtNTA2ZWIzODc2OTgxXkEyXkFqcGdeQXVyNTgwNzIyNzg@._V1_SX300.jpg")!, title: "SwiftUI")
    }
}
