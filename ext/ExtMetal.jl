module ExtMetal

using Metal
using KAUtils

function KAUtils.get_backend_impl(::KAUtils.MetalImpl)
    return MetalBackend()
end

end