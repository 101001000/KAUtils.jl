export free_memory

struct Device
    ordinal::Integer
    function Device(ordinal::Integer)
        new(ordinal)
    end
end

function device()
    return Device(0)
end

function devices()
    return [device()]
end

function name(dev::Device)
    return "Un-implemented device name functionality"
end



function free_memory()
    return free_memory(selected_backend)
end
function free_memory(backend::KA.CPU)
    return Sys.free_memory()
end
function free_memory(backend::KA.Backend)
    default_free_memory = 4096 * 2^20
    @warn "free_memory not implemented for this GPU backend, a defautl value of 4GB is used."
    return default_free_memory
end