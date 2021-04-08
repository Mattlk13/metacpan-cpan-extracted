#pragma once
#include "base.h"
#include <panda/optional.h>

namespace xs {

// typemap for optional<T>
template <class TYPE> struct Typemap<panda::optional<TYPE>> : Typemap<TYPE> {
    static panda::optional<TYPE> in (SV* arg) {
        if (!SvOK(arg)) return {};
        return Typemap<TYPE>::in(arg);
    }
    static Sv out (const panda::optional<TYPE>& var, const Sv& = {}) {
        if (!var) return Sv::undef;
        return Typemap<TYPE>::out(*var);
    }
};

// not-null wrapper for use in input typemaps
template <class T>
struct nn {
    nn () {}
    nn (const nn&) = default;
    nn (nn&&)      = default;

    template <class U>
    nn (const nn<U>& oth) : val(oth.val) {}

    template <class U>
    nn (nn<U>&& oth) : val(std::move(oth.val)) {}

    template <class U>
    nn (U&& val) : val(std::forward<U>(val)) {}

    nn& operator= (const nn&) = default;
    nn& operator= (nn&&)      = default;

    template <class U>
    nn& operator= (U&& v) {
        val = std::forward<U>(v);
        return *this;
    }

    decltype(*T()) operator*  () { return *val; }
    T&             operator-> () { return val; }

    operator T () { return val; }

protected:
    T val;
};

template <class TYPE> struct Typemap<nn<TYPE>> : Typemap<TYPE> {
    static TYPE in (SV* arg) {
        auto ret = Typemap<TYPE>::in(arg);
        if (!ret) throw "invalid value: undef not allowed";
        return ret;
    }
    static Sv out (TYPE& var, const Sv& = {}) = delete;
};

}
