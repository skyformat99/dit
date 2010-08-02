local M = {}

-- signatures of known globals
M.global_signatures = {
  assert = "assert (v [, message])",
  collectgarbage = "collectgarbage (opt [, arg])",
  dofile = "dofile (filename)",
  error = "error (message [, level])",
  _G = "(table)",
  getfenv = "getfenv ([f])",
  getmetatable = "getmetatable (object)",
  ipairs = "ipairs (t)",
  load = "load (func [, chunkname])",
  loadfile = "loadfile ([filename])",
  loadstring = "loadstring (string [, chunkname])",
  next = "next (table [, index])",
  pairs = "pairs (t)",
  pcall = "pcall (f, arg1, ���)",
  print = "print (���)",
  rawequal = "rawequal (v1, v2)",
  rawget = "rawget (table, index)",
  rawset = "rawset (table, index, value)",
  select = "select (index, ���)",
  setfenv = "setfenv (f, table)",
  setmetatable = "setmetatable (table, metatable)",
  tonumber = "tonumber (e [, base])",
  tostring = "tostring (e)",
  type = "type (v)",
  unpack = "unpack (list [, i [, j]])",
  _VERSION = "(string)",
  xpcall = "xpcall (f, err)",
  module = "module (name [, ���])",
  require = "require (modname)",
  coroutine = "(table) coroutine manipulation library",
  debug = "(table) debug facilities library",
  io = "(table) I/O library",
  math = "(table) math functions libary",
  os = "(table) OS facilities library",
  package = "(table) package library",
  string = "(table) string manipulation library",
  table = "(table) table manipulation library",
  ["coroutine.create"] = "coroutine.create (f)",
  ["coroutine.resume"] = "coroutine.resume (co [, val1, ���])",
  ["coroutine.running"] = "coroutine.running ()",
  ["coroutine.status"] = "coroutine.status (co)",
  ["coroutine.wrap"] = "coroutine.wrap (f)",
  ["coroutine.yield"] = "coroutine.yield (���)",
  ["io.close"] = "io.close ([file])",
  ["io.flush"] = "io.flush ()",
  ["io.input"] = "io.input ([file])",
  ["io.lines"] = "io.lines ([filename])",
  ["io.open"] = "io.open (filename [, mode])",
  ["io.output"] = "io.output ([file])",
  ["io.popen"] = "io.popen (prog [, mode])",
  ["io.read"] = "io.read (���)",
  ["io.tmpfile"] = "io.tmpfile ()",
  ["io.type"] = "io.type (obj)",
  ["io.write"] = "io.write (���)",
  ["math.abs"] = "math.abs (x)",
  ["math.acos"] = "math.acos (x)",
  ["math.asin"] = "math.asin (x)",
  ["math.atan"] = "math.atan (x)",
  ["math.atan2"] = "math.atan2 (y, x)",
  ["math.ceil"] = "math.ceil (x)",
  ["math.cos"] = "math.cos (x)",
  ["math.cosh"] = "math.cosh (x)",
  ["math.deg"] = "math.deg (x)",
  ["math.exp"] = "math.exp (x)",
  ["math.floor"] = "math.floor (x)",
  ["math.fmod"] = "math.fmod (x, y)",
  ["math.frexp"] = "math.frexp (x)",
  ["math.huge"] = "math.huge",
  ["math.ldexp"] = "math.ldexp (m, e)",
  ["math.log"] = "math.log (x)",
  ["math.log10"] = "math.log10 (x)",
  ["math.max"] = "math.max (x, ���)",
  ["math.min"] = "math.min (x, ���)",
  ["math.modf"] = "math.modf (x)",
  ["math.pi"] = "math.pi",
  ["math.pow"] = "math.pow (x, y)",
  ["math.rad"] = "math.rad (x)",
  ["math.random"] = "math.random ([m [, n]])",
  ["math.randomseed"] = "math.randomseed (x)",
  ["math.sin"] = "math.sin (x)",
  ["math.sinh"] = "math.sinh (x)",
  ["math.sqrt"] = "math.sqrt (x)",
  ["math.tan"] = "math.tan (x)",
  ["math.tanh"] = "math.tanh (x)",
  ["package.cpath"] = "package.cpath",
  ["package.loaded"] = "package.loaded",
  ["package.loaders"] = "package.loaders",
  ["package.loadlib"] = "package.loadlib (libname, funcname)",
  ["package.path"] = "package.path",
  ["package.preload"] = "package.preload",
  ["package.seeall"] = "package.seeall (module)",
  ["string.byte"] = "string.byte (s [, i [, j]])",
  ["string.char"] = "string.char (���)",
  ["string.dump"] = "string.dump (function)",
  ["string.find"] = "string.find (s, pattern [, init [, plain]])",
  ["string.format"] = "string.format (formatstring, ���)",
  ["string.gmatch"] = "string.gmatch (s, pattern)",
  ["string.gsub"] = "string.gsub (s, pattern, repl [, n])",
  ["string.len"] = "string.len (s)",
  ["string.lower"] = "string.lower (s)",
  ["string.match"] = "string.match (s, pattern [, init])",
  ["string.rep"] = "string.rep (s, n)",
  ["string.reverse"] = "string.reverse (s)",
  ["string.sub"] = "string.sub (s, i [, j])",
  ["string.upper"] = "string.upper (s)",
  ["table.concat"] = "table.concat (table [, sep [, i [, j]]])",
  ["table.insert"] = "table.insert (table, [pos,] value)",
  ["table.maxn"] = "table.maxn (table)",
  ["table.remove"] = "table.remove (table [, pos])",
  ["table.sort"] = "table.sort (table [, comp])",
}

-- functions with zero or nearly zero side-effects, and with deterministic results, that may be evaluated by the analyzer.
M.safe_function = {
  [require] = true,
  [rawequal] = true,
  [rawget] = true,
  [require] = true,  -- sort of
  [select] = true,
  [tonumber] = true,
  [tostring] = true,
  [type] = true,
  [unpack] = true,
  [coroutine.running] = true,
  [coroutine.status] = true,
  [debug.getfenv] = true,
  [debug.gethook] = true,
  [debug.getinfo] = true,
  [debug.getlocal] = true,
  [debug.getmetatable] = true,
  [debug.getregistry] = true,
  [debug.getupvalue] = true,
  -- [debug.traceback] = true,
  [io.type] = true,
  [math.abs] = true,
  [math.acos] = true,
  [math.asin] = true,
  [math.atan] = true,
  [math.atan2] = true,
  [math.ceil] = true,
  [math.cos] = true,
  [math.cosh] = true,
  [math.deg] = true,
  [math.exp] = true,
  [math.floor] = true,
  [math.fmod] = true,
  [math.frexp] = true,
  [math.ldexp] = true,
  [math.log] = true,
  [math.log10] = true,
  [math.max] = true,
  [math.min] = true,
  [math.modf] = true,
  [math.pow] = true,
  [math.rad] = true,
  --math.random
  --math.randomseed
  [math.sin] = true,
  [math.sinh] = true,
  [math.sqrt] = true,
  [math.tan] = true,
  [math.tanh] = true,
  [string.byte] = true,
  [string.char] = true,
  [string.dump] = true,
  [string.find] = true,
  [string.format] = true,
  [string.gmatch] = true,
  [string.gsub] = true,
  [string.len] = true,
  [string.lower] = true,
  [string.match] = true,
  [string.rep] = true,
  [string.reverse] = true,
  [string.sub] = true,
  [string.upper] = true,
  [table.maxn] = true,
}


return M
