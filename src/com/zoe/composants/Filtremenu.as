package com.zoe.composants
{
	
	import com.zoe.objects.FBUserFactory;
	
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.ScrollContainer;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	import feathers.themes.ZoeMobileTheme;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	[Event(name="closemenud",type="starling.events.Event")]
	[Event(name="closemenudok",type="starling.events.Event")]

	public class Filtremenu extends starling.display.Sprite
	{
		private var listepicto:Array;
		public function Filtremenu()
		{
			super();
			// represente la popup de menu, sous forme d un sprite
			init();
		}
		private function init():void{
			var bgt:Scale9Textures=new Scale9Textures(Root.assets.getTexture("popupmenudroit"),new Rectangle(0,0,250,35));
			var uneimg:Scale9Image=new Scale9Image(bgt);
			addChild(uneimg);
			uneimg.height=450;
			uneimg.width=310;
			
			// header
			var qhdr:Quad=new Quad(307,30,0x000000);
			var labhdr:Label=new Label();
			labhdr.width=310;
			labhdr.text="Filtres";
			labhdr.nameList.add(ZoeMobileTheme.COMMONLABHDRMENU);
			addChild(qhdr);
			addChild(labhdr);
			
			// btn fermer
			var btnclose:Button=new Button();
			btnclose.nameList.add(ZoeMobileTheme.COMMONBTNCLOSE);
			btnclose.x=285;
			btnclose.y=5,
			btnclose.addEventListener(starling.events.Event.TRIGGERED, closeButton_triggeredHandler);
			addChild(btnclose);

			var container:ScrollContainer=new ScrollContainer();
			addChild(container);
			container.width=300;
			container.x=5;
			container.y=30;
			container.height=360;			
			// ajout des boutons selon l ordre suivant
			var tableaupci:Array=[	{id:901,lib:'Auto / moto / vélo'},
				{id:102,lib:'Bars'},
				{id:205,lib:'Bijouterie'},
				{id:402,lib:'Boucherie / charcuterie'},
				{id:403,lib:'Boulangerie / Pâtisserie'},
				{id:504,lib:'Bricolage'},
				{id:406,lib:'Cave à vin'},
				{id:203,lib:'Chaussures'},
				{id:405,lib:'Chocolaterie'},
				{id:303,lib:'Coiffeurs'},
				{id:502,lib:'Décoration'},
				{id:104,lib:'Disco'},
				{id:305,lib:'Fitness'},
				{id:404,lib:'Fromagerie'},
				{id:407,lib:'Fruits & légumes '},
				{id:106,lib:'Gîtes'},
				{id:105,lib:'Hôtel'},
				{id:1101,lib:'Immobilier'},
				{id:302,lib:'Instituts'},
				{id:701,lib:'Jeux / jouets'},
				{id:204,lib:'Maroquinerie'},
				{id:503,lib:'Meubles'},
				{id:801,lib:'Optique'},
				{id:306,lib:'Parapharmacie'},
				{id:304,lib:'Parfumerie'},
				{id:202,lib:'Prêt-à-porter'},
				{id:103,lib:'Restaurant'},
				{id:206,lib:'Sport'},
				{id:601,lib:'Sport / loisirs'},
				{id:1001,lib:'Super / hyper'},
				{id:408,lib:'Traiteur'}];
			listepicto=new Array();
			var filtre:String=FBUserFactory.getUser().user.FILTRECARTO;
			if(filtre){
				for(var i:uint=0;i<tableaupci.length;i++){
	//				trace("bouton=>"+tableaupci[i].id+" lib:"+tableaupci[i].lib);
					var btnpicto:Boutonfiltre=new Boutonfiltre(tableaupci[i].id,tableaupci[i].lib,filtre.charAt(i));
//					btnpicto.nameList.add(ZoeMobileTheme.BOUTONFILTRE);
					
					container.addChild(btnpicto);
					listepicto.push(btnpicto);
					btnpicto.x=8+98*(i%3);
					btnpicto.y=3+98*Math.floor(i/3);
				}
			}
		}
		private function closeButton_triggeredHandler(event:starling.events.Event):void
		{
			trace("click fermer");
			// on met à jour le serveur avec le filtre
			var newchaine:String="";
			for(var i:uint=0;i<listepicto.length;i++){
				var btfiltre:Boutonfiltre=listepicto[i];
				if(btfiltre.issel()){
					newchaine=newchaine+"1";
				} else {
					newchaine=newchaine+"0";
				}
			}
			if(newchaine!=FBUserFactory.getUser().user.FILTRECARTO){
				// necessite une maj coté serveur !! et maj du 
				// fait par le serveur au retour
				FBUserFactory.getUser().user.FILTRECARTO=newchaine;
				this.dispatchEventWith("closemenudok",true);				
			} else {
				this.dispatchEventWith("closemenud",true);
			}			
		}
		
		private function xmlinfosLoaded(event:flash.events.Event):void {
			var loader:URLLoader = URLLoader(event.target);
			var zret:Object =JSON.parse(loader.data);
			if(zret.ok==1){
				trace("xmlinfosLoaded ok");
			}
		}		
	}
}