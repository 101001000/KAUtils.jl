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
    # Return first GPU backend if not, CPU backend
    if length(available_backends()) > 1
        return available_backends()[2]
    else
        return available_backends()[1]
    end
end