import Foundation

public indirect enum List<A> {
    case Cons(A, List<A>)
    case Nil
}

func cons<A>(head: A, _ tail: List<A>) -> List<A> {
    return List.Cons(head, tail)
}

func sum(ints: List<Int>) -> Int {
    switch ints {
    case .Nil: return 0
    case let .Cons(x, xs): return x + sum(xs)
    }
}

func product(ints: List<Int>) -> Int {
    switch ints {
    case .Nil: return 1
    case let .Cons(x, xs): return x * product(xs)
    }
}

func tail<A>(l: List<A>) -> List<A> {
    switch l {
    case .Nil: return .Nil
    case let .Cons(_, xs): return xs
    }
}

func drop<A>(l: List<A>, n: Int) -> List<A> {
    if n == 0 { return l }
    switch l {
    case let .Cons(_, xs): return drop(xs, n: n - 1)
    default:
        return l
    }
}

func dropWhile<A>(l: List<A>, f: A -> Bool) -> List<A> {
    switch l {
    case let .Cons(x, xs) where f(x): return dropWhile(xs, f: f)
    default: return l
    }
}

func append<A>(a1: List<A>, _ a2: List<A>) -> List<A> {
    switch a1 {
    case .Nil: return a2
    case let .Cons(x, xs): return cons(x, append(xs, a2))
    }
}

func reduce<A, B>(l: List<A>, _ z: B, _ f: (A,B) -> B) -> B {
    switch l {
    case .Nil: return z
    case let .Cons(x, xs): return f(x, reduce(xs, z, f))
    }
}

func sum2(ints: List<Int>) -> Int {
    return reduce(ints, 0){ $0 + $1 }
}

func product2(ints: List<Int>) -> Int {
    return reduce(ints, 1){ $0 * $1 }
}

func length<A>(l: List<A>) -> Int {
    switch l {
    case .Nil: return 0
    case let .Cons(_, xs): return length(xs) + 1
    }
}

func length2<A>(l: List<A>) -> Int {
    return reduce(l, 0){ $1 + 1 }
}

func foldLeft<A, B>(l: List<A>,_ z: B)(_ f: (B, A) -> B) -> B {
    switch l {
    case .Nil: return z
    case let .Cons(x, xs): return foldLeft(xs, f(z, x))(f)
    }
}

func sum3(l: List<Int>) -> Int {
    return foldLeft(l, 0)({ $0 + $1 })
}

func length3<A>(l: List<A>) -> Int {
    return foldLeft(l, 0)({ $0.0 + 1 })
}

func append2<A>(a1: List<A>, _ a2: List<A>) -> List<A> {
    return reduce(a1, a2){ cons($0, $1) }
}

func append3<A>(a1: List<A>, _ a2: List<A>) -> List<A> {
    return foldLeft(a1, a2)({ cons($1, $0) })
}

func addOne(l: List<Int>) -> List<Int> {
    switch l {
    case .Nil: return .Nil
    case let .Cons(x, xs): return cons(x + 1, addOne(xs))
    }
}

func double(l: List<Int>) -> List<Int> {
    switch l {
    case .Nil: return .Nil
    case let .Cons(x, xs): return cons(x * 2, double(xs))
    }
}

func map<A, B>(l: List<A>, _ f: A -> B) -> List<B> {
    switch l {
    case .Nil: return .Nil
    case let .Cons(x, xs): return cons(f(x), map(xs, f))
    }
}

func map2<A, B>(l: List<A>, _ f: A -> B) -> List<B> {
    return reduce(l, List.Nil){ cons(f($0.0), $0.1) }
}

func filter<A>(l: List<A>, _ f: A -> Bool) -> List<A> {
    switch l {
    case .Nil: return .Nil
    case let .Cons(x, xs):
        return  f(x) ? cons(x, filter(xs, f)) : filter(xs, f)
    }
}

func concat<A>(l: List<List<A>>) -> List<A> {
    return reduce(l, List.Nil){ append($0.0, $0.1) }
}

func flatMap<A, B>(l: List<A>, _ f: A -> List<B>) -> List<B> {
    return concat(map(l){ f($0) })
}
