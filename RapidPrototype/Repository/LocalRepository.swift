//
//  LocalRepository.swift
//  RapidPrototype
//
//  Created by Mykhailo Kotov on 24/10/2024.
//

import Foundation
import CoreData

class LocalRepository: Repository {
    func fetchUsers() async throws -> [UserDTO] {
        let request: NSFetchRequest<User> = User.fetchRequest()
        let users = try context.fetch(request)
        return users.map(mapToDTO)
    }

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = CoreDataManager.shared.viewContext) {
        self.context = context
        if !UserDefaults.standard.bool(forKey: "coredataPreloaded") {
            preloadCoreData()
            UserDefaults.standard.set(true, forKey: "coredataPreloaded")
        }
    }

    private func mapToDTO(_ user: User) -> UserDTO {
        let measurements = user.measurements?.allObjects as? [MeasurementItem] ?? []
        return UserDTO(
            name: user.name ?? "noname",
            measurements: measurements
                .map {
                    MeasurementDTO(
                        date: $0.date ?? Date(),
                        systolic: $0.systolic,
                        diastolic: $0.diastolic,
                        pulse: $0.pulse)
                }
                .sorted(by: {$0.date<$1.date})

        )
    }

    private func preloadCoreData() {
        let users: [UserDTO] = [
            UserDTO(
                name: "Stefan",
                measurements: [
                    MeasurementDTO(date: "18.4.2022 7:45".toDate, systolic: 134, diastolic: 88, pulse: 87),
                    MeasurementDTO(date: "18.4.2022 18:22".toDate, systolic: 144, diastolic: 89, pulse: 88),
                    MeasurementDTO(date: "19.4.2022 8:01 ".toDate, systolic: 138, diastolic: 87, pulse: 92),
                    MeasurementDTO(date: "19.4.2022 16:40".toDate, systolic: 149, diastolic: 95, pulse: 89),
                    MeasurementDTO(date: "20.4.2022 8:24".toDate, systolic: 132, diastolic: 92, pulse: 91),
                    MeasurementDTO(date: "20.4.2022 17:15".toDate, systolic: 151, diastolic: 96, pulse: 93),
                    MeasurementDTO(date: "21.4.2022 7:55".toDate, systolic: 142, diastolic: 94, pulse: 88),
                    MeasurementDTO(date: "21.4.2022 18:16".toDate, systolic: 168, diastolic: 97, pulse: 87),
                    MeasurementDTO(date: "22.4.2022 7:48".toDate, systolic: 154, diastolic: 102, pulse: 92),
                ]),
            UserDTO(
                name: "Elena",
                measurements: [
                    MeasurementDTO(date: "18.4.2022 7:25".toDate, systolic: 112, diastolic: 80, pulse: 67),
                    MeasurementDTO(date: "18.4.2022 19:44".toDate, systolic: 110, diastolic: 79, pulse: 68),
                    MeasurementDTO(date: "19.4.2022 8:28 ".toDate, systolic: 98, diastolic: 78, pulse: 64),
                    MeasurementDTO(date: "19.4.2022 17:14".toDate, systolic: 110, diastolic: 82, pulse: 63),
                    MeasurementDTO(date: "20.4.2022 8:11".toDate, systolic: 112, diastolic: 83, pulse: 64),
                    MeasurementDTO(date: "20.4.2022 17:35".toDate, systolic: 160, diastolic: 95, pulse: 85),
                    MeasurementDTO(date: "21.4.2022 7:49".toDate, systolic: 113, diastolic: 82, pulse: 62),
                    MeasurementDTO(date: "21.4.2022 17:47".toDate, systolic: 122, diastolic: 81, pulse: 64),
                    MeasurementDTO(date: "22.4.2022 8:38".toDate, systolic: 121, diastolic: 84, pulse: 71),
                ])
        ]
        for userDTO in users {
            let newUser = User(context: context)

            newUser.name = userDTO.name
            for measurementDTO in userDTO.measurements {
                let newMeasurement = MeasurementItem(context: context)

                newMeasurement.date = measurementDTO.date
                newMeasurement.systolic = measurementDTO.systolic ?? 0
                newMeasurement.diastolic = measurementDTO.diastolic ?? 0
                newMeasurement.pulse = measurementDTO.pulse ?? 0
                newMeasurement.user = newUser
                newUser.measurements?.adding(newMeasurement)
            }
            do {
                try context.save()
                print("New user added successfully")
            } catch {
                print("Failed to save new user: \(error)")
            }
        }
    }
}

extension String {
    fileprivate var toDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        return dateFormatter.date(from:self)!
    }
}
