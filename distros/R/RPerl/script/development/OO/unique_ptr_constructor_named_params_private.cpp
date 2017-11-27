#include <memory>
#include <iostream>

class MyClass {
private:
    // data members
    int bar = 12;
    int bax = 13;

public:
    // accessors & mutators
    int get_bar() { std::cout << "in bar()..." << std::endl; return bar; }
    int set_bar(int i) { bar = i; }
    int get_bax() { std::cout << "in bax()..." << std::endl; return bax; }
    int set_bax(int i) { bax = i; }

    // allow wrapper class to modify private data members via initializers
    friend class new_MyClass;
};

// wrapper class
class new_MyClass {
public:
    // wrapped object
    std::unique_ptr<MyClass> wrapped_object;

    // constructor w/ initializer list for wrapped_object data member
    new_MyClass() : wrapped_object{new MyClass()} {}
    
    // initializers
    new_MyClass& init_bar(int i) { wrapped_object->bar = i; return *this; }
    new_MyClass& init_bax(int i) { wrapped_object->bax = i; return *this; }

    // move semantics
    std::unique_ptr<MyClass>&& get() { return std::move(wrapped_object); }
};

int main() {
    auto my_object = new_MyClass{}.init_bar(22).init_bax(33).get();
//    std::cout << "in main(), have my_object->bar = " << my_object->bar << std::endl;  // cannot access private data members directly
//    std::cout << "in main(), have my_object->bax = " << my_object->bax << std::endl;  // cannot access private data members directly

    std::cout << "in main(), have my_object->get_bar() = " << my_object->get_bar() << std::endl;
    std::cout << "in main(), have my_object->get_bax() = " << my_object->get_bax() << std::endl;

//    return my_object->bar;  // cannot access private data members directly
    return 23;
}
