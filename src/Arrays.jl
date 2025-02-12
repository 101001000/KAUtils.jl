function ArrayConstructor(backend, arr)
    d_arr = KernelAbstractions.allocate(backend, eltype(arr), size(arr))
    KernelAbstractions.copyto!(backend, d_arr, arr)
    KernelAbstractions.synchronize(backend)
    return d_arr
end

function ArrayConstructor(backend, T::Type, ::UndefInitializer, dims...)
    d_arr = KernelAbstractions.allocate(backend, T, dims...)
    return d_arr
end

zeros(backend, T::Type, dims...) = KernelAbstractions.zeros(backend, T, dims...)
zeros(backend, dims...) = KernelAbstractions.zeros(backend, Float32, dims...)
ones(backend, T::Type, dims...) = KernelAbstractions.ones(backend, T, dims...)
ones(backend, dims...) = KernelAbstractions.ones(backend, Float32, dims...)

