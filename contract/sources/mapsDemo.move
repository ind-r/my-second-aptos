module walruii_addr::MapsDemo {
  use std::simple_map::{SimpleMap, Self};
  use std::string::{String, utf8};

  fun remove_from_map(my_map: SimpleMap<u64, String>, key: u64): SimpleMap<u64, String> {
    simple_map::remove(&mut my_map, &key);
    return my_map
  }

  fun check_map_length(my_map: SimpleMap<u64, String>): u64 {
    let value = simple_map::length(&mut my_map);
    return value
  }

  fun create_map(): SimpleMap<u64, String>{
    let my_map: SimpleMap<u64, String> = simple_map::create();
    simple_map::add(&mut my_map, 1, utf8(b"UAE"));
    simple_map::add(&mut my_map, 2, utf8(b"USA"));
    simple_map::add(&mut my_map, 3, utf8(b"IND"));
    simple_map::add(&mut my_map, 4, utf8(b"CAD"));
    return my_map
  }

  #[test_only]
  use std::debug::print;
  // #[test]
  fun testing_map() {
    let my_map = create_map();
    let country = simple_map::borrow(&mut my_map, &2);
    print(country);
    let length = check_map_length(my_map);
    print(&length);
    let new_map = remove_from_map(my_map, 2);
    let new_length = check_map_length(new_map);
    print(&new_length);
  }

}