module walruii_addr::SignerDemo {
  use std::signer;
  use std::debug::print;
  use std::string::{utf8};

  const NOT_OWNER: u64 = 0; // ERROR CODE
  const OWNER: address = @walruii_addr;

  fun check_owner(account: signer) {
    let address_val = signer::borrow_address(&account);
    assert!(signer::address_of(&account) == OWNER, NOT_OWNER);
    print(&utf8(b"Owner Confirmed"));
    print(address_val);

  }

  // #[test(account = @0x123)]
  // #[expected_failure]
  // fun testing_check_owner(account: signer) {
  //   check_owner(account);
  // }
  // #[test(account = @walruii_addr)]
  // fun testing_check_owner2(account: signer) {
  //   check_owner(account);
  // }
}