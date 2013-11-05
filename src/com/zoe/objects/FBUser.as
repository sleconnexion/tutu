package com.zoe.objects
{
	public class FBUser
	{
		private var _idfb:Number;
		private var _prefix:String;
		private var _user:Object;
		
		public function FBUser()
		{
			_prefix="http://www9.noomiz.com/ruecentrale"
		}
		
		public function get idfb():Number
		{
			return _idfb;
		}
		
		public function set idfb( unidfb:Number):void
		{
			_idfb = unidfb;
		}

		public function get prefix():String
		{
			return _prefix;
		}
		
		public function set prefix( unprefix:String):void
		{
			_prefix = unprefix;
		}		
		public function get user():Object
		{
			return _user;
		}
		
		public function set user( unuser:Object):void
		{
			_user = unuser;
		}
	}
}