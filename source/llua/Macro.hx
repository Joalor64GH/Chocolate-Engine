package llua;

import haxe.macro.Expr;


class Macro {
	public static macro function loopTable(l:Expr, v:Expr, body:Expr) {
		return macro {
			Lua.pushnil($l);
			while(Lua.next($l, $v < 0 ? $v - 1 : $v) != 0) {
				$body;
				Lua.pop($l, 1);
			}
		}
	}
}