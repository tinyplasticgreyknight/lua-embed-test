extern crate libc;
extern crate lua;

use lua::ffi::lua_State;
use lua::{State, Function};
use libc::c_int;

#[allow(non_snake_case)]
unsafe extern "C" fn double(L: *mut lua_State) -> c_int {
	let mut state = State::from_ptr(L);
	let num = state.to_number(-1);
	state.push_number(num * 2.0);
	1
}

const VERSIONTEST_LIB: [(&'static str, Function); 1] = [
	("double", Some(double)),
	];

fn convert_state(state_pointer: *mut lua_State) -> State {
	unsafe { State::from_ptr(state_pointer) }
}

#[allow(non_snake_case)]
#[no_mangle]
pub extern "C" fn luaopen_versiontest(L: *mut lua_State) -> c_int {
	let mut state = convert_state(L);
	state.new_lib(&VERSIONTEST_LIB);
	1
}
