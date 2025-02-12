module KAUtils
    import KernelAbstractions as KA

    include("Backends.jl")
    include("Device.jl")
    include("Arrays.jl")

    function array2tuple(a::Array)
        (a...,)
    end

    # Multiply two tuples (making scalars 1 dim tuples) elementwise, and if they have different size, return the rest of the elements of the biggest tuple unchanged.
    function tuple_mult(A, B)
        if isnothing(A)
            A = 1
        end
        if isnothing(B)
            B = 1
        end
        lA = length(A) == 1 ? [A[1]] : collect(A)
        lB = length(B) == 1 ? [B[1]] : collect(B)
        b = length(lA) >= length(lB) ? lA : lB
        s = length(lA) < length(lB) ? lA : lB
        if length(b) == 1
            return b[1] * s[1]
        end
        for i in eachindex(s)
            b[i] *= s[i]
        end
        return array2tuple(b)
    end

end
