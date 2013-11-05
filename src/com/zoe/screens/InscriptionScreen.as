package com.zoe.screens
{
	import com.zoe.objects.Partie;
	
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	
	import starling.display.Quad;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.Color;
	
	[Event(name="testscreen",type="starling.events.Event")]

	public class InscriptionScreen extends Screen
	{
		public var partie:com.zoe.objects.Partie;
		private var txtin:TextInput;
		public function InscriptionScreen()
		{
			super();	
		}
		
		override protected function initialize():void
		{
			trace("homescreen initialize");
//			trace(stage.stageWidth+" "+stage.stageHeight+" "+ stage.fullScreenWidth+" "+stage.fullScreenHeight);

			var q:Quad=new Quad(200,20,Color.WHITE);
			txtin=new TextInput();
			addChild(txtin);
			txtin.backgroundSkin=q;
			txtin.backgroundFocusedSkin=q;
			txtin.backgroundDisabledSkin=q;
			txtin.y=100;
			txtin.setFocus();

			var b:TextField=new TextField(200,20,"input");
			addChild(b);
			b.y=200;
			
			var qq:Quad=new Quad(100,100,Color.BLUE);
			addChild(qq);
			qq.x=200;
			qq.y=250;
			qq.addEventListener(TouchEvent.TOUCH,clickbtn);
		}
		private function clickbtn(ze:TouchEvent):void
		{
			var touches:Vector.<Touch> = ze.getTouches(this,TouchPhase.ENDED);
			if(touches.length == 0) return;
			//here you can access the touches from the touches vector
			trace("clicked");
			trace(txtin.text);
			
		}
				
		// questions loaded
		override protected function draw():void
		{
			trace("draw home");
		}
	}
}