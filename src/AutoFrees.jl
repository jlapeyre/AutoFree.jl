module AutoFrees

export AutoFree

struct AutoFree{T, AF, FF}
    x::Ptr{T}
    _dummy::Base.RefValue{Ptr{T}}
    function AutoFree{T,AF,FF}(args...) where {T, AF, FF}
        _obj = AF.instance(args...)
        obj = new{T,AF,FF}(_obj, Ref(_obj))
        finalizer(_ -> FF.instance(_obj), obj._dummy)
        return obj
    end
end

Base.getindex(obj::AutoFree) = obj.x

# This should be kind of the same. But, it seems freeing is triggered earlier
# when we actually put an object in Ref rather than nothing.

# struct AutoFree{T, AF, FF}
#     x::Ptr{T}
#     _dummy::Base.RefValue{Nothing}
#     function AutoFree{T,AF,FF}(args...) where {T, AF, FF}
#         _obj = AF.instance(args...)
#         obj = new{T,AF,FF}(_obj, Ref(nothing))
#         finalizer(_ -> FF.instance(_obj), obj._dummy)
#         return obj
#     end
# end


end # module AutoFrees
