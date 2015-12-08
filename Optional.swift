
import Foundation

enum Optional<A> {
    case Some(A)
    case None
}

extension Optional {
    func map<B>(f: A -> B) -> Optional<B> {
        switch self {
        case .None: return .None
        case let .Some(value): return .Some(f(value))
        }
    }
    
    func filter(f: A -> Bool) -> Optional<A> {
        switch self {
        case .None: return .None
        case let .Some(value): return f(value) ? .Some(value) : .None
        }
    }
    
    func flatMap<B>(f: A -> Optional<B>) -> Optional<B> {
        switch self {
        case .None: return .None
        case let .Some(value): return f(value)
        }
    }
}
