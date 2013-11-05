package com.zoe.composants
{
	
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.display.Scale9Image;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	import feathers.themes.ZoeMobileTheme;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	[Event(name="menumsg",type="starling.events.Event")]
	[Event(name="fichecoscreen",type="starling.events.Event")]

	public class Uneactu extends starling.display.Sprite
	{
		private var lactu:Object;
		public function Uneactu(zmsg:Object)
		{
			super();
			// represente la popup de menu, sous forme d un sprite
			lactu=zmsg;
			init();
		}
		private function init():void{
			var bgt:Scale9Textures=new Scale9Textures(Root.assets.getTexture("fondblanc"),new Rectangle(0,15,300,5));
			var uneimg:Scale9Image=new Scale9Image(bgt);
			addChild(uneimg);
			uneimg.height=215;
			uneimg.width=300;
			
			if(lactu.AVATAR){
				trace("Avatar=>not null");
				var icone:ImageLoader = new ImageLoader();
				icone.source = "https://bucketzoe.s3.amazonaws.com/shoppic/"+lactu.AVATAR;
				icone.x=10;
				icone.y=20;
				icone.width=50;
				icone.height=50;
				this.addChild(icone);
			} else {
				trace("Avatar=>null");
				var icoavatr:Image=new Image(Root.assets.getTexture("avatarcarre"));
				icoavatr.x=10;
				icoavatr.y=20;
				icoavatr.width=50;
				icoavatr.height=50;
				this.addChild(icoavatr);
			}
			
			var nomshop:Label=new Label();
			nomshop.nameList.add(ZoeMobileTheme.ACTULABELNOMSHOP);
			nomshop.text=lactu.NOMSHOP+"";
			nomshop.x=70;
			nomshop.width=200;
			addChild(nomshop);
			nomshop.y=20;
			
			var datemsg:Label=new Label();
			datemsg.nameList.add(ZoeMobileTheme.ACTULABELDATEMSG);
			datemsg.text=lactu.DATEPUBLICATION;
			datemsg.x=nomshop.x;
			datemsg.width=200;
			addChild(datemsg);
			datemsg.y=40;
			
			var ficheco:Label=new Label();
			ficheco.nameList.add(ZoeMobileTheme.ACTULABELFC);
			ficheco.text="Fiche commerçant";
			ficheco.x=180;
			ficheco.width=120;
			addChild(ficheco);
			ficheco.y=datemsg.y;
			
			
			var imgficheco:Image=new Image(Root.assets.getTexture("chevronmessage"));
			var btnico:Button=new Button();
			btnico.nameList.add(ZoeMobileTheme.COMMONBTNCHEVRON);
			btnico.defaultSkin = imgficheco;
			btnico.downSkin = imgficheco;
			
			btnico.x=270;
			btnico.y=ficheco.y-2;
			btnico.addEventListener(starling.events.Event.TRIGGERED, coButton_triggeredHandler);
			addChild(btnico);
			
			var ladescription:Sprite=new Sprite();
			var flechedesc:Image=new Image(Root.assets.getTexture("flechemessage"));
			ladescription.addChild(flechedesc);
			flechedesc.x=15;
			var q:Quad=new Quad(280,50,0xFFB600);
			ladescription.addChild(q);
			q.y=flechedesc.height;
			var labdesc:Label=new Label();
			labdesc.nameList.add(ZoeMobileTheme.ACTULABELDESC);
			
			labdesc.text=lactu.DESCRIPTION;
			labdesc.width=260;
			labdesc.height=40;
			ladescription.addChild(labdesc);
			labdesc.x=10;
			labdesc.y=flechedesc.height;
			
			
			addChild(ladescription);
			ladescription.y=71;
			ladescription.x=10;
			
			var imgsab:Image=new Image(Root.assets.getTexture("sablier"));
			addChild(imgsab);
			imgsab.x=10;
			imgsab.y=ladescription.y+ladescription.height+5;
			
			var labvalid:Label=new Label();
			labvalid.nameList.add(ZoeMobileTheme.ACTULABELVALID);
			labvalid.text="Validité";
			labvalid.y=imgsab.y-5;
			labvalid.x=imgsab.x+imgsab.width+5;
			addChild(labvalid);
			var labvaliddu:Label=new Label();
			labvaliddu.nameList.add(ZoeMobileTheme.ACTULABELVALIDDUAU);
			labvaliddu.text=lactu.DTVALIDMIN;
			labvaliddu.y=labvalid.y+labvalid.height+12;
			labvaliddu.x=labvalid.x;
			labvaliddu.width=200;
			addChild(labvaliddu);
			var labvalidau:Label=new Label();
			labvalidau.nameList.add(ZoeMobileTheme.ACTULABELVALIDDUAU);
			labvalidau.text=lactu.DTVALIDMAX;
			labvalidau.y=labvaliddu.y+labvaliddu.height+12;
			labvalidau.x=labvalid.x;
			labvalidau.width=200;
			addChild(labvalidau);
			
			// partage
			var labpartage:Label=new Label();
			labpartage.nameList.add(ZoeMobileTheme.ACTULABELVALID);
			labpartage.text="Partager";
			labpartage.y=imgsab.y-5;
			labpartage.x=165;
			addChild(labpartage);
			var imgtw:Image=new Image(Root.assets.getTexture("partagetwitter"));
			addChild(imgtw);
			imgtw.x=230;
			imgtw.y=labpartage.y+5;
			var imgfb:Image=new Image(Root.assets.getTexture("partagefb"));
			addChild(imgfb);
			imgfb.x=265;
			imgfb.y=labpartage.y+5;
			
			
			// bouton
			var btnetat1:Button=new Button();
			btnetat1.nameList.add(ZoeMobileTheme.ACTUBTNGRIS);
			btnetat1.label="Pas intéressé";
			btnetat1.x=10;
			btnetat1.y=imgfb.y+imgfb.height+20;
			addChild(btnetat1);						
			var btnetat2:Button=new Button();
			btnetat2.nameList.add(ZoeMobileTheme.ACTUBTNBLANC);
			btnetat2.label="Peut-être";
			btnetat2.x=110;
			btnetat2.y=btnetat1.y;
			addChild(btnetat2);			
			var btnetat3:Button=new Button();
			btnetat3.nameList.add(ZoeMobileTheme.ACTUBTNORANGE);
			btnetat3.label="Je viendrai !";
			btnetat3.x=195;
			btnetat3.y=btnetat2.y;
			addChild(btnetat3);			
			
//			addEventListener(TouchEvent.TOUCH,onTouchbtn);
		}	
		private function coButton_triggeredHandler(event:starling.events.Event):void
		{
			// positionner la fiche
			trace("aller vers l idshop:"+lactu.IDTBLSHOP);
			Root.partie.idshop=lactu.IDTBLSHOP;		
			this.dispatchEventWith(Root.FICHECO_SCREEN,true);
		}
	}
}