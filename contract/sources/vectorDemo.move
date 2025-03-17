module walruii_addr::VectorDemo {
  use std::vector;
  use std::debug::print as p;

  fun vector_basics(): vector<u64> {
    // init a vector
    let list: vector<u64> = vector::empty<u64>();
    // insert 10 at the end of the vector (last index)
    vector::push_back(&mut list, 10); // [10]
    vector::push_back(&mut list, 20); // [10, 20]
    // store 30 at specified index 2
    vector::insert(&mut list, 2, 30); // [10,20,30] 
    vector::insert(&mut list, 3, 50); // [10,20,30,50]
    vector::insert(&mut list, 3, 20); // [10,20,20,50]
    // swap index 0 with 1
    vector::swap(&mut list, 1, 0);
    // return vector index 2 mutable ref val;
    let value = *vector::borrow_mut(&mut list, 2);
    value = value + 10; // 30
    vector::insert(&mut list, 2 , value);
    //remove element from vector at index 3
    vector::remove(&mut list, 3);
    // return last elemet from vecor and remove it
    vector::pop_back(&mut list);
    list
  }

  fun while_loop_vector(list: vector<u64>): vector<u64> {
    //return vector length
    let length = vector::length(&list);
    let i: u64 = 0;
    while (i < length) {
      let value = vector::borrow(&list, i);
      p(value);
      i = i + 1;
    };
    return list
  }

  fun read_element(element: u64) {
    p(&element);
  }

  fun update_element(element: &mut u64) {
    let value = *element + 1;
    p(&value);
  }

  fun for_each_vector(list: vector<u64>) {
    vector::for_each(list, |list| read_element(list));
    vector::for_each_mut(&mut list, |list| update_element(list));
  }

  #[test]
  fun testing() {
    let list: vector<u64> = vector_basics();
    // returns true if vector contains 10
    // let res = vector::contains(&mut list, &10); // true
    // p(&res);
    //returns true and the indesx of a value
    // let (exist, ind) = vector::index_of(&mut list, &30);
    // p(&exist);
    // p(&ind);
    // let list = while_loop_vector(list);
    for_each_vector(list);
  }


}