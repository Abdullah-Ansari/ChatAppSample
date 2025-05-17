//
//  CoreDataManager.swift
//  ChatAppSample
//
//  Created by Abdullah Ansari on 13/05/25.
//

import Foundation
import CoreData

protocol LocalManager {
    
}


final class CoreDataManager: LocalManager {
    static let shared = CoreDataManager()
    private init() { }

    enum ContextType {
        case main
        case background

        var context: NSManagedObjectContext {
            switch self {
            case .main: return CoreDataManager.shared.mainContext
            case .background: return CoreDataManager.shared.backgroundContext
            }
        }
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ChatAppModel")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved Error: \(error) \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()

    var mainContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    private lazy var _backgroundContext: NSManagedObjectContext = {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        return context
    }()

    var backgroundContext: NSManagedObjectContext {
        _backgroundContext
    }

    // MARK: - CRUD

    func save(contextType: ContextType = .main) {
        let context = contextType.context
        guard context.hasChanges else { return }
        do {
            try context.save()
            print("✅ Context saved successfully")
        } catch {
            print("❌ Failed to save context: \(error.localizedDescription)")
        }
    }

    func fetch<T: NSManagedObject>(
        _ request: NSFetchRequest<T>,
        contextType: ContextType = .main
    ) -> [T]? {
        let context = contextType.context
        do {
            return try context.fetch(request)
        } catch {
            print("❌ Fetch error: \(error.localizedDescription)")
            return nil
        }
    }

    @discardableResult
    func insert<T: NSManagedObject>(into contextType: ContextType = .main) -> T {
        let context = contextType.context
        return T(context: context)
    }

    func delete(_ object: NSManagedObject, contextType: ContextType = .main) {
        let context = contextType.context
        context.delete(object)
        save(contextType: contextType)
    }

    func batchDelete<T: NSFetchRequestResult>(
        _ request: NSFetchRequest<T>,
        contextType: ContextType = .main
    ) {
        let context = contextType.context
        let fetchRequest = request as! NSFetchRequest<NSFetchRequestResult>
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
        } catch {
            print("❌ Batch delete failed: \(error.localizedDescription)")
        }
    }

    func batchInsert(
        entityName: String,
        objects: [[String: Any]],
        completion: ((Bool) -> Void)? = nil
    ) {
        let context = backgroundContext
        context.perform {
            let request = NSBatchInsertRequest(entityName: entityName, objects: objects)
            request.resultType = .statusOnly
            do {
                if let result = try context.execute(request) as? NSBatchInsertResult, result.result as? Bool == true {
                    print("✅ Batch insert into \(entityName) successful")
                    completion?(true)
                } else {
                    print("⚠️ Batch insert into \(entityName) failed")
                    completion?(false)
                }
            } catch {
                print("❌ Batch insert error for \(entityName): \(error)")
                completion?(false)
            }
        }
    }

    func batchUpdate(
        entityName: String,
        predicate: NSPredicate?,
        propertiesToUpdate: [AnyHashable: Any],
        contextType: ContextType = .main
    ) {
        let context = contextType.context
        let updateRequest = NSBatchUpdateRequest(entityName: entityName)
        updateRequest.predicate = predicate
        updateRequest.propertiesToUpdate = propertiesToUpdate
        updateRequest.resultType = .updatedObjectIDsResultType
        do {
            let result = try context.execute(updateRequest) as? NSBatchUpdateResult
            if let objectIDs = result?.result as? [NSManagedObjectID] {
                let changes: [AnyHashable: Any] = [NSUpdatedObjectsKey: objectIDs]
                NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
            }
        } catch {
            print("❌ Batch update failed: \(error.localizedDescription)")
        }
    }

    func resetContext(_ contextType: ContextType = .main) {
        let context = contextType.context
        context.reset()
        print("🔄 Context reset")
    }
}
