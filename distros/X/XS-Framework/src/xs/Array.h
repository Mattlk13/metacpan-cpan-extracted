#pragma once
#include <xs/Scalar.h>
#include <xs/KeyProxy.h>

namespace xs {

using xs::my_perl;

struct Simple;

struct Array : Sv {
    enum create_type_t { ALIAS, COPY };

    static Array create () { return Array(newAV(), NONE); }

    static Array create (size_t cap) {
        Array ret(newAV(), NONE);
        ret.reserve(cap);
        return ret;
    }

    static Array create (size_t size, SV** content, create_type_t type = ALIAS);
    static Array create (const std::initializer_list<Scalar>& l, create_type_t type = ALIAS) { return Array(l, type); }
    static Array create (const Array& from, create_type_t type = ALIAS) { return create(from.size(), from._svlist(), type); }

    static Array noinc  (SV* val) { return Array(val, NONE); }
    static Array noinc  (AV* val) { return Array(val, NONE); }

    Array (std::nullptr_t = nullptr) {}
    Array (SV* sv, bool policy = INCREMENT) : Sv(sv, policy) { _validate(); }
    Array (AV* sv, bool policy = INCREMENT) : Sv(sv, policy) {}

    Array (const Array& oth) : Sv(oth)            {}
    Array (Array&& oth)      : Sv(std::move(oth)) {}
    Array (const Sv& oth)    : Sv(oth)            { _validate(); }
    Array (Sv&& oth)         : Sv(std::move(oth)) { _validate(); }
    Array (const Simple&)    = delete;
    Array (const Hash&)      = delete;
    Array (const Sub&)       = delete;
    Array (const Glob&)      = delete;
    Array (const Io&)        = delete;

    Array (const std::initializer_list<Scalar>& l, create_type_t type = ALIAS);

    Array& operator= (SV* val)          { Sv::operator=(val); _validate(); return *this; }
    Array& operator= (AV* val)          { Sv::operator=(val); return *this; }
    Array& operator= (const Array& oth) { Sv::operator=(oth); return *this; }
    Array& operator= (Array&& oth)      { Sv::operator=(std::move(oth)); return *this; }
    Array& operator= (const Sv& oth)    { return operator=(oth.get()); }
    Array& operator= (Sv&& oth)         { Sv::operator=(std::move(oth)); _validate(); return *this; }
    Array& operator= (const Simple&)    = delete;
    Array& operator= (const Hash&)      = delete;
    Array& operator= (const Sub&)       = delete;
    Array& operator= (const Glob&)      = delete;
    Array& operator= (const Io&)        = delete;

    void set (SV* val) { Sv::operator=(val); }

    operator AV* () const { return (AV*)sv; }
    operator HV* () const = delete;
    operator CV* () const = delete;
    operator GV* () const = delete;
    operator IO* () const = delete;

    AV* operator-> () const { return (AV*)sv; }

    template <typename T = SV> panda::enable_if_one_of_t<T,SV,AV>* get () const { return (T*)sv; }

    Scalar fetch (size_t key) const {
        if (!sv) return Scalar();
        if (key >= _size()) return Scalar();
        Scalar ret;
        ret.set(_svlist()[key]);
        return ret;
    }

    Scalar front () const { return fetch(0); }
    Scalar back  () const { return sv && _size() ? fetch(_topi()) : Scalar(); }

    Scalar at (size_t key) const {
        Scalar ret = fetch(key);
        if (!ret) throw std::out_of_range("at: no key");
        return ret;
    }

    template <typename T, typename = panda::enable_if_arithmetic_t<T>>
    Scalar operator[] (T key) const {
        Scalar ret;
        ret.set(_svlist()[key]);
        return ret;
    }

    void store (size_t key, const Scalar& val);
    void store (size_t key, std::nullptr_t) { store(key, Scalar()); }
    void store (size_t key, SV* v)          { store(key, Scalar(v)); }
    void store (size_t key, const Sv& v)    { store(key, Scalar(v)); }
    void store (size_t key, const Array&)   = delete;
    void store (size_t key, const Hash&)    = delete;
    void store (size_t key, const Sub&)     = delete;
    void store (size_t key, const Io&)      = delete;

    template <typename T, typename = panda::enable_if_arithmetic_t<T>>
    KeyProxy operator[] (T key) { return KeyProxy(_svlist() + key, true); }

    bool exists (size_t key) const {
        if (key >= size()) return false;
        return _svlist()[key];
    }

    Scalar del (size_t key) {
        Scalar ret = fetch(key);
        if (ret) (*this)[key] = nullptr;
        return ret;
    }

    size_t  size      () const { return sv ? _size() : 0; }
    size_t  capacity  () const { return sv ? _cap()  : 0; }
    SSize_t top_index () const { return sv ? _topi() : -1; }

    void resize  (size_t newsz)  { av_fill((AV*)sv, (SSize_t)newsz - 1); }
    void reserve (size_t newcap) { av_extend((AV*)sv, (SSize_t)newcap - 1); }

    Scalar shift () {
        if (!sv) return Scalar();
        SV* retsv = av_shift((AV*)sv);
        if (retsv == &PL_sv_undef) return Scalar();
        Scalar ret;
        ret.set(retsv);
        SvREFCNT_dec(retsv); // because av_shift does not decrement, just transfers ownership
        return ret;
    }

    Scalar pop () {
        if (!sv) return Scalar();
        SV* retsv = av_pop((AV*)sv);
        if (retsv == &PL_sv_undef) return Scalar();
        Scalar ret;
        ret.set(retsv);
        SvREFCNT_dec(retsv); // because av_pop does not decrement, just transfers ownership
        return ret;
    }

    void push (const std::initializer_list<Scalar>& l);
    void push (const List& l);
    void push (const Scalar& v);
    void push (const Array&) = delete;
    void push (const Hash&)  = delete;
    void push (const Sub&)   = delete;
    void push (const Io&)    = delete;
    void push (SV* v)        { push(Scalar(v)); }
    void push (const Sv& v)  { push(Scalar(v)); }

    void unshift (const std::initializer_list<Scalar>& l);
    void unshift (const List& l);
    void unshift (const Scalar& v);
    void unshift (const Array&) = delete;
    void unshift (const Hash&)  = delete;
    void unshift (const Sub&)   = delete;
    void unshift (const Io&)    = delete;
    void unshift (SV* v)        { unshift(Scalar(v)); }
    void unshift (const Sv& v)  { unshift(Scalar(v)); }

    void undef () { if (sv) av_undef((AV*)sv); }
    void clear () { if (sv) av_clear((AV*)sv); }

    struct const_iterator {
        using difference_type = std::ptrdiff_t;
        using value_type = const Scalar;
        using pointer = value_type*;
        using reference = value_type&;
        using iterator_category = std::forward_iterator_tag;

        const_iterator ()                          : cur(nullptr) {}
        const_iterator (SV** avfirst)              : cur(avfirst) {}

        const_iterator& operator++ () { ++cur; return *this; }
        const_iterator& operator-- () { --cur; return *this; }

        const_iterator operator++ (int) { const_iterator ret = *this; operator++(); return ret; }
        const_iterator operator-- (int) { const_iterator ret = *this; operator--(); return ret; }

        const_iterator& operator+= (ptrdiff_t n) { cur += n; return *this; }
        const_iterator& operator-= (ptrdiff_t n) { cur -= n; return *this; }

        bool operator== (const const_iterator& oth) const { return cur == oth.cur; }
        bool operator!= (const const_iterator& oth) const { return cur != oth.cur; }

        const Scalar* operator-> () { return (const Scalar*)cur; }
        const Scalar& operator*  () { return *((const Scalar*)cur); }

        ptrdiff_t operator- (const const_iterator& rh) { return cur - rh.cur; }

        bool operator<  (const const_iterator& rh) { return cur < rh.cur; }
        bool operator<= (const const_iterator& rh) { return cur <= rh.cur; }
        bool operator>  (const const_iterator& rh) { return cur > rh.cur; }
        bool operator>= (const const_iterator& rh) { return cur >= rh.cur; }

        const Scalar& operator[] (size_t key) { return *((const Scalar*)(cur+key)); }

    protected:
        SV** cur;
    };

    struct iterator : const_iterator {
        using value_type = const Scalar;
        using pointer = value_type*;
        using reference = value_type&;

        using const_iterator::const_iterator;

        iterator& operator++ () { const_iterator::operator++(); return *this; }
        iterator& operator-- () { const_iterator::operator--(); return *this; }

        iterator operator++ (int) { iterator ret = *this; const_iterator::operator++(); return ret; }
        iterator operator-- (int) { iterator ret = *this; const_iterator::operator--(); return ret; }

        iterator& operator+= (ptrdiff_t n) { const_iterator::operator+=(n); return *this; }
        iterator& operator-= (ptrdiff_t n) { const_iterator::operator-=(n); return *this; }

        Scalar*  operator-> ()           { return (Scalar*)cur; }
        KeyProxy operator*  ()           { return KeyProxy(cur, true); }
        KeyProxy operator[] (size_t key) { return KeyProxy(cur+key, true); }
    };

    const_iterator cbegin () const { return sv ? const_iterator(_svlist()) : const_iterator(); }
    const_iterator cend   () const { return sv ? const_iterator(_svlist()+_size()) : const_iterator(); }
    const_iterator begin  () const { return cbegin(); }
    const_iterator end    () const { return cend(); }
    iterator       begin  ()       { return sv ? iterator(_svlist()) : iterator(); }
    iterator       end    ()       { return sv ? iterator(_svlist()+_size()) : iterator(); }

    U32 push_on_stack (SV** sp, U32 max = 0) const;

private:
    inline SV**    _svlist () const   { return AvARRAY((AV*)sv); }
    inline size_t  _size   () const   { return (size_t)(_topi()+1); }
    inline void    _size   (size_t i) { AvFILLp((AV*)sv) = (SSize_t)i-1; }
    inline size_t  _cap    () const   { return (size_t)(AvMAX((AV*)sv)+1); }
    inline SSize_t _topi   () const   { return AvFILLp((AV*)sv); }

    void _validate () {
        if (!sv) return;
        if (SvTYPE(sv) == SVt_PVAV) return;
        if (SvROK(sv)) {           // reference to array?
            SV* val = SvRV(sv);
            if (SvTYPE(val) == SVt_PVAV) {
                Sv::operator=(val);
                return;
            }
        }
        if (is_undef()) return reset();
        reset();
        throw std::invalid_argument("SV is not an Array or Array reference");
    }
};

inline xs::Array::const_iterator operator+ (const xs::Array::const_iterator& lh, ptrdiff_t rh) { return xs::Array::const_iterator(lh) += rh; }
inline xs::Array::const_iterator operator+ (ptrdiff_t lh, const xs::Array::const_iterator& rh) { return xs::Array::const_iterator(rh) += lh; }
inline xs::Array::const_iterator operator- (const xs::Array::const_iterator& lh, ptrdiff_t rh) { return xs::Array::const_iterator(lh) -= rh; }
inline xs::Array::iterator       operator+ (const xs::Array::iterator& lh, ptrdiff_t rh)       { return xs::Array::iterator(lh) += rh; }
inline xs::Array::iterator       operator+ (ptrdiff_t lh, const xs::Array::iterator& rh)       { return xs::Array::iterator(rh) += lh; }
inline xs::Array::iterator       operator- (const xs::Array::iterator& lh, ptrdiff_t rh)       { return xs::Array::iterator(lh) -= rh; }

struct List : public Array {
    List () {}
    List (SV* sv, bool policy = INCREMENT) : Array(sv, policy) {}
    List (AV* sv, bool policy = INCREMENT) : Array(sv, policy) {}

    List (const Array& oth) : Array(oth)            {}
    List (Array&&      oth) : Array(std::move(oth)) {}
    List (const Sv&    oth) : Array(oth)            {}
    List (Sv&&         oth) : Array(std::move(oth)) {}

    List (const Simple&) = delete;
    List (const Hash&)   = delete;
    List (const Sub&)    = delete;
    List (const Glob&)   = delete;
    List (const Io&)     = delete;

    List& operator= (SV* val)          { Array::operator=(val); return *this; }
    List& operator= (AV* val)          { Array::operator=(val); return *this; }
    List& operator= (const Array& oth) { Array::operator=(oth); return *this; }
    List& operator= (Array&& oth)      { Array::operator=(std::move(oth)); return *this; }
    List& operator= (const Sv& oth)    { Array::operator=(oth); return *this; }
    List& operator= (Sv&& oth)         { Array::operator=(std::move(oth)); return *this; }

    List& operator= (const Simple&) = delete;
    List& operator= (const Hash&)   = delete;
    List& operator= (const Sub&)    = delete;
    List& operator= (const Glob&)   = delete;
    List& operator= (const Io&)     = delete;
};

}

// DEPRECATED, will be removed, use Array.begin()/end() instead
#define XS_AV_ITER(av,code) {                                           \
    SV** list = AvARRAY(av);                                            \
    SSize_t fillp = AvFILLp(av);                                        \
    for (SSize_t i = 0; i <= fillp; ++i) { SV* elem = *list++; code }   \
}
#define XS_AV_ITER_NE(av,code) XS_AV_ITER(av,{if(!elem) continue; code})
#define XS_AV_ITER_NU(av,code) XS_AV_ITER(av,{if(!elem || !SvOK(elem)) continue; code})

