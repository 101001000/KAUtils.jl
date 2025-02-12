export available_backends, backend, backend!, default_backend

abstract type KAImpl end
struct CPUImpl <: KAImpl end
struct CUDAImpl <: KAImpl end
struct AMDGPUImpl <: KAImpl end
struct oneAPIImpl <: KAImpl end
struct MetalImpl <: KAImpl end

global selected_backend = nothing

function backend()
    global selected_backend
    if isnothing(selected_backend)
        selected_backend = default_backend()
    end
    return selected_backend
end

function backend!(backend::KA.Backend)
    global selected_backend = backend
end

function get_backend_impl(::KAImpl)
    return nothing
end
function get_backend_impl(::CPUImpl)
    return KA.CPU()
end

macro nothrow(expr)
    quote
        try
            $(esc(expr))
        catch
            # Ignore the error
        end
    end
end

function available_backends()
    backends = KA.Backend[]
    @nothrow push!(backends, get_backend_impl(CPUImpl()))
    @nothrow push!(backends, get_backend_impl(CUDAImpl()))
    @nothrow push!(backends, get_backend_impl(AMDGPUImpl()))
    @nothrow push!(backends, get_backend_impl(oneAPIImpl()))
    @nothrow push!(backends, get_backend_impl(MetalImpl()))       
    return backends
end

function default_backend()

    backend_var = get(ENV, "KA_BACKEND", "default")

    default_backend = if length(available_backends()) > 1
        available_backends()[2]
    else
        available_backends()[1]
    end
    
    if backend_var == "CPU"
        return get_backend_impl(CPUImpl())
    elseif backend_var == "CUDA"
        return get_backend_impl(CUDAImpl())
    elseif backend_var == "ROCM"
        return get_backend_impl(AMDGPUImpl())
    elseif backend_var == "ONEAPI"
        return get_backend_impl(oneAPIImpl())
    elseif backend_var == "METAL"
        return get_backend_impl(MetalImpl())
    elseif backend_var != "default"
        @error "Unknown backend: " * backend_var * ", using default"
    end

    return default_backend
end