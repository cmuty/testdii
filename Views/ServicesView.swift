import SwiftUI

struct ServicesView: View {
    @State private var searchText = ""
    
    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "C8E6F5"),
                    Color(hex: "E8F5FC")
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                // Header
                Text("Сервіси")
                    .font(.system(size: 34, weight: .bold))
                    .padding(.horizontal, 20)
                    .padding(.top, 60)
                    .padding(.bottom, 16)
                
                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray.opacity(0.6))
                    
                    TextField("Пошук", text: $searchText)
                        .font(.system(size: 17))
                }
                .padding(12)
                .background(Color.white.opacity(0.8))
                .cornerRadius(12)
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
                
                // Services grid
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 12),
                        GridItem(.flexible(), spacing: 12)
                    ], spacing: 12) {
                        ForEach(filteredServices) { service in
                            ServiceCard(service: service)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 100)
                }
            }
        }
    }
    
    var filteredServices: [Service] {
        if searchText.isEmpty {
            return Service.allServices
        } else {
            return Service.allServices.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}

struct ServiceCard: View {
    let service: Service
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            // Icon
            ZStack {
                Circle()
                    .fill(Color.black)
                    .frame(width: 44, height: 44)
                
                Image(systemName: service.icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
            }
            
            // Name
            Text(service.name)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.black)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.7))
        )
    }
}

struct Service: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    
    static let allServices: [Service] = [
        Service(name: "Допомога армії", icon: "shield.fill"),
        Service(name: "Незламність", icon: "bolt.fill"),
        Service(name: "Військові облігації", icon: "flag.fill"),
        Service(name: "Лінія дронів", icon: "airplane"),
        Service(name: "Національний кешбек", icon: "barcode"),
        Service(name: "Чатбот еВорог", icon: "target"),
        Service(name: "eВідновлення", icon: "percent"),
        Service(name: "Відшкодування збитків", icon: "dollarsign.circle.fill"),
        Service(name: "Ветеранський спорт", icon: "figure.strengthtraining.traditional"),
        Service(name: "Водієві", icon: "bus.fill"),
        Service(name: "Місце проживання", icon: "house.fill"),
        Service(name: "Опитування", icon: "checkmark.circle.fill"),
        Service(name: "Допомога від держави", icon: "shield.slash.fill"),
        Service(name: "Шлюб онлайн", icon: "circle.fill"),
        Service(name: "Послуги для ВПО", icon: "shippingbox.fill"),
        Service(name: "Податки", icon: "briefcase.fill"),
        Service(name: "Допомога по безробіттю", icon: "hand.raised.fill"),
        Service(name: "Судові послуги", icon: "hammer.fill"),
        Service(name: "еОселя", icon: "heart.circle.fill"),
        Service(name: "Виконавчі провадження", icon: "info.circle.fill"),
        Service(name: "Довідки та витяги", icon: "doc.text.fill"),
        Service(name: "Розваги", icon: "theatermasks.fill"),
        Service(name: "Повернення вкладів", icon: "arrow.uturn.backward.circle.fill")
    ]
}

#Preview {
    ServicesView()
}

