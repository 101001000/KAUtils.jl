function ArrayConstructor(backend, arr)
    d_arr = KA.allocate(backend, eltype(arr), size(arr))
    KA.copyto!(backend, d_arr, arr)
    KA.synchronize(backend)
    return d_arr
end

function ArrayConstructor(backend, T::Type, ::UndefInitializer, dims...)
    d_arr = KA.allocate(backend, T, dims...)
    return d_arr
end

zeros(backend, T::Type, dims...) = KA.zeros(backend, T, dims...)
zeros(backend, dims...) = KA.zeros(backend, Float32, dims...)
ones(backend, T::Type, dims...) = KA.ones(backend, T, dims...)
ones(backend, dims...) = KA.ones(backend, Float32, dims...)

