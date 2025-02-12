module ExtCUDA

using CUDA
using KAUtils

function KAUtils.get_backend_impl(::KAUtils.CUDAImpl)
    return CUDABackend()
end

function KAUtils.free_memory(backend::CUDABackend)
    return CUDA.free_memory()
end


end