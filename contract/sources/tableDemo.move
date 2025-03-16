module walruii_addr::tables_demo {
  use aptos_framework::table::{Self, Table};
  use std::signer;
  use std::string::String;

  struct Proptery has store, copy, drop {
    baths: u16,
    beds: u16,
    sqm: u16,
    phy_address: String,
    price: u64,
  }

  struct PropList has key {
    info: Table<u64, Property>,
    prop_id: u64
  }

  fun register_seller(account: &signer) {
    let init_property = PropList {
      info: table::new();,
      prop_id: 0
    }
    move_to(account, init_property);
  }

  //  baths: u16, beds: u16, sqm: u16, phy_address: String, price: u64
  fun list_property(account: &signer, prop_info: Property) acquires PropList {
    let account_addr = signer::address_of(account);
    assert!(exists<PropList>(account_addr) == true, 101);
    let prop_list = &mut borrow_global_mut<PropList>(account_addr);
    let new_id = prop_list.prop_id + 1;
    table::upsert(&mut prop_list.info, new_id, prop_info)
    prop_list.prop_id = new_id
  }

  fun read_property(account: signer, prop_id: u64): 
  acquires PropList  {
    let account_addr = signer::address_of(&account);
    assert!(exists<PropList>(account_addr) == true, 101)
    let prop_list = borrow_global<PropList>(account_addr);
    let info = table::borrow(&prop_list.info, prop_id);

  }

}