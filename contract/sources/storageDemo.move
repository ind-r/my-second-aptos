module walruii_addr::StorageDemo {
  use std::signer;
  struct StakePool has key, drop {
    amount: u64
  }

  fun add_user(account: &signer) {
    let amount: u64 = 0;
    move_to(account, StakePool {amount});
  }

  fun remove_user(account: &signer) acquires StakePool {
    move_from<StakePool>(signer::address_of(account));
  }

  fun read_pool(account: address): u64 acquires StakePool {
    borrow_global<StakePool>(account).amount
  }

  fun stake(account: address) acquires StakePool {
    let entry = &mut borrow_global_mut<StakePool>(account).amount;
    *entry = *entry + 100;
  }
  fun unstake(account: address) acquires StakePool {
    let entry = &mut borrow_global_mut<StakePool>(account).amount;
    *entry = 0;
  }

  fun confirm_user(account: address): bool {
    exists<StakePool>(account)
  }

  #[test_only]
  use std::debug::print;
  #[test_only]
  use std::string::utf8;
  // #[test(account = @0x123)]
  fun test_function(account: signer) acquires StakePool {
    add_user(&account);
    assert!(read_pool(signer::address_of(&account)) == 0, 1);
    print(&utf8(b"User added Successfully!"));

    stake(signer::address_of(&account));
    print(&read_pool(signer::address_of(&account)));

    unstake(signer::address_of(&account));
    print(&read_pool(signer::address_of(&account)));

    // let amount_got : u64 = remove_user(&account);
    // print(&amount_got);

    remove_user(&account);

    let is_there = confirm_user(signer::address_of(&account));
    if (is_there == true) {
      print(&utf8(b"User Still Exists!"));
    } 
    else  {
      print(&utf8(b"User Does Not Exists!"));
    }

  }
}