module walruii_addr::RefDemo {
  use std::debug::print;

  // Non-Ref Type to Immutable Ref
  fun scenario_1() {
    let value_a = 10;
    let imm_ref: &u64 = &value_a;
    print(imm_ref);
  }
  // Mutable Type to Immutable Ref
  fun scenario_2() {
    let value_a = 10;
    let mut_ref: &mut u64 = &mut value_a;
    let imm_ref: &u64 = mut_ref;
    print(mut_ref);
    print(imm_ref);
  }

  fun re_assign(value_a: &mut u64, value_b: &u64) {
    *value_a = *value_b;
    print(value_a);
  }

  fun scenario_3() {
    let value_a: &mut u64 = &mut 10;
    let value_b: &u64 = &20;
    re_assign(value_a, value_b);
    print(value_a);
  }

  // #[test]
  fun testing_scenario_1() {
    scenario_1();
  }
  // #[test]
  fun testing_scenario_2() {
    scenario_2();
  }
  // #[test]
  fun testing_scenario_3() {
    scenario_3();
  }
  
}