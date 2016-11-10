extern crate lua;

fn main() {
	let mut state = lua::State::new();
	state.open_libs();
	state.do_string("
function load() return require(\"versiontest\") end
local ok, result = pcall(load)
assert(not ok)
print(result)
assert(result == \"multiple lua VMs detected\")
	");
}
