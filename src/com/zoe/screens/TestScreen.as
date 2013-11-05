package com.zoe.screens
{
	import com.zoe.objects.Partie;
	
	import flash.media.StageWebView;
	
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.layout.TiledRowsLayout;
	
	import starling.display.Button;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.utils.Color;
	
	[Event(name="monalbumscreen",type="starling.events.Event")]
	[Event(name="homejeuscreen",type="starling.events.Event")]
	[Event(name="echangerscreen",type="starling.events.Event")]
	[Event(name="lotscreen",type="starling.events.Event")]
	[Event(name="settingsscreen",type="starling.events.Event")]

	public class TestScreen extends Screen
	{
		public static const HOMEJEU_SCREEN:String = "homejeuscreen";
		public static const MONALBUM_SCREEN:String = "monalbumscreen";
		public static const ECHANGER_SCREEN:String = "echangerscreen";
		public static const LOT_SCREEN:String = "lotscreen";
		public static const SETTINGS_SCREEN:String = "settingsscreen";

		private var zs:StageWebView;
		private var _btnsettings:starling.display.Button;

		public var partie:com.zoe.objects.Partie;
		public function TestScreen()
		{
			super();	
		}
		
		override protected function initialize():void
		{
			trace("testscreen initialize");
			_btnsettings=new starling.display.Button(Root.assets.getTexture("btnsettings"));
			_btnsettings.addEventListener(starling.events.Event.TRIGGERED, btnsettingsButton_triggeredHandler);
			addChild(_btnsettings);
			
			var layout:TiledRowsLayout= new TiledRowsLayout();
			
			var container:ScrollContainer= new ScrollContainer();
			container.layout = layout;
			container.width=320;
			container.height=400;
			
			this.addChild( container );
			container.y=50;
			
			layout.paddingTop = 10;
			layout.paddingRight = 5;
			layout.paddingBottom = 10;
			layout.paddingLeft = 5;
			
			layout.gap = 5;
			
			layout.horizontalAlign = TiledRowsLayout.HORIZONTAL_ALIGN_LEFT;
			layout.verticalAlign = TiledRowsLayout.VERTICAL_ALIGN_TOP;
			layout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_CENTER;
			layout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_MIDDLE;
			layout.paging = TiledRowsLayout.PAGING_HORIZONTAL;
			container.scrollerProperties.snapToPages = true;
			
			var quad:Quad=new Quad(300,300,Color.YELLOW);
			container.addChild(quad);
			var quad1:Quad=new Quad(300,300,Color.GREEN);
			container.addChild(quad1);
			var quad2:Quad=new Quad(300,300,Color.RED);
			container.addChild(quad2);
			var quad3:Quad=new Quad(300,300,Color.BLACK);
			container.addChild(quad3);
			var quad4:Quad=new Quad(300,300,Color.BLUE);
			container.addChild(quad4);
			
//			flash.notifications.
			
		}
		
		private function btnsettingsButton_triggeredHandler(event:starling.events.Event):void
		{
			// passer les données
			this.dispatchEventWith("complete");
		}		
		
		
		
		// questions loaded
		override protected function draw():void
		{
			trace("draw test screen");
		}
		private function onError(e):void{
			trace("erreur");
			trace (e);
		}
			}
}