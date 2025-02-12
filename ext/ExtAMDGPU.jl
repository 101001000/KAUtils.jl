module ExtAMDGPU

using AMDGPU
using KAUtils

function KAUtils.get_backend_impl(::KAUtils.AMDGPUImpl)
    return ROCBackend()
end

end