module ExtoneAPI

using oneAPI
using KAUtils

function KAUtils.get_backend_impl(::KAUtils.oneAPIImpl)
    return oneAPIBackend()
end

end