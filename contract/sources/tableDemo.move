module walruii_addr::tables_demo {
  use aptos_framework::table::{Self, Table};
  use std::signer;
  use std::string::String;

  struct Property has store, copy, drop {
    baths: u16,
    beds: u16,
    sqm: u16,
    phy_address: String,
    price: u64,
    available: bool,
  }

  struct PropList has key {
    info: Table<u64, Property>,
    prop_id: u64
  }

  fun register_seller(account: &signer) {
    let init_property = PropList {
      info: table::new(),
      prop_id: 0
    };
    move_to(account, init_property);
  }

  //  baths: u16, beds: u16, sqm: u16, phy_address: String, price: u64
  fun list_property(account: &signer, prop_info: Property) acquires PropList {
    let account_addr = signer::address_of(account);
    assert!(exists<PropList>(account_addr) == true, 101);
    let prop_list = borrow_global_mut<PropList>(account_addr);
    let new_id = prop_list.prop_id + 1;
    table::upsert(&mut prop_list.info, new_id, prop_info);
    prop_list.prop_id = new_id;
  }

  fun read_property(account: signer, prop_id: u64) : (u16,u16,u16,String,u64,bool)
  acquires PropList  {
    let account_addr = signer::address_of(&account);
    assert!(exists<PropList>(account_addr) == true, 101);
    let prop_list = borrow_global<PropList>(account_addr);
    let info = table::borrow(&prop_list.info, prop_id);
    return (info.beds, info.baths, info.sqm, info.phy_address, info.price, info.available)
  }

  // #[test_only]
  // use std::debug::print;
  // #[test_only]
  // use std::string::utf8;
  // #[test(seller1 = @0x123, seller2 = @0x124)]
  // fun test(seller1: signer, seller2: signer) 
  // acquires PropList {
  //   register_seller(&seller1);
  //   let prop_info = Property {
  //     baths: 3,
  //     beds: 2,
  //     sqm: 500,
  //     phy_address: utf8(b"2222 X LANE"),
  //     price: 1000000,
  //     available: true
  //   };
  //   list_property(&seller1, prop_info);
  //   let (beds, baths, sqm, phy_address, price, available) = read_property(seller1, 1);
  //   print(&phy_address);
  //   print(&beds);
  //   print(&sqm);
  //   print(&beds);
  // }

}